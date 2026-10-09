package org.ae.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion implements AutoCloseable {

    private static final String URL = "jdbc:mysql://localhost:3306/tastybite_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASSWORD = "Andresaquinol2010"; // Contraseña actualizada

    private static Conexion instancia;
    private Connection conexion;

    private Conexion() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            this.conexion = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver de MySQL no encontrado", e);
        }
    }

    public static synchronized Conexion getInstance() throws SQLException {
        if (instancia == null || instancia.getConexion().isClosed()) {
            instancia = new Conexion();
        }
        return instancia;
    }

    public Connection getConexion() {
        return conexion;
    }

    @Override
    public void close() {
        if (conexion != null) {
            try {
                conexion.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}