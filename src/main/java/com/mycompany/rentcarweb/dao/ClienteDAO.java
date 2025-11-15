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
import com.mycompany.rentcarweb.model.Cliente;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClienteDAO {

    public List<Cliente> listarTodos() {
        List<Cliente> lista = new ArrayList<>();
        String sql = "SELECT * FROM Clientes"; // si quieres solo activos: WHERE Estado = 1

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Cliente c = new Cliente();
                c.setIdCliente(rs.getInt("IdCliente"));
                int idUsuario = rs.getInt("IdUsuario");
                c.setIdUsuario(rs.wasNull() ? null : idUsuario);
                c.setNombres(rs.getString("Nombres"));
                c.setApellidos(rs.getString("Apellidos"));
                c.setLicencia(rs.getString("Licencia"));
                c.setTelefono(rs.getString("Telefono"));
                c.setCorreo(rs.getString("Correo"));
                c.setDireccion(rs.getString("Direccion"));
                c.setFechaRegistro(rs.getTimestamp("FechaRegistro"));
                c.setEstado(rs.getBoolean("Estado"));
                lista.add(c);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar clientes: " + e.getMessage());
        }

        return lista;
    }

    public Cliente buscarPorId(int idCliente) {
        String sql = "SELECT * FROM Clientes WHERE IdCliente = ?";
        Cliente c = null;

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    c = new Cliente();
                    c.setIdCliente(rs.getInt("IdCliente"));
                    int idUsuario = rs.getInt("IdUsuario");
                    c.setIdUsuario(rs.wasNull() ? null : idUsuario);
                    c.setNombres(rs.getString("Nombres"));
                    c.setApellidos(rs.getString("Apellidos"));
                    c.setLicencia(rs.getString("Licencia"));
                    c.setTelefono(rs.getString("Telefono"));
                    c.setCorreo(rs.getString("Correo"));
                    c.setDireccion(rs.getString("Direccion"));
                    c.setFechaRegistro(rs.getTimestamp("FechaRegistro"));
                    c.setEstado(rs.getBoolean("Estado"));
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar cliente: " + e.getMessage());
        }

        return c;
    }

    public boolean insertar(Cliente c) {
        String sql = "INSERT INTO Clientes (IdUsuario, Nombres, Apellidos, Licencia, Telefono, Correo, Direccion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (c.getIdUsuario() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, c.getIdUsuario());
            }
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setString(4, c.getLicencia());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            ps.setString(7, c.getDireccion());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar cliente: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Cliente c) {
        String sql = "UPDATE Clientes SET IdUsuario=?, Nombres=?, Apellidos=?, Licencia=?, " +
                     "Telefono=?, Correo=?, Direccion=?, Estado=? WHERE IdCliente=?";

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            if (c.getIdUsuario() == null) {
                ps.setNull(1, Types.INTEGER);
            } else {
                ps.setInt(1, c.getIdUsuario());
            }
            ps.setString(2, c.getNombres());
            ps.setString(3, c.getApellidos());
            ps.setString(4, c.getLicencia());
            ps.setString(5, c.getTelefono());
            ps.setString(6, c.getCorreo());
            ps.setString(7, c.getDireccion());
            ps.setBoolean(8, c.isEstado());
            ps.setInt(9, c.getIdCliente());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al actualizar cliente: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idCliente) {
        // si prefieres solo desactivar:
        // String sql = "UPDATE Clientes SET Estado = 0 WHERE IdCliente = ?";
        String sql = "DELETE FROM Clientes WHERE IdCliente = ?";

        try (Connection conn = ConexionBD.getConexion();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idCliente);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al eliminar cliente: " + e.getMessage());
            return false;
        }
    }
}

