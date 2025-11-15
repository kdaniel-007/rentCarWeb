/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.dao;

/**
 *
 * @author KevDev
 */

import com.mycompany.rentcarweb.config.ConexionBD;
import com.mycompany.rentcarweb.model.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UsuarioDAO {

    public Usuario login(String nombreUsuario, String passwordPlano) {
        Usuario usuario = null;

        String sql = "SELECT IdUsuario, NombreUsuario, Correo, Rol, FechaRegistro, Activo " +
                     "FROM Usuarios " +
                     "WHERE NombreUsuario = ? " +
                     "AND ContrasenaHash = dbo.fn_HashPassword(?) " +
                     "AND Activo = 1";

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, nombreUsuario);
            ps.setString(2, passwordPlano);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    usuario = new Usuario();
                    usuario.setIdUsuario(rs.getInt("IdUsuario"));
                    usuario.setNombreUsuario(rs.getString("NombreUsuario"));
                    usuario.setCorreo(rs.getString("Correo"));
                    usuario.setRol(rs.getString("Rol"));
                    usuario.setFechaRegistro(rs.getTimestamp("FechaRegistro"));
                    usuario.setActivo(rs.getBoolean("Activo"));
                }
            }

        } catch (SQLException ex) {
            System.out.println("Error en login UsuarioDAO: " + ex.getMessage());
        }

        return usuario; 
    }

}

