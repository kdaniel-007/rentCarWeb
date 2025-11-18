/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.model;



/**
 *
 * @author aniba
 */
import javax.swing.*;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel;
import org.jfree.chart.JFreeChart;
import org.jfree.data.general.DefaultPieDataset;

public class GraficoPastel {

    public void mostrar() {
        DefaultPieDataset dataset = new DefaultPieDataset();
        dataset.setValue("Vehículos Alquilados", 40);
        dataset.setValue("Vehículos Disponibles", 35);
        dataset.setValue("En Mantenimiento", 15);
        dataset.setValue("Reservados", 10);

        JFreeChart chart = ChartFactory.createPieChart(
                "Estado de los Vehículos",
                dataset,
                true, true, false
        );

        ChartPanel panel = new ChartPanel(chart);
        JFrame ventana = new JFrame("Gráfico de Pastel");
        ventana.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        ventana.setSize(600, 400);
        ventana.add(panel);
        ventana.setVisible(true);
    }
}