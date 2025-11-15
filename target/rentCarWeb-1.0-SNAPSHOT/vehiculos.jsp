<%-- 
    Document   : vehiculos
    Created on : 13 nov 2025, 1:39:47 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Vehiculo> lista = (List<Vehiculo>) request.getAttribute("listaVehiculos");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Gestión de vehículos</title>
    </head>
    <body>
        <h1>Gestión de vehículos</h1>

        <p><a href="<%=request.getContextPath()%>/menu.jsp">Volver al menú</a></p>

        <table border="1" cellpadding="5" cellspacing="0">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Proveedor</th>
                    <th>Marca</th>
                    <th>Tipo</th>
                    <th>Año</th>
                    <th>Placa</th>
                    <th>Transmisión</th>
                    <th>Estado</th>
                    <th>Precio/día</th>
                    <th>Color</th>
                    <th>Kilometraje</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    if (lista != null && !lista.isEmpty()) {
                        for (Vehiculo v : lista) {
                %>
                <tr>
                    <td><%= v.getIdVehiculo()%></td>
                    <td><%= v.getIdProveedor()%></td>
                    <td><%= v.getMarca()%></td>
                    <td><%= v.getTipo()%></td>
                    <td><%= v.getAnio()%></td>
                    <td><%= v.getPlaca()%></td>
                    <td><%= v.getTransmision()%></td>
                    <td><%= v.getEstado()%></td>
                    <td><%= v.getPrecioDia()%></td>
                    <td><%= v.getColor()%></td>
                    <td><%= v.getKilometraje()%></td>
                    <td>
                        <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=editar&id=<%= v.getIdVehiculo()%>">
                            Editar
                        </a>
                        |
                        <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=eliminar&id=<%= v.getIdVehiculo()%>"
                           onclick="return confirm('¿Seguro que deseas eliminar este vehículo?');">
                            Eliminar
                        </a>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <td colspan="12">No hay vehículos registrados.</td>
                </tr>
                <%
                    }
                %>
            </tbody>
