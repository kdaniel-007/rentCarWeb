<%-- 
    Document   : cliente-form
    Created on : 14 nov 2025, 10:55:44 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Cliente c = (Cliente) request.getAttribute("cliente");
    if (c == null) {
        c = new Cliente();
    }
    boolean esEdicion = c.getIdCliente() > 0;
    
    request.setAttribute("paginaActiva", "clientes");
    request.setAttribute("tituloPagina", esEdicion ? "Editar Cliente" : "Nuevo Cliente");
%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="layout/head.jsp" />
    <title><%= esEdicion ? "Editar cliente" : "Nuevo cliente" %></title>
</head>
<body class="bg-gray-100 font-sans antialiased">
    <div class="flex h-screen overflow-hidden">
        <jsp:include page="layout/sidebar.jsp" />

        
        <div class="bg-white p-6 rounded-xl shadow-lg max-w-2xl w-full mx-auto">
            <h3 class="text-2xl font-semibold text-text-dark mb-6 border-b pb-3">
                <%= esEdicion ? "Editar Cliente Existente" : "Registrar Nuevo Cliente" %>
            </h3>
            
            <p class="text-sm font-medium text-danger mb-4">
                ${requestScope.error}
            </p>

            <form action="${pageContext.request.contextPath}/ClientesServlet" method="post" class="space-y-4">
                <input type="hidden" name="accion" value="guardar"/>
                <input type="hidden" name="idCliente" value="<%= c.getIdCliente() %>"/>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="nombres" class="block text-sm font-medium text-gray-700 mb-1">Nombres (*)</label>
                        <input type="text" id="nombres" name="nombres" value="<%= c.getNombres() %>" required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="Nombres del cliente"/>
                    </div>
                    <div>
                        <label for="apellidos" class="block text-sm font-medium text-gray-700 mb-1">Apellidos (*)</label>
                        <input type="text" id="apellidos" name="apellidos" value="<%= c.getApellidos() %>" required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="Apellidos del cliente"/>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="licencia" class="block text-sm font-medium text-gray-700 mb-1">Licencia (*)</label>
                        <input type="text" id="licencia" name="licencia" value="<%= c.getLicencia() %>" required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="Número de licencia"/>
                    </div>
                    <div>
                        <label for="telefono" class="block text-sm font-medium text-gray-700 mb-1">Teléfono</label>
                        <input type="text" id="telefono" name="telefono" value="<%= c.getTelefono() %>"
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="Ej: +503 1234-5678"/>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="correo" class="block text-sm font-medium text-gray-700 mb-1">Correo</label>
                        <input type="email" id="correo" name="correo" value="<%= c.getCorreo() %>"
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="correo@ejemplo.com"/>
                    </div>
                    <div>
                        <label for="direccion" class="block text-sm font-medium text-gray-700 mb-1">Dirección</label>
                        <input type="text" id="direccion" name="direccion" value="<%= c.getDireccion() %>"
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                            placeholder="Dirección de residencia"/>
                    </div>
                </div>

                <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                    <div>
                        <label for="idUsuario" class="block text-sm font-medium text-gray-700 mb-1">IdUsuario (opcional)</label>
                        <input type="number" id="idUsuario" name="idUsuario"
                               value="<%= c.getIdUsuario() != null ? c.getIdUsuario() : "" %>"
                               class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                               placeholder="Asociar a un usuario de login"/>
                    </div>
                    <div>
                        <label for="estado" class="block text-sm font-medium text-gray-700 mb-1">Estado (*)</label>
                        <select id="estado" name="estado"
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                            <option value="1" <%= c.isEstado() ? "selected" : "" %>>Activo</option>
                            <option value="0" <%= !c.isEstado() ? "selected" : "" %>>Inactivo</option>
                        </select>
                    </div>
                </div>
                
                <p class="text-xs text-gray-500 pt-2">(*) Campos requeridos.</p>

                <div class="mt-6 flex justify-end space-x-3 border-t pt-4">
                    <a href="${pageContext.request.contextPath}/ClientesServlet?accion=listar" 
                       class="px-6 py-3 text-sm font-medium text-gray-700 bg-gray-200 rounded-lg hover:bg-gray-300 transition duration-150 flex items-center">
                        Cancelar
                    </a>
                    <button type="submit" 
                            class="px-6 py-3 text-sm font-medium text-white bg-primary-accent rounded-lg shadow-md hover:bg-blue-700 transition duration-150">
                        <%= esEdicion ? "Actualizar Cliente" : "Guardar Cliente" %>
                    </button>
                </div>
            </form>
        </div>

        <jsp:include page="layout/footer.jsp" />