package dao;

import exception.AppException;
import java.sql.*;
import java.util.ArrayList;
import model.MenuDimanche;
import utils.Connexion;

public class MenuDimancheDAO {

    public ArrayList<MenuDimanche> getAll() throws AppException {
        ArrayList<MenuDimanche> list = new ArrayList<>();
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, nom_plat, type_repas, date_menu, date_ajout FROM menu_dimanche ORDER BY date_menu DESC, type_repas";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recuperation des menus dimanche", e);
        }
        return list;
    }

    public void insert(String nomPlat, String typeRepas, String dateMenu) throws AppException {
        try {
            Connection conn = Connexion.getConnection();
            String sql = "INSERT INTO menu_dimanche (nom_plat, type_repas, date_menu) VALUES (?, ?, ?::DATE)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, nomPlat);
            ps.setString(2, typeRepas);
            ps.setString(3, dateMenu);
            ps.executeUpdate();
            ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de l'insertion du menu dimanche", e);
        }
    }

    public void delete(int id) throws AppException {
        try {
            Connection conn = Connexion.getConnection();
            String sql = "DELETE FROM menu_dimanche WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
            ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la suppression du menu dimanche", e);
        }
    }

    private MenuDimanche mapRow(ResultSet rs) throws SQLException {
        MenuDimanche m = new MenuDimanche();
        m.setId(rs.getInt("id"));
        m.setNomPlat(rs.getString("nom_plat"));
        m.setTypeRepas(rs.getString("type_repas"));
        m.setDateMenu(rs.getString("date_menu"));
        m.setDateAjout(rs.getString("date_ajout"));
        return m;
    }
}
