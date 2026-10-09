package org.ae.system; // O el paquete exacto donde tengas guardada la clase

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;

import javafx.stage.Stage;

public class main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        Parent root = FXMLLoader.load(getClass().getResource("/org/ae/view/LoginView.xml"));
        primaryStage.setTitle("TastyBite Restaurant - Inicio de Sesión");
        primaryStage.setScene(new Scene(root));
        primaryStage.setResizable(false);
        primaryStage.show();
    }

    // ASEGÚRATE DE QUE ESTA LÍNEA SEA EXACTAMENTE ASÍ:
    public static void main(String[] args) {
        launch(args);
    }
}