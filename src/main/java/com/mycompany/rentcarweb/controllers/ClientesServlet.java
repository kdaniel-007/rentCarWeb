/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

/**
 *
 * @author KevDev
 */
package com.mycompany.rentcarweb.controllers;

import com.mycompany.rentcarweb.dao.ClienteDAO;
import com.mycompany.rentcarweb.model.Cliente;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "ClientesServlet", urlPatterns = {"/ClientesServlet"})
public class ClientesServlet extends HttpServlet {

    private final ClienteDAO clienteDAO = new ClienteDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession sesion = request.getSession(false);
        if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String accion = request.getParameter("accion");
        if (accion == null) accion = "listar";

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
        if (accion == null) accion = "";

        if ("guardar".equals(accion)) {
            guardar(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/ClientesServlet?accion=listar");
        }
    }

    private void listar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Cliente> lista = clienteDAO.listarTodos();
        request.setAttribute("listaClientes", lista);
        request.getRequestDispatcher("clientes.jsp").forward(request, response);
    }

    private void mostrarFormularioNuevo(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute("cliente", new Cliente());
        request.getRequestDispatcher("cliente-form.jsp").forward(request, response);
    }

    private void mostrarFormularioEditar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        Cliente c = clienteDAO.buscarPorId(id);
        if (c == null) {
            response.sendRedirect(request.getContextPath() + "/ClientesServlet?accion=listar");
            return;
        }
        request.setAttribute("cliente", c);
        request.getRequestDispatcher("cliente-form.jsp").forward(request, response);
    }

    private void eliminar(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        int id = Integer.parseInt(request.getParameter("id"));
        clienteDAO.eliminar(id);
        response.sendRedirect(request.getContextPath() + "/ClientesServlet?accion=listar");
    }

    private void guardar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            String idStr = request.getParameter("idCliente");
            int idCliente = (idStr == null || idStr.isBlank()) ? 0 : Integer.parseInt(idStr);

            Cliente c = new Cliente();
            c.setIdCliente(idCliente);

            String idUsuarioStr = request.getParameter("idUsuario");
            if (idUsuarioStr != null && !idUsuarioStr.isBlank()) {
                c.setIdUsuario(Integer.parseInt(idUsuarioStr));
            }

            c.setNombres(request.getParameter("nombres"));
            c.setApellidos(request.getParameter("apellidos"));
            c.setLicencia(request.getParameter("licencia"));
            c.setTelefono(request.getParameter("telefono"));
            c.setCorreo(request.getParameter("correo"));
            c.setDireccion(request.getParameter("direccion"));

            String estadoStr = request.getParameter("estado");
            c.setEstado(estadoStr == null || estadoStr.equals("1") || estadoStr.equalsIgnoreCase("true"));

            boolean ok;
            if (idCliente == 0) {
                ok = clienteDAO.insertar(c);
            } else {
                ok = clienteDAO.actualizar(c);
            }

            if (ok) {
                response.sendRedirect(request.getContextPath() + "/ClientesServlet?accion=listar");
            } else {
                request.setAttribute("error", "No se pudo guardar el cliente");
                request.setAttribute("cliente", c);
                request.getRequestDispatcher("cliente-form.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Datos numéricos inválidos: " + e.getMessage());
            request.getRequestDispatcher("cliente-form.jsp").forward(request, response);
        }
    }
}
