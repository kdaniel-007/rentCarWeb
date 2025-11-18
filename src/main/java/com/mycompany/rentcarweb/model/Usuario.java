/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.model;

/**
 *
 * @author KevDev
 */
import java.util.Date;

public class Usuario {
    private int idUsuario;
    private String nombreUsuario;
    private String correo;
    private String rol;
    private Date fechaRegistro;
    private boolean activo;
    //SAMUEL GOMEZ
    private byte[] contrasenaHash;

    public Usuario() {
    }

    public int getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(int idUsuario) {
        this.idUsuario = idUsuario;
    }

    public String getNombreUsuario() {
        return nombreUsuario;
    }

    public void setNombreUsuario(String nombreUsuario) {
        this.nombreUsuario = nombreUsuario;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public boolean isActivo() {
        return activo;
    }

    public void setActivo(boolean activo) {
        this.activo = activo;
    }
    //SAMUEL GOMEZ
    public byte[] getContrasenaHash() {
        return contrasenaHash;
    }

    public void setContrasenaHash(byte[] contrasenaHash) {
        this.contrasenaHash = contrasenaHash;
    }
}

