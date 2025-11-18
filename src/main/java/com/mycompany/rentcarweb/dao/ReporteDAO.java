/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.dao;

import com.mycompany.rentcarweb.config.ConexionBD;
import com.mycompany.rentcarweb.model.ReporteGeneral;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author aniba
 */
public class ReporteDAO {
      
   private Connection con;
    private PreparedStatement ps;
    private ResultSet rs;

    // ============================================================
    // MÉTODO PRINCIPAL: OBTENER REPORTE ENTRE DOS FECHAS
    // ============================================================
    public List<ReporteGeneral> obtenerReporteGeneral(Date fechaInicio, Date fechaFin) {
        List<ReporteGeneral> lista = new ArrayList<>();

        String sql =
    "SELECT * " +
    "FROM vw_ReporteGeneral " +
    "WHERE FechaInicio >= ? AND FechaInicio <= ? " +
    "ORDER BY FechaInicio DESC";

        try {
            // 🔥 Obtiene la conexión correcta
            con = ConexionBD.getConexion();

            ps = con.prepareStatement(sql);
            ps.setDate(1, fechaInicio);
            ps.setDate(2, fechaFin);

            rs = ps.executeQuery();

            while (rs.next()) {
                ReporteGeneral r = new ReporteGeneral();

                r.setIdReserva(rs.getInt("IdReserva"));
                r.setCliente(rs.getString("Cliente"));
                r.setMarca(rs.getString("Marca"));
                r.setTipo(rs.getString("Tipo"));
                r.setPlaca(rs.getString("Placa"));
                r.setFechaInicio(rs.getDate("FechaInicio"));
                r.setFechaFin(rs.getDate("FechaFin"));
                r.setEstadoReserva(rs.getString("EstadoReserva"));
                r.setFechaPago(rs.getTimestamp("FechaPago"));
                r.setFormaPago(rs.getString("FormaPago"));
                r.setTotalPagado(rs.getDouble("TotalPagado"));

                lista.add(r);
            }

        } catch (Exception e) {
            System.out.println("Error en obtenerReporteGeneral: " + e.getMessage());
        }

        return lista;
    
    }
}
