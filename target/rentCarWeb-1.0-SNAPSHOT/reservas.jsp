<%-- 
    Document   : reservas
    Created on : 14 nov 2025, 11:49:17 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Reserva"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Reserva> lista = (List<Reserva>) request.getAttribute("listaReservas");

    request.setAttribute("paginaActiva", "reservas");
    request.setAttribute("tituloPagina", "Gestión de Reservas");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title>Gestión de reservas</title>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="layout/sidebar.jsp" />


            <div class="bg-white p-6 rounded-xl shadow-lg w-full">
                <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
                    <h3 class="text-2xl font-semibold text-text-dark">Listado de Reservas</h3>
                    <a href="${pageContext.request.contextPath}/ReservasServlet?accion=nuevo" 
                       class="mt-4 sm:mt-0 px-4 py-2 bg-primary-accent text-white font-medium rounded-lg shadow-md hover:bg-blue-700 transition duration-150 flex items-center">
                        <!-- Icono de Lucide: PlusCircle -->
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>
                        Nueva Reserva
                    </a>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-6">
                    <input type="date" class="p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" placeholder="Fecha Inicio">
                    <input type="text" class="p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" placeholder="Buscar Cliente o Vehículo">
                    <select class="p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                        <option value="">Filtrar por Estado</option>
                        <option value="confirmada">Confirmada</option>
                        <option value="pendiente">Pendiente</option>
                        <option value="finalizada">Finalizada</option>
                        <option value="cancelada">Cancelada</option>
                    </select>
                    <button class="px-4 py-3 bg-gray-200 text-gray-700 rounded-lg hover:bg-gray-300 transition duration-150">Aplicar Filtros</button>
                </div>


                <div class="overflow-x-auto shadow-md rounded-lg border border-gray-200">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                            <tr>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Cliente</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Vehículo</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Fechas</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Estado</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Observaciones</th>
                                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Acciones</th>
                            </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                            <%
                                if (lista != null && !lista.isEmpty()) {
                                    for (Reserva r : lista) {
                                        String estado = r.getEstado().toLowerCase();
                                        String estadoColor;

                                        if (estado.equals("confirmada")) {
                                            estadoColor = "success";
                                        } else if (estado.equals("pendiente")) {
                                            estadoColor = "warning";
                                        } else if (estado.equals("cancelada")) {
                                            estadoColor = "danger";
                                        } else {
                                            estadoColor = "gray";
                                        }
                            %>
                            <tr>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-text-dark"><%= r.getIdReserva()%></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= r.getNombreCliente()%></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= r.getDatosVehiculo()%></td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= r.getFechaInicio()%> - <%= r.getFechaFin()%></td>
                                <td class="px-6 py-4 whitespace-nowrap">
                                    <span class="px-3 inline-flex text-xs leading-5 font-semibold rounded-full bg-<%= estadoColor%>/10 text-<%= estadoColor%>">
                                        <%= estado.substring(0, 1).toUpperCase() + estado.substring(1)%>
                                    </span>
                                </td>
                                <td class="px-6 py-4 text-sm text-gray-700 max-w-xs overflow-hidden text-ellipsis whitespace-nowrap" 
                                    title="<%= r.getObservaciones() != null ? r.getObservaciones() : ""%>">
                                    <%= r.getObservaciones() != null && r.getObservaciones().length() > 30 ? r.getObservaciones().substring(0, 30) + "..." : (r.getObservaciones() != null ? r.getObservaciones() : "-")%>
                                </td>
                                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                    <a href="${pageContext.request.contextPath}/ReservasServlet?accion=editar&id=<%= r.getIdReserva()%>"
                                       class="text-primary-accent hover:text-blue-900 mr-2">
                                        Editar
                                    </a>
                                    <% if (!"cancelada".equals(estado) && !"finalizada".equals(estado)) {%>
                                    <a href="${pageContext.request.contextPath}/ReservasServlet?accion=cancelar&id=<%= r.getIdReserva()%>"
                                       class="text-warning hover:text-orange-700 mr-2"
                                       onclick="return confirm('¿Desea cambiar el estado a CANCELADA?');">
                                        Cancelar
                                    </a>
                                    <% }%>
                                    <a href="${pageContext.request.contextPath}/ReservasServlet?accion=eliminar&id=<%= r.getIdReserva()%>"
                                       class="text-danger hover:text-red-700"
                                       onclick="return confirm('¿Seguro que deseas ELIMINAR definitivamente esta reserva?');">
                                        Eliminar
                                    </a>
                                </td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="7" class="px-6 py-4 text-center text-sm text-gray-500">No hay reservas registradas.</td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>

            <jsp:include page="layout/footer.jsp" />