<%-- 
    Document   : vehiculos
    Created on : 13 nov 2025, 1:39:47 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Vehiculo> lista = (List<Vehiculo>) request.getAttribute("listaVehiculos");

    request.setAttribute("paginaActiva", "vehiculos");
    request.setAttribute("tituloPagina", "Gestión de Vehículos");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title>Gestión de vehículos</title>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="layout/sidebar.jsp" />

            <div class="bg-white p-6 rounded-xl shadow-lg w-full">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
                    <h3 class="text-2xl font-semibold text-text-dark">Catálogo de Vehículos</h3>
                    <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=nuevo"
                       class="mt-4 sm:mt-0 px-4 py-2 bg-success text-white font-medium rounded-lg shadow-md hover:bg-green-700 transition duration-150 flex items-center">
                        <!-- Icono de Lucide: PlusCircle -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>
                        Nuevo Vehículo
                    </a>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
                    <%
                        if (lista != null && !lista.isEmpty()) {
                            for (Vehiculo v : lista) {
                                String estado = v.getEstado().toLowerCase();
                                String estadoTexto = estado.substring(0, 1).toUpperCase() + estado.substring(1); // Capitalize
                                String estadoColor = "gray";

                                if (estado.contains("disponible")) {
                                    estadoColor = "success";
                                } else if (estado.contains("rentado")) {
                                    estadoColor = "danger";
                                } else if (estado.contains("mantenimiento")) {
                                    estadoColor = "warning";
                                }
                    %>
                    <div class="bg-white border border-gray-200 rounded-xl shadow-md overflow-hidden hover:shadow-lg transition duration-300 relative">
                        <span class="absolute top-3 left-3 px-3 py-1 text-xs font-semibold rounded-full bg-<%= estadoColor%> text-white z-10">
                            <%= estadoTexto%>
                        </span>
                        <div class="h-40 bg-gray-100 flex items-center justify-center border-b border-gray-200">
                            <span class="text-gray-400 text-sm">
                                <%= v.getMarca()%> <%= v.getTipo()%> 
                            </span>
                        </div>
                        <div class="p-4">
                            <h4 class="text-xl font-bold text-text-dark"><%= v.getMarca()%> <%= v.getTipo()%> (<%= v.getAnio()%>)</h4>
                            <p class="text-sm text-gray-500 mt-1">Placa: <span class="font-medium text-primary-dark"><%= v.getPlaca()%></span></p>
                            <div class="flex justify-between items-center mt-3 pt-3 border-t">
                                <span class="text-lg font-bold text-success">$<%= String.format("%.2f", v.getPrecioDia())%> <span class="text-sm font-normal text-gray-500">/ día</span></span>

                                <div>
                                    <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=editar&id=<%= v.getIdVehiculo()%>" 
                                       class="text-primary-accent hover:underline text-sm font-medium mr-2">
                                        Editar
                                    </a>
                                    <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=eliminar&id=<%= v.getIdVehiculo()%>"
                                       class="text-danger hover:text-red-700 text-sm font-medium"
                                       onclick="return confirm('¿Seguro que deseas eliminar el vehículo <%= v.getPlaca()%>?');">
                                        Eliminar
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    } else {
                    %>
                    <div class="col-span-full bg-gray-50 p-6 rounded-lg text-center text-gray-500">
                        No hay vehículos registrados en el catálogo.
                    </div>
                    <%
                        }
                    %>
                </div>
            </div>

            <jsp:include page="layout/footer.jsp" />