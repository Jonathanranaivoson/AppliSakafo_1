package utils;

import exception.AppException;
import java.sql.Connection;
import java.sql.DriverManager;

public class Connexion {

    private static final String URL = "jdbc:postgresql://localhost:5432/AppliSakafo";
    private static final String USER = "postgres";
    private static final String PASSWORD = "jojo";

    public static Connection getConnection() throws AppException {
        try {
            Class.forName("org.postgresql.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            throw new AppException("Erreur de connexion a la base de donnees", e);
        }
    }
}
