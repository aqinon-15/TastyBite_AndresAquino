package org.ae.util;

import java.time.LocalDateTime;

public class SessionContext {
    private static SessionContext instancia;
    private Integer idUsuario;
    private String nombre;
    private String username;
    private String rol;
    private LocalDateTime horaInicioSesion;

    private SessionContext() {}

    public static synchronized SessionContext getInstance() {
        if (instancia == null) {
            instancia = new SessionContext();
        }
        return instancia;
    }

    public void iniciarSesion(Integer idUsuario, String nombre, String username, String rol) {
        this.idUsuario = idUsuario;
        this.nombre = nombre;
        this.username = username;
        this.rol = rol;
        this.horaInicioSesion = LocalDateTime.now();
    }

    public void cerrarSesion() {
        this.idUsuario = null;
        this.nombre = null;
        this.username = null;
        this.rol = null;
        this.horaInicioSesion = null;
    }

    public Integer getIdUsuario() { return idUsuario; }
    public String getNombre() { return nombre; }
    public String getUsername() { return username; }
    public String getRol() { return rol; }
    public LocalDateTime getHoraInicioSesion() { return horaInicioSesion; }
}