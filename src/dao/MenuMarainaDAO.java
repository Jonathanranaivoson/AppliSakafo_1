package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import exception.AppException;
import model.Boisson;
import model.Maraina;
import model.MenuMaraina;
import utils.Connexion;

public class MenuMarainaDAO {

    private static final String SELECT_JOIN =
        "SELECT mm.id, m.id AS m_id, m.nom AS m_nom, m.groupe AS m_groupe, " +
        "b.id AS b_id, b.nom AS b_nom " +
        "FROM menu_maraina mm " +
        "JOIN maraina m ON mm.id_maraina = m.id " +
        "JOIN boisson b ON mm.id_boisson = b.id";

    public ArrayList<MenuMaraina> getAll() throws AppException {
        ArrayList<MenuMaraina> list = new ArrayList<>();
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_JOIN);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) { list.add(mapRow(rs)); }
            return list;
        } catch (Exception e) {
            throw new AppException("Erreur recuperation menu maraina", e);
        }
    }

    public MenuMaraina getById(int id) throws AppException {
        String sql = SELECT_JOIN + " WHERE mm.id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { return mapRow(rs); }
            }
            return null;
        } catch (Exception e) {
            throw new AppException("Erreur recuperation menu maraina", e);
        }
    }

    private MenuMaraina mapRow(ResultSet rs) throws Exception {
        Maraina m = new Maraina(rs.getInt("m_id"), rs.getString("m_nom"), rs.getInt("m_groupe"));
        Boisson b = new Boisson(rs.getInt("b_id"), rs.getString("b_nom"));
        return new MenuMaraina(rs.getInt("id"), m, b);
    }
}
