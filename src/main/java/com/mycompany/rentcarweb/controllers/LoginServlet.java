/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.mycompany.rentcarweb.controllers;
/**
 *
 * @author KevDev
 */
import com.mycompany.rentcarweb.dao.UsuarioDAO;
import com.mycompany.rentcarweb.model.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    private final UsuarioDAO usuarioDAO = new UsuarioDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usuario = request.getParameter("usuario");
        String password = request.getParameter("password");

        Usuario u = usuarioDAO.login(usuario, password);

        if (u != null) {
            // Login correcto → guardar en sesión y redirigir al menú
            HttpSession sesion = request.getSession();
            sesion.setAttribute("usuarioLogueado", u);

            response.sendRedirect(request.getContextPath() + "/menu.jsp");
        } else {
            // Login incorrecto → regresar al login con mensaje
            request.setAttribute("error", "Usuario o contraseña incorrectos");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Si acceden por GET, solo los mando al login
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
