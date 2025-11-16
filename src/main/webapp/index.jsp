<%-- 
    Document   : index
    Created on : 13 nov 2025, 11:22:44 a. m.
    Author     : KevDev
    Propósito  : Redirigir a Login o al menú si ya está logueado
--%>

<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    Usuario u = (sesion != null) ? (Usuario) sesion.getAttribute("usuarioLogueado") : null;
    
    if (u != null) {
        response.sendRedirect(request.getContextPath() + "/menu.jsp");
    } else {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
%>