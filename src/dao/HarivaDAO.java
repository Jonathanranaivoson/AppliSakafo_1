package dao;

import java.sql.ResultSet;
import model.Hariva;

public class HarivaDAO extends RecetteDAO<Hariva> {

    @Override
    protected String getTableName() { return "hariva"; }

    @Override
    protected Hariva mapRow(ResultSet rs) throws Exception {
        return new Hariva(
            rs.getInt("id"),
            rs.getString("nom"),
            rs.getInt("groupe")
        );
    }
}
