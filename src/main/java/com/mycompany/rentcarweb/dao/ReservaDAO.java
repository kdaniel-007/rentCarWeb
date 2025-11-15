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
import com.mycompany.rentcarweb.model.Reserva;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservaDAO {

    // LISTAR con datos de cliente y vehículo
    public List<Reserva> listarTodas() {
        List<Reserva> lista = new ArrayList<>();

        String sql = "SELECT r.*, "
                + "       c.Nombres, c.Apellidos, "
                + "       v.Marca, v.Tipo, v.Placa "
                + "FROM Reservas r "
                + "INNER JOIN Clientes c ON r.IdCliente = c.IdCliente "
                + "INNER JOIN Vehiculos v ON r.IdVehiculo = v.IdVehiculo";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Reserva r = new Reserva();
                r.setIdReserva(rs.getInt("IdReserva"));
                r.setIdCliente(rs.getInt("IdCliente"));
                r.setIdVehiculo(rs.getInt("IdVehiculo"));
                r.setFechaInicio(rs.getDate("FechaInicio"));
                r.setFechaFin(rs.getDate("FechaFin"));
                r.setEstado(rs.getString("Estado"));
                r.setObservaciones(rs.getString("Observaciones"));
                r.setDocumento(rs.getString("Documento"));
                r.setFechaRegistro(rs.getDate("FechaRegistro"));

                String nombreCliente = rs.getString("Nombres") + " " + rs.getString("Apellidos");
                String datosVehiculo = rs.getString("Marca") + " "
                        + rs.getString("Tipo") + " - "
                        + rs.getString("Placa");

                r.setNombreCliente(nombreCliente);
                r.setDatosVehiculo(datosVehiculo);

                lista.add(r);
            }

        } catch (SQLException e) {
            System.out.println("Error al listar reservas: " + e.getMessage());
        }

        return lista;
    }

    public Reserva buscarPorId(int idReserva) {
        String sql = "SELECT * FROM Reservas WHERE IdReserva = ?";
        Reserva r = null;

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idReserva);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    r = new Reserva();
                    r.setIdReserva(rs.getInt("IdReserva"));
                    r.setIdCliente(rs.getInt("IdCliente"));
                    r.setIdVehiculo(rs.getInt("IdVehiculo"));
                    r.setFechaInicio(rs.getDate("FechaInicio"));
                    r.setFechaFin(rs.getDate("FechaFin"));
                    r.setEstado(rs.getString("Estado"));
                    r.setObservaciones(rs.getString("Observaciones"));
                    r.setDocumento(rs.getString("Documento"));
                    r.setFechaRegistro(rs.getDate("FechaRegistro"));
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al buscar reserva: " + e.getMessage());
        }

        return r;
    }

    // --- CONTROL DE DISPONIBILIDAD ---
    // Devuelve true si el vehículo NO tiene reservas que se crucen en el rango
    public boolean vehiculoDisponible(int idVehiculo, Date inicio, Date fin, Integer idReservaIgnorar) {
        String sql = "SELECT COUNT(*) AS Ocupado "
                + "FROM Reservas "
                + "WHERE IdVehiculo = ? "
                + "AND Estado IN ('pendiente','confirmada') "
                + // <-- CAMBIO AQUÍ
                "AND (FechaInicio <= ? AND FechaFin >= ?)";

        if (idReservaIgnorar != null && idReservaIgnorar > 0) {
            sql += " AND IdReserva <> ?";
        }

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVehiculo);
            ps.setDate(2, fin);     // FechaInicio <= fin
            ps.setDate(3, inicio);  // FechaFin >= inicio

            if (idReservaIgnorar != null && idReservaIgnorar > 0) {
                ps.setInt(4, idReservaIgnorar);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int ocupado = rs.getInt("Ocupado");
                    return ocupado == 0;
                }
            }

        } catch (SQLException e) {
            System.out.println("Error al verificar disponibilidad: " + e.getMessage());
        }

        // Si algo falla, mejor decir que NO está disponible
        return false;
    }

    public boolean insertar(Reserva r) {
        if (!vehiculoDisponible(r.getIdVehiculo(), r.getFechaInicio(), r.getFechaFin(), null)) {
            return false;
        }

        String sql = "INSERT INTO Reservas "
                + "(IdCliente, IdVehiculo, FechaInicio, FechaFin, Estado, Observaciones, Documento) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, r.getIdCliente());
            ps.setInt(2, r.getIdVehiculo());
            ps.setDate(3, r.getFechaInicio());
            ps.setDate(4, r.getFechaFin());
            ps.setString(5, r.getEstado());
            ps.setString(6, r.getObservaciones());
            ps.setString(7, r.getDocumento());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al insertar reserva: " + e.getMessage());
            return false;
        }
    }

    public boolean actualizar(Reserva r) {
        if (!vehiculoDisponible(r.getIdVehiculo(), r.getFechaInicio(), r.getFechaFin(), r.getIdReserva())) {
            return false;
        }

        String sql = "UPDATE Reservas SET "
                + "IdCliente=?, IdVehiculo=?, FechaInicio=?, FechaFin=?, "
                + "Estado=?, Observaciones=?, Documento=? "
                + "WHERE IdReserva=?";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, r.getIdCliente());
            ps.setInt(2, r.getIdVehiculo());
            ps.setDate(3, r.getFechaInicio());
            ps.setDate(4, r.getFechaFin());
            ps.setString(5, r.getEstado());
            ps.setString(6, r.getObservaciones());
            ps.setString(7, r.getDocumento());
            ps.setInt(8, r.getIdReserva());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al actualizar reserva: " + e.getMessage());
            return false;
        }
    }

    public boolean cancelar(int idReserva) {
        String sql = "UPDATE Reservas SET Estado = 'cancelada' WHERE IdReserva = ?";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idReserva);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al cancelar reserva: " + e.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idReserva) {
        String sql = "DELETE FROM Reservas WHERE IdReserva = ?";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idReserva);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            System.out.println("Error al eliminar reserva: " + e.getMessage());
            return false;
        }
    }
}
