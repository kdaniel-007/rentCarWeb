/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;

/**
 *
 * @author KevDev
 */
import com.mycompany.rentcarweb.dao.VehiculoDAO;
import com.mycompany.rentcarweb.model.Vehiculo;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "VehiculosServlet", urlPatterns = {"/VehiculosServlet"})
public class VehiculosServlet extends HttpServlet {

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

        switch (accion) {
            case "guardar":
                guardar(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/VehiculosServlet?accion=listar");
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Vehiculo> lista = vehiculoDAO.listarTodos();
        request.setAttribute("listaVehiculos", lista);
        request.getRequestDispatcher("vehiculos.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("vehiculo", new Vehiculo());
        request.getRequestDispatcher("vehiculo-form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Vehiculo v = vehiculoDAO.buscarPorId(id);

        if (v == null) {
            response.sendRedirect(request.getContextPath() + "/VehiculosServlet?accion=listar");
            return;
        }

        request.setAttribute("vehiculo", v);
        request.getRequestDispatcher("vehiculo-form.jsp").forward(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        vehiculoDAO.eliminar(id);
        response.sendRedirect(request.getContextPath() + "/VehiculosServlet?accion=listar");
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int idVehiculo = 0;
            String idStr = request.getParameter("idVehiculo");
            if (idStr != null && !idStr.isBlank()) {
                idVehiculo = Integer.parseInt(idStr);
            }

            Vehiculo v = new Vehiculo();
            v.setIdVehiculo(idVehiculo);
            v.setIdProveedor(Integer.parseInt(request.getParameter("idProveedor")));
            v.setMarca(request.getParameter("marca"));
            v.setTipo(request.getParameter("tipo"));
            v.setAnio(Integer.parseInt(request.getParameter("anio")));
            v.setPlaca(request.getParameter("placa"));
            v.setTransmision(request.getParameter("transmision"));
            v.setEstado(request.getParameter("estado"));
            v.setPrecioDia(Double.parseDouble(request.getParameter("precioDia")));
            v.setColor(request.getParameter("color"));
            v.setKilometraje(Integer.parseInt(request.getParameter("kilometraje")));

            boolean ok;
            if (idVehiculo == 0) {
                // nuevo
                ok = vehiculoDAO.insertar(v);
            } else {
                // edición
                ok = vehiculoDAO.actualizar(v);
            }

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/VehiculosServlet?accion=listar");
            } else {
                request.setAttribute("error", "No se pudo guardar el vehículo");
                request.setAttribute("vehiculo", v);
                request.getRequestDispatcher("vehiculo-form.jsp").forward(request, response);
            }

        } catch (NumberFormatException ex) {
            request.setAttribute("error", "Datos numéricos inválidos: " + ex.getMessage());
            request.getRequestDispatcher("vehiculo-form.jsp").forward(request, response);
        }
    }
}
