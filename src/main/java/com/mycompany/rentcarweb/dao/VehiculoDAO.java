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
import com.mycompany.rentcarweb.model.Vehiculo;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class VehiculoDAO {

    public List<Vehiculo> listarTodos() {
        List<Vehiculo> lista = new ArrayList<>();

        String sql = "SELECT IdVehiculo, IdProveedor, Marca, Tipo, Anio, Placa, "
                + "Transmision, Estado, PrecioDia, Color, Kilometraje, FechaRegistro "
                + "FROM Vehiculos";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Vehiculo v = new Vehiculo();
                v.setIdVehiculo(rs.getInt("IdVehiculo"));
                v.setIdProveedor(rs.getInt("IdProveedor"));
                v.setMarca(rs.getString("Marca"));
                v.setTipo(rs.getString("Tipo"));
                v.setAnio(rs.getInt("Anio"));
                v.setPlaca(rs.getString("Placa"));
                v.setTransmision(rs.getString("Transmision"));
                v.setEstado(rs.getString("Estado"));
                v.setPrecioDia(rs.getDouble("PrecioDia"));
                v.setColor(rs.getString("Color"));
                v.setKilometraje(rs.getInt("Kilometraje"));
                v.setFechaRegistro(rs.getTimestamp("FechaRegistro"));

                lista.add(v);
            }

        } catch (SQLException ex) {
            System.out.println("Error al listar vehículos: " + ex.getMessage());
        }

        return lista;
    }

    public boolean insertar(Vehiculo v) {
        String sql = "INSERT INTO Vehiculos "
                + "(IdProveedor, Marca, Tipo, Anio, Placa, Transmision, Estado, PrecioDia, Color, Kilometraje) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, v.getIdProveedor());
            ps.setString(2, v.getMarca());
            ps.setString(3, v.getTipo());
            ps.setInt(4, v.getAnio());
            ps.setString(5, v.getPlaca());
            ps.setString(6, v.getTransmision());
            ps.setString(7, v.getEstado());
            ps.setDouble(8, v.getPrecioDia());
            ps.setString(9, v.getColor());
            ps.setInt(10, v.getKilometraje());

            int filas = ps.executeUpdate();
            return filas > 0;

        } catch (SQLException ex) {
            System.out.println("Error al insertar vehículo: " + ex.getMessage());
            return false;
        }
    }

    public Vehiculo buscarPorId(int idVehiculo) {
        String sql = "SELECT IdVehiculo, IdProveedor, Marca, Tipo, Anio, Placa, "
                + "Transmision, Estado, PrecioDia, Color, Kilometraje, FechaRegistro "
                + "FROM Vehiculos WHERE IdVehiculo = ?";
        Vehiculo v = null;

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVehiculo);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    v = new Vehiculo();
                    v.setIdVehiculo(rs.getInt("IdVehiculo"));
                    v.setIdProveedor(rs.getInt("IdProveedor"));
                    v.setMarca(rs.getString("Marca"));
                    v.setTipo(rs.getString("Tipo"));
                    v.setAnio(rs.getInt("Anio"));
                    v.setPlaca(rs.getString("Placa"));
                    v.setTransmision(rs.getString("Transmision"));
                    v.setEstado(rs.getString("Estado"));
                    v.setPrecioDia(rs.getDouble("PrecioDia"));
                    v.setColor(rs.getString("Color"));
                    v.setKilometraje(rs.getInt("Kilometraje"));
                    v.setFechaRegistro(rs.getTimestamp("FechaRegistro"));
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error al buscar vehículo: " + ex.getMessage());
        }
        return v;
    }

    public boolean actualizar(Vehiculo v) {
        String sql = "UPDATE Vehiculos SET "
                + "IdProveedor=?, Marca=?, Tipo=?, Anio=?, Placa=?, "
                + "Transmision=?, Estado=?, PrecioDia=?, Color=?, Kilometraje=? "
                + "WHERE IdVehiculo=?";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, v.getIdProveedor());
            ps.setString(2, v.getMarca());
            ps.setString(3, v.getTipo());
            ps.setInt(4, v.getAnio());
            ps.setString(5, v.getPlaca());
            ps.setString(6, v.getTransmision());
            ps.setString(7, v.getEstado());
            ps.setDouble(8, v.getPrecioDia());
            ps.setString(9, v.getColor());
            ps.setInt(10, v.getKilometraje());
            ps.setInt(11, v.getIdVehiculo());

            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("Error al actualizar vehículo: " + ex.getMessage());
            return false;
        }
    }

    public boolean eliminar(int idVehiculo) {
        String sql = "DELETE FROM Vehiculos WHERE IdVehiculo = ?";

        try (Connection conn = ConexionBD.getConexion(); PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, idVehiculo);
            return ps.executeUpdate() > 0;

        } catch (SQLException ex) {
            System.out.println("Error al eliminar vehículo: " + ex.getMessage());
            return false;
        }
    }

}
