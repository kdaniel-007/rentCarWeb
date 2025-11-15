<%-- 
    Document   : clientes
    Created on : 14 nov 2025, 10:54:36 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Cliente> lista = (List<Cliente>) request.getAttribute("listaClientes");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de clientes</title>
    </head>
    <body>
        <h1>Gestión de clientes</h1>

        <p><a href="<%=request.getContextPath()%>/menu.jsp">Volver al menú</a></p>
        <p><a href="${pageContext.request.contextPath}/ClientesServlet?accion=nuevo">Nuevo cliente</a></p>

        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
            <tr>
                <th>ID</th>
                <th>IdUsuario</th>
                <th>Nombres</th>
                <th>Apellidos</th>
                <th>Licencia</th>
                <th>Teléfono</th>
                <th>Correo</th>
                <th>Dirección</th>
                <th>Estado</th>
                <th>Acciones</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (lista != null && !lista.isEmpty()) {
                    for (Cliente c : lista) {
            %>
            <tr>
                <td><%= c.getIdCliente() %></td>
                <td><%= c.getIdUsuario() != null ? c.getIdUsuario() : "" %></td>
                <td><%= c.getNombres() %></td>
                <td><%= c.getApellidos() %></td>
                <td><%= c.getLicencia() %></td>
                <td><%= c.getTelefono() %></td>
                <td><%= c.getCorreo() %></td>
                <td><%= c.getDireccion() %></td>
                <td><%= c.isEstado() ? "Activo" : "Inactivo" %></td>
                <td>
                    <a href="${pageContext.request.contextPath}/ClientesServlet?accion=editar&id=<%= c.getIdCliente() %>">Editar</a>
                    |
                    <a href="${pageContext.request.contextPath}/ClientesServlet?accion=eliminar&id=<%= c.getIdCliente() %>"
                       onclick="return confirm('¿Seguro que deseas eliminar este cliente?');">
                        Eliminar
                    </a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="10">No hay clientes registrados.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </body>
</html>
