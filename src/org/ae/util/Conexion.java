package org.ae.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Conexion implements AutoCloseable {

    // CAMBIAR 'tastybite_db' POR 'libreriadb_in4cm'
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/libreriadb_in4cm?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static final String USER = "IN4CM";
    private static final String PASSWORD = "#NdimAM4";

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