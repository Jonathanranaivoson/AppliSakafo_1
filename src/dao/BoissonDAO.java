package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import exception.AppException;
import model.Boisson;
import utils.Connexion;

public class BoissonDAO {

    public ArrayList<Boisson> getAll() throws AppException {
        ArrayList<Boisson> list = new ArrayList<>();
        String sql = "SELECT * FROM boisson";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) { list.add(mapRow(rs)); }
            return list;
        } catch (Exception e) {
            throw new AppException("Erreur de recuperation des boissons", e);
        }
    }

    public Boisson getById(int id) throws AppException {
        String sql = "SELECT * FROM boisson WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { return mapRow(rs); }
            }
            return null;
        } catch (Exception e) {
            throw new AppException("Erreur de recuperation boisson", e);
        }
    }

    private Boisson mapRow(ResultSet rs) throws Exception {
        return new Boisson(rs.getInt("id"), rs.getString("nom"));
    }
}
