package dao;

import exception.AppException;
import java.sql.*;
import java.util.ArrayList;
import model.SemaineGroupe;
import utils.Connexion;

public class SemaineGroupeDAO {

    public ArrayList<SemaineGroupe> getAll() throws AppException {
        ArrayList<SemaineGroupe> list = new ArrayList<>();
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, groupe, date_debut, date_fin FROM semaines_groupe ORDER BY groupe";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }
            rs.close(); ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recuperation des semaines", e);
        }
        return list;
    }

    public SemaineGroupe getByGroupe(int groupe) throws AppException {
        try {
            Connection conn = Connexion.getConnection();
            String sql = "SELECT id, groupe, date_debut, date_fin FROM semaines_groupe WHERE groupe = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, groupe);
            ResultSet rs = ps.executeQuery();
            SemaineGroupe sg = null;
            if (rs.next()) {
                sg = mapRow(rs);
            }
            rs.close(); ps.close(); conn.close();
            return sg;
        } catch (Exception e) {
            throw new AppException("Erreur lors de la recuperation de la semaine du groupe " + groupe, e);
        }
    }

    public void update(int groupe, String dateDebut, String dateFin) throws AppException {
        try {
            Connection conn = Connexion.getConnection();
            String sql = "UPDATE semaines_groupe SET date_debut = ?, date_fin = ? WHERE groupe = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setDate(1, Date.valueOf(dateDebut));
            ps.setDate(2, Date.valueOf(dateFin));
            ps.setInt(3, groupe);
            ps.executeUpdate();
            ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de la mise a jour de la semaine du groupe " + groupe, e);
        }
    }

    public void insert(int groupe, String dateDebut, String dateFin) throws AppException {
        try {
            Connection conn = Connexion.getConnection();
            String sql = "INSERT INTO semaines_groupe (groupe, date_debut, date_fin) VALUES (?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, groupe);
            ps.setDate(2, Date.valueOf(dateDebut));
            ps.setDate(3, Date.valueOf(dateFin));
            ps.executeUpdate();
            ps.close(); conn.close();
        } catch (Exception e) {
            throw new AppException("Erreur lors de l'insertion de la semaine du groupe " + groupe, e);
        }
    }

    private SemaineGroupe mapRow(ResultSet rs) throws SQLException {
        SemaineGroupe sg = new SemaineGroupe();
        sg.setId(rs.getInt("id"));
        sg.setGroupe(rs.getInt("groupe"));
        sg.setDateDebut(rs.getString("date_debut"));
        sg.setDateFin(rs.getString("date_fin"));
        return sg;
    }
}
