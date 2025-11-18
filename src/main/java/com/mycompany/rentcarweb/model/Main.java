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
import java.awt.*;


public class Main extends JFrame {

    public Main() {
        setTitle("Sistema de Gestión de Alquiler de Vehículos - Módulo de Gráficos");
        setSize(800, 600);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLocationRelativeTo(null);
        setLayout(new BorderLayout());

        // Título superior
        JLabel lblTitulo = new JLabel("Módulo 3 - Gráficos del Sistema", SwingConstants.CENTER);
        lblTitulo.setFont(new Font("Segoe UI", Font.BOLD, 24));
        add(lblTitulo, BorderLayout.NORTH);

        // Botón para mostrar gráfico de pastel
        JButton btnGraficoPastel = new JButton("Mostrar Gráfico de Pastel");
        btnGraficoPastel.addActionListener(e -> {
            GraficoPastel grafico = new GraficoPastel();
            grafico.mostrar();
        });

        // Panel central
        JPanel panelCentro = new JPanel();
        panelCentro.add(btnGraficoPastel);
        add(panelCentro, BorderLayout.CENTER);
    }

    public static void main(String[] args) {
        SwingUtilities.invokeLater(() -> {
            new Main().setVisible(true);
        });
    }
}

