    /*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
     */
    package com.mycompany.rentcarweb.controllers;

import com.mycompany.rentcarweb.dao.ReporteDAO;
import com.mycompany.rentcarweb.model.ReporteGeneral;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(name = "ReporteServlet", urlPatterns = {"/ReporteServlet"})
public class ReporteServlet extends HttpServlet {

    private final ReporteDAO reporteDAO = new ReporteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1️⃣ Obtener parámetros
        String fi = request.getParameter("fechaInicio");
        String ff = request.getParameter("fechaFin");

        // 2️⃣ Validar que NO vengan vacías
        if (fi == null || fi.isEmpty() || ff == null || ff.isEmpty()) {
            request.setAttribute("error", "Debe seleccionar ambas fechas.");
            request.getRequestDispatcher("reporteGeneral.jsp").forward(request, response);
            return;
        }

        try {
            // 3️⃣ Convertir fechas
            Date fechaInicio = Date.valueOf(fi);
            Date fechaFin = Date.valueOf(ff);

            // 4️⃣ Obtener datos del reporte
            List<ReporteGeneral> datos = reporteDAO.obtenerReporteGeneral(fechaInicio, fechaFin);

            // 5️⃣ Enviar datos al JSP
            request.setAttribute("listaReporte", datos);
            request.setAttribute("fechaInicio", fi);
            request.setAttribute("fechaFin", ff);

        } catch (IllegalArgumentException e) {
            // ❗ Si Date.valueOf falla, caemos aquí
            request.setAttribute("error", "Formato de fecha inválido.");
        }

        // 6️⃣ Enviar control al JSP SIEMPRE
        request.getRequestDispatcher("reporteGeneral.jsp").forward(request, response);
    }
}
