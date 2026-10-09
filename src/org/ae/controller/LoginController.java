package org.ae.controller;

import javafx.fxml.FXML;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.control.Alert;
import org.ae.dao.IUsuarioDAO;
import org.ae.dao.impl.UsuarioDAOImpl;
import org.ae.model.Usuario;
import org.ae.util.SessionContext;

public class LoginController {
    @FXML private TextField txtUsername;
    @FXML private PasswordField txtPassword;

    private final IUsuarioDAO usuarioDAO = new UsuarioDAOImpl();

    @FXML
    public void handleLogin() {
        String user = txtUsername.getText().trim();
        String pass = txtPassword.getText().trim();

        if (user.isEmpty() || pass.isEmpty()) {
            mostrarAlerta("Campos Requeridos", "Por favor ingresa usuario y contraseña.");
            return;
        }

        Usuario usuario = usuarioDAO.autenticar(user, pass);
        if (usuario != null) {
            SessionContext.getInstance().iniciarSesion(
                usuario.getIdUsuario(),
                usuario.getNombre(),
                usuario.getUsername(),
                usuario.getRol()
            );
            mostrarAlerta("Bienvenido", "Sesión iniciada como: " + usuario.getNombre() + " (" + usuario.getRol() + ")");
        } else {
            mostrarAlerta("Error de Autenticación", "Usuario o contraseña incorrectos.");
        }
    }

    private void mostrarAlerta(String titulo, String mensaje) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(titulo);
        alert.setHeaderText(null);
        alert.setContentText(mensaje);
        alert.showAndWait();
    }
}