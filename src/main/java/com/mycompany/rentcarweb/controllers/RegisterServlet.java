/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;

import com.mycompany.rentcarweb.dao.UsuarioDAO;
import com.mycompany.rentcarweb.model.Usuario;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    private byte[] hashPassword(String password) throws NoSuchAlgorithmException {
        MessageDigest md = MessageDigest.getInstance("SHA-256");
        return md.digest(password.getBytes());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String correo = request.getParameter("correo");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        if (usuario == null || correo == null || password == null || rol == null ||
            usuario.isEmpty() || correo.isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "Todos los campos son obligatorios");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // EVITAR que el usuario se registre como admin
        if ("admin".equalsIgnoreCase(rol)) {
            request.setAttribute("error", "No puedes crear usuarios administradores.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        try {
            Usuario nuevo = new Usuario();
            nuevo.setNombreUsuario(usuario);
            nuevo.setCorreo(correo);
            nuevo.setContrasenaHash(hashPassword(password));
            nuevo.setRol(rol);
            nuevo.setActivo(true);

            boolean registrado = usuarioDAO.registrar(nuevo);

            if (registrado) {
                response.sendRedirect(request.getContextPath() + "/login.jsp?msg=cuenta_creada");
            } else {
                request.setAttribute("error", "Este usuario o correo ya existe.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Error interno al registrar.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}