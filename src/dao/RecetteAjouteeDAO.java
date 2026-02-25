package dao;

import exception.AppException;
import java.sql.*;
import java.util.ArrayList;
import model.RecetteAjoutee;
import utils.Connexion;

public class RecetteAjouteeDAO {

    public ArrayList<RecetteAjoutee> getAll() throws AppException {
        ArrayList<RecetteAjoutee> list = new ArrayList<>();
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, nom, type_repas, date_ajout FROM recette_ajoutee ORDER BY date_ajout DESC, id DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recuperation des recettes ajoutees", e);
        }
        return list;
    }



    public ArrayList<RecetteAjoutee> getByType(String typeRepas) throws AppException {
        ArrayList<RecetteAjoutee> list = new ArrayList<>();
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, nom, type_repas, date_ajout FROM recette_ajoutee WHERE type_repas = ? ORDER BY nom";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, typeRepas);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recuperation des recettes de type " + typeRepas, e);
        }
        return list;
    }



    public ArrayList<RecetteAjoutee> searchByNom(String query) throws AppException {
        ArrayList<RecetteAjoutee> list = new ArrayList<>();
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, nom, type_repas, date_ajout FROM recette_ajoutee WHERE LOWER(nom) LIKE LOWER(?) ORDER BY nom";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recherche des recettes ajoutees", e);
        }
        return list;
    }



    public void insert(String nom, String typeRepas, int boissonId) throws AppException {
        Connection conn = null;
        try {
            conn = Connexion.getConnection();
            conn.setAutoCommit(false);

            // 1. Insert into recette_ajoutee
            String sql = "INSERT INTO recette_ajoutee (nom, type_repas) VALUES (?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nom);
            ps.setString(2, typeRepas);
            ps.executeUpdate();
            ps.close();

            // 2. Also insert into original table so recipe appears in modification dropdowns
            if ("dejeuner".equals(typeRepas)) {
                PreparedStatement ps2 = conn.prepareStatement(
                    "INSERT INTO atoandro(nom, groupe) VALUES (?, 0)");
                ps2.setString(1, nom);
                ps2.executeUpdate();
                ps2.close();

            } else if ("diner".equals(typeRepas)) {
                PreparedStatement ps2 = conn.prepareStatement(
                    "INSERT INTO hariva(nom, groupe) VALUES (?, 0)");
                ps2.setString(1, nom);
                ps2.executeUpdate();
                ps2.close();

            } else if ("petit-dejeuner".equals(typeRepas)) {
                // Insert into maraina + create menu_maraina with chosen boisson
                PreparedStatement ps2 = conn.prepareStatement(
                    "INSERT INTO maraina(nom, groupe) VALUES (?, 0) RETURNING id");
                ps2.setString(1, nom);
                ResultSet rs2 = ps2.executeQuery();
                int marainaId = 0;
                if (rs2.next()) marainaId = rs2.getInt(1);
                rs2.close(); ps2.close();

                // Use the boisson chosen by the user
                if (boissonId <= 0) {
                    PreparedStatement ps3 = conn.prepareStatement(
                        "SELECT id FROM boisson ORDER BY id LIMIT 1");
                    ResultSet rs3 = ps3.executeQuery();
                    if (rs3.next()) boissonId = rs3.getInt(1);
                    rs3.close(); ps3.close();
                }

                if (marainaId > 0 && boissonId > 0) {
                    PreparedStatement ps4 = conn.prepareStatement(
                        "INSERT INTO menu_maraina(id_maraina, id_boisson) VALUES (?, ?)");
                    ps4.setInt(1, marainaId);
                    ps4.setInt(2, boissonId);
                    ps4.executeUpdate();
                    ps4.close();
                }
            }

            conn.commit();
        } catch (Exception e) {
            if (conn != null) try { conn.rollback(); } catch (Exception ex) {}
            throw new AppException("Erreur lors de l'insertion de la recette", e);
        } finally {
            if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (Exception ex) {}
        }
    }



    private RecetteAjoutee mapRow(ResultSet rs) throws SQLException {
        RecetteAjoutee r = new RecetteAjoutee();
        r.setId(rs.getInt("id"));
        r.setNom(rs.getString("nom"));
        r.setTypeRepas(rs.getString("type_repas"));
        r.setDateAjout(rs.getString("date_ajout"));
        return r;
    }
}
