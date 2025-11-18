/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.dao;

import com.mycompany.rentcarweb.config.ConexionBD;
import com.mycompany.rentcarweb.model.Pago;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;


public class PagoDao {

    // Crear pago
    public boolean crearPago(Pago pago) throws SQLException {
        String sql = "INSERT INTO Pagos (IdReserva, FechaPago, FormaPago, TipoPago, Monto, Impuestos, Descuento, Estado) "
                   + "VALUES (?,?,?,?,?,?,?,?)";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setInt(1, pago.getIdReserva());
            ps.setTimestamp(2, new Timestamp(pago.getFechaPago().getTime()));
            ps.setString(3, pago.getFormaPago());
            ps.setString(4, pago.getTipoPago());
            ps.setBigDecimal(5, pago.getMonto());
            ps.setBigDecimal(6, pago.getImpuestos() == null ? BigDecimal.ZERO : pago.getImpuestos());
            ps.setBigDecimal(7, pago.getDescuento() == null ? BigDecimal.ZERO : pago.getDescuento());
            ps.setString(8, pago.getEstado() == null ? "pagado" : pago.getEstado());

            int affected = ps.executeUpdate();
            if (affected == 0) return false;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) pago.setIdPago(rs.getInt(1));
            }
            return true;
        }
    }

    // Pagos entre fechas
    public List<Pago> obtenerPagosPorFechaRange(Date inicio, Date fin) throws SQLException {
        String sql = "SELECT * FROM Pagos WHERE FechaPago BETWEEN ? AND ? AND Estado = 'pagado' ORDER BY FechaPago";

        List<Pago> lista = new ArrayList<>();

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setTimestamp(1, new Timestamp(inicio.getTime()));
            ps.setTimestamp(2, new Timestamp(fin.getTime()));

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Pago p = mapPago(rs);
                    lista.add(p);
                }
            }
        }

        return lista;
    }

    // Convertir un registro en un objeto Pago
    private Pago mapPago(ResultSet rs) throws SQLException {
        Pago p = new Pago();

        p.setIdPago(rs.getInt("IdPago"));
        p.setIdReserva(rs.getInt("IdReserva"));

        Timestamp ts = rs.getTimestamp("FechaPago");
        if (ts != null) {
            p.setFechaPago(new Date(ts.getTime()));  // <--- CORRECCIÓN IMPORTANTE
        }

        p.setFormaPago(rs.getString("FormaPago"));
        p.setTipoPago(rs.getString("TipoPago"));
        p.setMonto(rs.getBigDecimal("Monto"));
        p.setImpuestos(rs.getBigDecimal("Impuestos"));
        p.setDescuento(rs.getBigDecimal("Descuento"));
        p.setTotal(rs.getBigDecimal("Total"));
        p.setEstado(rs.getString("Estado"));

        return p;
    }

    // Ingresos por mes
    public List<IngresoMes> obtenerIngresosPorMes() throws SQLException {
        String sql = "SELECT YEAR(FechaPago) AS Anio, MONTH(FechaPago) AS Mes, SUM(Total) AS Ingresos "
                   + "FROM Pagos WHERE Estado='pagado' "
                   + "GROUP BY YEAR(FechaPago), MONTH(FechaPago) "
                   + "ORDER BY Anio, Mes";

        List<IngresoMes> lista = new ArrayList<>();

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(new IngresoMes(
                        rs.getInt("Anio"),
                        rs.getInt("Mes"),
                        rs.getBigDecimal("Ingresos")
                ));
            }
        }

        return lista;
    }

    // Clase interna
    public static class IngresoMes {
        public int anio;
        public int mes;
        public BigDecimal ingresos;

        public IngresoMes(int a, int m, BigDecimal i) {
            anio = a;
            mes = m;
            ingresos = i;
        }
    }
}
