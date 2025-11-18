/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.dao;

import com.mycompany.rentcarweb.config.ConexionBD;
import com.mycompany.rentcarweb.model.ReporteGrafico;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


/**
 *
 * @author aniba
 */
public class ReportesGraficoDAO {

   public List<ReporteGrafico> obtenerDatos() {
        List<ReporteGrafico> lista = new ArrayList<>();

        String sql =
            "SELECT Marca, COUNT(*) AS Cantidad "
          + "FROM Vehiculos "
          + "GROUP BY Marca "
          + "ORDER BY Cantidad DESC";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ReporteGrafico r = new ReporteGrafico();
                r.setMarca(rs.getString("Marca"));
                r.setCantidad(rs.getInt("Cantidad"));
                lista.add(r);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }
}
