package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import exception.AppException;
import model.Recette;
import utils.Connexion;

public abstract class RecetteDAO<T extends Recette> {

    protected abstract String getTableName();

    protected abstract T mapRow(ResultSet rs) throws Exception;

    public ArrayList<T> getAll() throws AppException {
        return executeList("SELECT * FROM " + getTableName());
    }

    public T getById(int id) throws AppException {
        return executeOne(
            "SELECT * FROM " + getTableName() + " WHERE id = ?", id
        );
    }

    public ArrayList<T> getByGroupe(int groupe) throws AppException {
        return executeList(
            "SELECT * FROM " + getTableName() + " WHERE groupe = ?", groupe
        );
    }

    public ArrayList<T> searchByNom(String query) throws AppException {
        return executeList(
            "SELECT * FROM " + getTableName() + " WHERE LOWER(nom) LIKE LOWER(?)",
            "%" + query + "%"
        );
    }

    protected ArrayList<T> executeList(String sql, Object... params) throws AppException {
        ArrayList<T> list = new ArrayList<>();
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) { list.add(mapRow(rs)); }
            }
            return list;
        } catch (Exception e) {
            throw new AppException("Erreur de recuperation des donnees", e);
        }
    }

    protected T executeOne(String sql, Object... params) throws AppException {
        try (Connection conn = Connexion.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            setParams(ps, params);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { return mapRow(rs); }
            }
            return null;
        } catch (Exception e) {
            throw new AppException("Erreur de recuperation", e);
        }
    }

    private void setParams(PreparedStatement ps, Object... params) throws Exception {
        for (int i = 0; i < params.length; i++) {
            ps.setObject(i + 1, params[i]);
        }
    }
}
