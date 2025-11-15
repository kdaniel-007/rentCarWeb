/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;

/**
 *
 * @author KevDev
 */
import com.mycompany.rentcarweb.config.ConexionBD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TestConexionServlet", urlPatterns = {"/test-conexion"})
public class TestConexionServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {

            out.println("<html><body>");
            out.println("<h2>Prueba de conexión a RentCarDB</h2>");

            try (Connection conn = ConexionBD.getConexion()) {
                if (conn != null && !conn.isClosed()) {
                    out.println("<p style='color:green;'>✔ Conexión exitosa a la base de datos.</p>");
                } else {
                    out.println("<p style='color:red;'>✖ No se pudo abrir la conexión.</p>");
                }
            } catch (SQLException ex) {
                out.println("<p style='color:red;'>Error SQL: " + ex.getMessage() + "</p>");
            }

            out.println("</body></html>");
        }
    }

}

