package mx.edu.utez.ucq.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MySQLConnection {
    final String DBNAME = "ucq_chido",
            USER = "root",
            PASSWORD = "root",
            TIMEZONE = "America/Mexico_City",
            USESSL = "false",
            PUBLICKEY = "true",
<<<<<<< Updated upstream
            DDLAUTO = "true", HOST = "localhost";
=======
            DDLAUTO = "true",
            HOST = "localhost";
>>>>>>> Stashed changes

    public Connection connect() {
        String dataSource = String.format("jdbc:mysql://%s:3306/%s?user=%s&password=%s&serverTimezone=%s&useSSL=%s&allowPublicKeyRetrieval=%s&createDatabaseIfNotExist=%s", HOST, DBNAME, USER, PASSWORD, TIMEZONE, USESSL , PUBLICKEY, DDLAUTO);
        try {
            DriverManager.registerDriver(new com.mysql.cj.jdbc.Driver());
            return DriverManager.getConnection(dataSource);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        try {
            Connection coon = new MySQLConnection().connect();
            if (coon != null) {
                System.out.println("Connexion Realizada");
                coon.close();
            } else {
                System.out.println("Connexxion Fallida");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}