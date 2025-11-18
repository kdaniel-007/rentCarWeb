/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;

/**
 *
 * @author KevDev
 */
import com.mycompany.rentcarweb.dao.ClienteDAO;
import com.mycompany.rentcarweb.dao.ReservaDAO;
import com.mycompany.rentcarweb.dao.VehiculoDAO;
import com.mycompany.rentcarweb.model.Cliente;
import com.mycompany.rentcarweb.model.Reserva;
import com.mycompany.rentcarweb.model.Vehiculo;

import java.io.IOException;
import java.sql.Date;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ReservasServlet", urlPatterns = {"/ReservasServlet"})
public class ReservasServlet extends HttpServlet {

    private final ReservaDAO reservaDAO = new ReservaDAO();
    private final ClienteDAO clienteDAO = new ClienteDAO();
    private final VehiculoDAO vehiculoDAO = new VehiculoDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "listar";
        }

        switch (accion) {
            case "nuevo":
                mostrarFormularioNuevo(request, response);
                break;
            case "editar":
                mostrarFormularioEditar(request, response);
                break;
            case "cancelar":
                cancelar(request, response);
                break;
            case "eliminar":
                eliminar(request, response);
                break;
            case "listar":
            default:
                listar(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");
        if (accion == null) {
            accion = "";
        }

        if ("guardar".equals(accion)) {
            guardar(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/ReservasServlet?accion=listar");
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Reserva> lista = reservaDAO.listarTodas();
        request.setAttribute("listaReservas", lista);
        request.getRequestDispatcher("reservas.jsp").forward(request, response);
    }

    private void cargarCombos(HttpServletRequest request) {
        List<Cliente> clientes = clienteDAO.listarTodos();
        List<Vehiculo> vehiculos = vehiculoDAO.listarTodos();
        request.setAttribute("listaClientes", clientes);
        request.setAttribute("listaVehiculos", vehiculos);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        cargarCombos(request);
        request.setAttribute("reserva", new Reserva());
        request.getRequestDispatcher("reserva-form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Reserva r = reservaDAO.buscarPorId(id);
        if (r == null) {
            response.sendRedirect(request.getContextPath() + "/ReservasServlet?accion=listar");
            return;
        }
        cargarCombos(request);
        request.setAttribute("reserva", r);
        request.getRequestDispatcher("reserva-form.jsp").forward(request, response);
    }

    private void cancelar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        reservaDAO.cancelar(id);
        response.sendRedirect(request.getContextPath() + "/ReservasServlet?accion=listar");
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        reservaDAO.eliminar(id);
        response.sendRedirect(request.getContextPath() + "/ReservasServlet?accion=listar");
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("idReserva");
            int idReserva = (idStr == null || idStr.isBlank()) ? 0 : Integer.parseInt(idStr);

            int idCliente = Integer.parseInt(request.getParameter("idCliente"));
            int idVehiculo = Integer.parseInt(request.getParameter("idVehiculo"));

            Date fechaInicio = Date.valueOf(request.getParameter("fechaInicio"));
            Date fechaFin = Date.valueOf(request.getParameter("fechaFin"));

            String estado = request.getParameter("estado");
            if (estado == null || estado.isBlank()) {
                estado = "pendiente";
            }

            String observaciones = request.getParameter("observaciones");
            String documento = request.getParameter("documento");

            Reserva r = new Reserva();
            r.setIdReserva(idReserva);
            r.setIdCliente(idCliente);
            r.setIdVehiculo(idVehiculo);
            r.setFechaInicio(fechaInicio);
            r.setFechaFin(fechaFin);
            r.setEstado(estado);
            r.setObservaciones(observaciones);
            r.setDocumento(documento);

            boolean ok;
            if (idReserva == 0) {
                ok = reservaDAO.insertar(r);
            } else {
                ok = reservaDAO.actualizar(r);
            }

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/ReservasServlet?accion=listar");
            } else {
                request.setAttribute("error", "No se pudo guardar la reserva. Verifique disponibilidad del vehículo y los datos.");
                cargarCombos(request);
                request.setAttribute("reserva", r);
                request.getRequestDispatcher("reserva-form.jsp").forward(request, response);
            }

        } catch (IllegalArgumentException e) {
            request.setAttribute("error", "Datos inválidos: " + e.getMessage());
            cargarCombos(request);
            request.getRequestDispatcher("reserva-form.jsp").forward(request, response);
        }
    }
}
