/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;


import com.mycompany.rentcarweb.dao.ReportesGraficoDAO;
import com.mycompany.rentcarweb.model.ReporteGrafico;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "GraficosServlet", urlPatterns = {"/graficos"})
public class GraficoVehiculoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        ReportesGraficoDAO dao = new ReportesGraficoDAO();
        List<ReporteGrafico> datos = dao.obtenerDatos();

        request.setAttribute("datos", datos);

        String vista = request.getParameter("view");

        switch (vista) {
            case "pastel":
                request.getRequestDispatcher("GraficoPastel.jsp").forward(request, response);
                break;

            case "interactivo":
                request.getRequestDispatcher("GraficoInteractivo.jsp").forward(request, response);
                break;

            default:
                request.getRequestDispatcher("GraficoBarras.jsp").forward(request, response);
                break;
        }
    }
}
