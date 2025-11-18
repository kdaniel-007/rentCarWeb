/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;

import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
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


@WebServlet(name = "ReportePDFServlet", urlPatterns = {"/ReportePDFServlet"})
public class ReportePDFServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String fi = request.getParameter("fechaInicio");
            String ff = request.getParameter("fechaFin");

            if (fi == null || ff == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST,
                        "Faltan parámetros fechaInicio/fechaFin");
                return;
            }

            Date fechaInicio = Date.valueOf(fi);
            Date fechaFin = Date.valueOf(ff);

            ReporteDAO dao = new ReporteDAO();
            List<ReporteGeneral> lista = dao.obtenerReporteGeneral(fechaInicio, fechaFin);

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=ReporteGeneral.pdf");

            Document documento = new Document();
            PdfWriter.getInstance(documento, response.getOutputStream());
            documento.open();

            // Título
            Font tituloFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16);
            Paragraph titulo = new Paragraph("Reporte General de Reservas y Pagos\n\n", tituloFont);
            titulo.setAlignment(Element.ALIGN_CENTER);
            documento.add(titulo);

            // Tabla
            PdfPTable tabla = new PdfPTable(11);
            tabla.setWidthPercentage(100);

            String[] headers = {
                "ID Reserva", "Cliente", "Marca", "Tipo", "Placa",
                "F. Inicio", "F. Fin", "Estado", "Fecha Pago",
                "Forma Pago", "Total Pagado"
            };

            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10);

            // Encabezados con color
            for (String h : headers) {
    PdfPCell celda = new PdfPCell(new Phrase(h, headerFont));
    celda.setGrayFill(0.85f); // 0.0 (negro) a 1.0 (blanco) — 0.85 es gris claro
    tabla.addCell(celda);
}


            // Filas
            Font rowFont = FontFactory.getFont(FontFactory.HELVETICA, 9);

            for (ReporteGeneral r : lista) {
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(r.getIdReserva()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getCliente()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getMarca()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getTipo()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getPlaca()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(r.getFechaInicio()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(r.getFechaFin()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getEstadoReserva()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(String.valueOf(r.getFechaPago()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase(nullSafe(r.getFormaPago()), rowFont)));
                tabla.addCell(new PdfPCell(new Phrase("$ " + String.format("%.2f", r.getTotalPagado()), rowFont)));
            }

            documento.add(tabla);
            documento.close();

        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Error generando PDF: " + ex.getMessage());
        }
    }

    private String nullSafe(String s) {
        return s == null ? "" : s;
    }
}
