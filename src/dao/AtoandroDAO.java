package dao;

import java.sql.ResultSet;
import model.Atoandro;

public class AtoandroDAO extends RecetteDAO<Atoandro> {

    @Override
    protected String getTableName() { return "atoandro"; }

    @Override
    protected Atoandro mapRow(ResultSet rs) throws Exception {
        return new Atoandro(
            rs.getInt("id"),
            rs.getString("nom"),
            rs.getInt("groupe")
        );
    }
}
