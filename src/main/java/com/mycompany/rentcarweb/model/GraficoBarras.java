/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author aniba
 */
package com.mycompany.rentcarweb.model;

import com.mycompany.rentcarweb.config.ConexionBD;
import java.awt.Color;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import javax.swing.JFrame;

public class GraficoBarras extends JFrame {

    public GraficoBarras() {
        setTitle("Vehículos por Estado");
        setSize(800, 600);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

        // Dataset (los datos del gráfico)
        DefaultCategoryDataset dataset = obtenerDatos();

        // Crear el gráfico
        JFreeChart chart = ChartFactory.createBarChart(
                "Cantidad de Vehículos por Estado", // título
                "Estado", // eje X
                "Cantidad", // eje Y
                dataset, // datos
                PlotOrientation.VERTICAL, // orientación
                true, true, false // leyenda, tooltips, urls
        );

        // Personalizar colores y diseño
        CategoryPlot plot = chart.getCategoryPlot();
        plot.setRangeGridlinePaint(Color.BLACK);
        plot.setBackgroundPaint(Color.WHITE);
        plot.setOutlinePaint(Color.GRAY);

        // Panel para mostrar el gráfico
        ChartPanel panel = new ChartPanel(chart);
        setContentPane(panel);
    }

    // Método que consulta la base de datos
    private DefaultCategoryDataset obtenerDatos() {
        DefaultCategoryDataset dataset = new DefaultCategoryDataset();

        String sql = "SELECT Estado, COUNT(*) AS Cantidad FROM Vehiculos GROUP BY Estado";

        try (Connection con = ConexionBD.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String estado = rs.getString("Estado");
                int cantidad = rs.getInt("Cantidad");
                dataset.addValue(cantidad, "Vehículos", estado);
            }

        } catch (Exception e) {
            System.out.println("Error al obtener datos para el gráfico: " + e.getMessage());
        }

        return dataset;
    }

    // Main para probar el gráfico
    public static void main(String[] args) {
        java.awt.EventQueue.invokeLater(() -> {
            new GraficoBarras().setVisible(true);
        });
    }
}
