package dao;

import java.sql.ResultSet;
import model.DinerExtra;

public class DinerExtraDAO extends RecetteDAO<DinerExtra> {

    @Override
    protected String getTableName() { return "diner_extra"; }

    @Override
    protected DinerExtra mapRow(ResultSet rs) throws Exception {
        return new DinerExtra(
            rs.getInt("id"),
            rs.getString("nom")
        );
    }
}
