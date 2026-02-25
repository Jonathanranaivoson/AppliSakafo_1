package dao;

import java.sql.ResultSet;
import model.Maraina;

public class MarainaDAO extends RecetteDAO<Maraina> {

    @Override
    protected String getTableName() { return "maraina"; }

    @Override
    protected Maraina mapRow(ResultSet rs) throws Exception {
        return new Maraina(
            rs.getInt("id"),
            rs.getString("nom"),
            rs.getInt("groupe")
        );
    }
}
