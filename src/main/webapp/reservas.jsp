<%-- 
    Document   : reservas
    Created on : 14 nov 2025, 11:49:17 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Reserva"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Reserva> lista = (List<Reserva>) request.getAttribute("listaReservas");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestión de reservas</title>
</head>
<body>
<h1>Gestión de reservas</h1>

<p><a href="<%=request.getContextPath()%>/menu.jsp">Volver al menú</a></p>
<p><a href="${pageContext.request.contextPath}/ReservasServlet?accion=nuevo">Nueva reserva</a></p>

<table border="1" cellpadding="5" cellspacing="0">
    <thead>
    <tr>
        <th>ID</th>
        <th>Cliente</th>
        <th>Vehículo</th>
        <th>Fecha inicio</th>
        <th>Fecha fin</th>
        <th>Estado</th>
        <th>Observaciones</th>
        <th>Documento</th>
        <th>Acciones</th>
    </tr>
    </thead>
    <tbody>
    <%
        if (lista != null && !lista.isEmpty()) {
            for (Reserva r : lista) {
    %>
    <tr>
        <td><%= r.getIdReserva() %></td>
        <td><%= r.getNombreCliente() %></td>
        <td><%= r.getDatosVehiculo() %></td>
        <td><%= r.getFechaInicio() %></td>
        <td><%= r.getFechaFin() %></td>
        <td><%= r.getEstado() %></td>
        <td><%= r.getObservaciones() != null ? r.getObservaciones() : "" %></td>
        <td><%= r.getDocumento() != null ? r.getDocumento() : "" %></td>
        <td>
            <a href="${pageContext.request.contextPath}/ReservasServlet?accion=editar&id=<%= r.getIdReserva() %>">
                Editar
            </a>
            |
            <a href="${pageContext.request.contextPath}/ReservasServlet?accion=cancelar&id=<%= r.getIdReserva() %>">
                Cancelar
            </a>
            |
            <a href="${pageContext.request.contextPath}/ReservasServlet?accion=eliminar&id=<%= r.getIdReserva() %>"
               onclick="return confirm('¿Seguro que deseas eliminar esta reserva?');">
                Eliminar
            </a>
        </td>
    </tr>
    <%
            }
        } else {
    %>
    <tr>
        <td colspan="9">No hay reservas registradas.</td>
    </tr>
    <%
        }
    %>
    </tbody>
</table>
</body>
</html>
