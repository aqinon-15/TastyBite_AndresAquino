package org.ae.dao.impl;

import org.ae.dao.IUsuarioDAO;
import org.ae.model.Usuario;
import org.ae.util.Conexion;

import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAOImpl implements IUsuarioDAO {
    @Override
    public Usuario autenticar(String username, String password) {
        String sql = "{call sp_validar_usuario(?, ?)}";
        try (Conexion conn = Conexion.getInstance();
             CallableStatement cs = conn.getConexion().prepareCall(sql)) {

            cs.setString(1, username);
            cs.setString(2, password);

            try (ResultSet rs = cs.executeQuery()) {
                if (rs.next()) {
                    return new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("username"),
                        rs.getString("nombre_rol")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}