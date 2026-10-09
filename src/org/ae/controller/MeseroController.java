package org.ae.controller;

import javafx.fxml.FXML;
import javafx.scene.control.*;
import org.ae.util.Conexion;
import org.ae.util.SessionContext;

import java.sql.CallableStatement;
import java.sql.Types;

public class MeseroController {

    @FXML private ComboBox<Integer> cbMesas;
    @FXML private TextField txtPlatilloId;
    @FXML private TextField txtCantidad;
    @FXML private TextField txtObservacion;
    @FXML private Label lblEstado;

    @FXML
    public void handleCrearPedido() {
        Integer mesaSeleccionada = cbMesas.getValue();
        if (mesaSeleccionada == null) {
            mostrarAlerta("Error", "Seleccione una mesa para abrir el pedido.");
            return;
        }

        String sql = "{call sp_crear_pedido(?, ?, ?)}";
        try (Conexion conn = Conexion.getInstance();
             CallableStatement cs = conn.getConexion().prepareCall(sql)) {

            cs.setInt(1, mesaSeleccionada);
            cs.setInt(2, SessionContext.getInstance().getIdUsuario());
            cs.registerOutParameter(3, Types.INTEGER);

            cs.execute();
            int idPedidoGenerado = cs.getInt(3);

            lblEstado.setText("Pedido #" + idPedidoGenerado + " abierto correctamente.");
            mostrarAlerta("Éxito", "Comanda aperturada con ID: " + idPedidoGenerado);

        } catch (Exception e) {
            e.printStackTrace();
            mostrarAlerta("Error de BD", "No se pudo crear el pedido: " + e.getMessage());
        }
    }

    private void mostrarAlerta(String titulo, String msg) {
        Alert alert = new Alert(Alert.AlertType.INFORMATION);
        alert.setTitle(titulo);
        alert.setHeaderText(null);
        alert.setContentText(msg);
        alert.showAndWait();
    }
}