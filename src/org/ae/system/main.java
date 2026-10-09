package org.ae.system;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;

public class main extends Application {

    @Override
    public void start(Stage primaryStage) throws Exception {
        // Carga la vista de Login ubicada en la carpeta org/ae/view/
        Parent root = FXMLLoader.load(getClass().getResource("/org/ae/view/LoginView.fxml"));
        
        primaryStage.setTitle("TastyBite Restaurant - Inicio de Sesión");
        primaryStage.setScene(new Scene(root));
        primaryStage.setResizable(false);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }
}