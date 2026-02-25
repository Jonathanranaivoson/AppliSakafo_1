package dao;

import exception.AppException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.*;
import utils.Connexion;

public class MenuJournalierDAO {

    private static final String SELECT_JOIN =
        "SELECT mj.id, mj.groupe, mj.jour, mj.fait, mj.date_fait, " +
        "mm.id AS mm_id, m.id AS m_id, m.nom AS m_nom, m.groupe AS m_groupe, " +
        "b.id AS b_id, b.nom AS b_nom, " +
        "a.id AS a_id, a.nom AS a_nom, a.groupe AS a_groupe, " +
        "h.id AS h_id, h.nom AS h_nom, h.groupe AS h_groupe " +
        "FROM menu_journalier mj " +
        "JOIN menu_maraina mm ON mj.id_menu_maraina = mm.id " +
        "JOIN maraina m ON mm.id_maraina = m.id " +
        "JOIN boisson b ON mm.id_boisson = b.id " +
        "JOIN atoandro a ON mj.id_atoandro = a.id " +
        "JOIN hariva h ON mj.id_hariva = h.id";

    public ArrayList<MenuJournalier> getByGroupe(int groupe) throws AppException {
        String sql = SELECT_JOIN + " WHERE mj.groupe = ? ORDER BY mj.jour";
        ArrayList<MenuJournalier> list = new ArrayList<>();
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, groupe);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) { list.add(mapRow(rs)); }
            }
            return list;
        } catch (Exception e) {
            throw new AppException("Erreur recuperation menu journalier", e);
        }
    }

    

    public void cocherFait(int id, boolean fait) throws AppException {
        String sql = fait
            ? "UPDATE menu_journalier SET fait = true, date_fait = CURRENT_DATE WHERE id = ?"
            : "UPDATE menu_journalier SET fait = false, date_fait = NULL WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new AppException("Erreur mise a jour fait", e);
        }
    }



    public void updateAtoandro(int menuId, int newAtoandroId) throws AppException {
        String sql = "UPDATE menu_journalier SET id_atoandro = ? WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newAtoandroId);
            ps.setInt(2, menuId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new AppException("Erreur modification dejeuner", e);
        }
    }


    public void updateHariva(int menuId, int newHarivaId) throws AppException {
        String sql = "UPDATE menu_journalier SET id_hariva = ? WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newHarivaId);
            ps.setInt(2, menuId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new AppException("Erreur modification diner", e);
        }
    }

    public void updateMenuMaraina(int menuId, int newMenuMarainaId) throws AppException {
        String sql = "UPDATE menu_journalier SET id_menu_maraina = ? WHERE id = ?";
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newMenuMarainaId);
            ps.setInt(2, menuId);
            ps.executeUpdate();
        } catch (Exception e) {
            throw new AppException("Erreur modification petit-dejeuner", e);
        }
    }
    

    private MenuJournalier mapRow(ResultSet rs) throws Exception {
        MenuJournalier mj = new MenuJournalier();
        mj.setId(rs.getInt("id"));
        mj.setGroupe(rs.getInt("groupe"));
        mj.setJour(rs.getInt("jour"));
        mj.setFait(rs.getBoolean("fait"));
        mj.setDateFait(rs.getString("date_fait"));

        Maraina m = new Maraina(rs.getInt("m_id"), rs.getString("m_nom"), rs.getInt("m_groupe"));
        Boisson b = new Boisson(rs.getInt("b_id"), rs.getString("b_nom"));
        mj.setMenuMaraina(new MenuMaraina(rs.getInt("mm_id"), m, b));

        mj.setAtoandro(new Atoandro(rs.getInt("a_id"), rs.getString("a_nom"), rs.getInt("a_groupe")));
        mj.setHariva(new Hariva(rs.getInt("h_id"), rs.getString("h_nom"), rs.getInt("h_groupe")));
        return mj;
    }
}
