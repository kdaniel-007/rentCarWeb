<%-- 
    Document   : menu
    Created on : 13 nov 2025, 12:37:57 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    Usuario u = null;
    if (sesion != null) {
        u = (Usuario) sesion.getAttribute("usuarioLogueado");
    }
    if (u == null) {
        // Si no hay usuario en sesión, redirigir al login
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Menú principal - RentCarWeb</title>
    </head>
    <body>
        <h1>Menú principal</h1>
        <p>Bienvenido, <strong><%= u.getNombreUsuario()%></strong> (Rol: <%= u.getRol()%>)</p>

        <ul>
            <li><a href="#">Gestión de reservas</a></li>
            <li><a href="#">Reportes</a></li>
            <li>
                <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=listar">
                    Gestión de vehículos
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/ClientesServlet?accion=listar">
                    Gestión de clientes
                </a>
            </li>

            <li>
                <a href="${pageContext.request.contextPath}/ReservasServlet?accion=listar">
                    Gestión de reservas
                </a>
            </li>
        </ul>

        <p>
            <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=nuevo">
                Agregar vehículo
            </a>
        </p>


        <p><a href="${pageContext.request.contextPath}/LogoutServlet">Cerrar sesión</a></p>
    </body>
</html>
