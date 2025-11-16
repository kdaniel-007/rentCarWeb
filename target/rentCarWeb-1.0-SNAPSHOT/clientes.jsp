<%-- 
    Document   : clientes
    Created on : 14 nov 2025, 10:54:36 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Cliente> lista = (List<Cliente>) request.getAttribute("listaClientes");

    request.setAttribute("paginaActiva", "clientes");
    request.setAttribute("tituloPagina", "Gestión de Clientes");
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="layout/head.jsp" />
    <title>Gestión de clientes</title>
</head>
<body class="bg-gray-100 font-sans antialiased">
    <!-- Abre la estructura flex y la barra lateral -->
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="layout/sidebar.jsp" />
       
        <div class="bg-white p-6 rounded-xl shadow-lg w-full">
            <div class="flex flex-col sm:flex-row justify-between items-start sm:items-center mb-6">
                <h3 class="text-2xl font-semibold text-text-dark">Listado de Clientes</h3>
                <a href="${pageContext.request.contextPath}/ClientesServlet?accion=nuevo" 
                   class="mt-4 sm:mt-0 px-4 py-2 bg-success text-white font-medium rounded-lg shadow-md hover:bg-green-700 transition duration-150 flex items-center">
                    <!-- Icono de Lucide: PlusCircle -->
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2"><circle cx="12" cy="12" r="10"/><line x1="12" y1="8" x2="12" y2="16"/><line x1="8" y1="12" x2="16" y2="12"/></svg>
                    Nuevo Cliente
                </a>
            </div>

            <div class="overflow-x-auto shadow-md rounded-lg border border-gray-200">
                <table class="min-w-full divide-y divide-gray-200">
                    <thead class="bg-gray-50">
                        <tr>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">ID</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">IdUsuario</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Nombres</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Licencia</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Teléfono</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Correo</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Estado</th>
                            <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="bg-white divide-y divide-gray-200">
                    <%
                        if (lista != null && !lista.isEmpty()) {
                            for (Cliente c : lista) {
                                String estadoTexto = c.isEstado() ? "Activo" : "Inactivo";
                                String estadoColor = c.isEstado() ? "success" : "danger";
                    %>
                    <tr>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-text-dark"><%= c.getIdCliente() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getIdUsuario() != null ? c.getIdUsuario() : "-" %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getNombres() %> <%= c.getApellidos() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getLicencia() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getTelefono() %></td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-700"><%= c.getCorreo() %></td>
                        <td class="px-6 py-4 whitespace-nowrap">
                            <span class="px-3 inline-flex text-xs leading-5 font-semibold rounded-full bg-<%= estadoColor %>/10 text-<%= estadoColor %>">
                                <%= estadoTexto %>
                            </span>
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="${pageContext.request.contextPath}/ClientesServlet?accion=editar&id=<%= c.getIdCliente() %>" 
                               class="text-primary-accent hover:text-blue-900 mr-3">
                                Editar
                            </a>
                            <a href="${pageContext.request.contextPath}/ClientesServlet?accion=eliminar&id=<%= c.getIdCliente() %>"
                               class="text-danger hover:text-red-700"
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
                        <td colspan="8" class="px-6 py-4 text-center text-sm text-gray-500">No hay clientes registrados.</td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
            </div>
        </div>

        <jsp:include page="layout/footer.jsp" />