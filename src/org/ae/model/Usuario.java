package org.ae.model;

public class Usuario {
    private int idUsuario;
    private String nombre;
    private String username;
    private String rol;

    public Usuario(int idUsuario, String nombre, String username, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.username = username;
        this.rol = rol;
    }

    public int getIdUsuario() { return idUsuario; }
    public String getNombre() { return nombre; }
    public String getUsername() { return username; }
    public String getRol() { return rol; }
}