<%-- 
    Document   : vehiculo-form
    Created on : 13 nov 2025, 1:55:47 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Vehiculo v = (Vehiculo) request.getAttribute("vehiculo");
    if (v == null) {
        v = new Vehiculo();
    }
    boolean esEdicion = v.getIdVehiculo() > 0;

    request.setAttribute("paginaActiva", "vehiculos");
    request.setAttribute("tituloPagina", esEdicion ? "Editar Vehículo" : "Nuevo Vehículo");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title><%= esEdicion ? "Editar vehículo" : "Nuevo vehículo"%></title>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="layout/sidebar.jsp" />


            <div class="bg-white p-6 rounded-xl shadow-lg max-w-3xl w-full mx-auto">
                <h3 class="text-2xl font-semibold text-text-dark mb-6 border-b pb-3">
                    <%= esEdicion ? "Editar Vehículo Existente" : "Registrar Nuevo Vehículo"%>
                </h3>

                <p class="text-sm font-medium text-danger mb-4">
                    ${requestScope.error}
                </p>

                <form action="${pageContext.request.contextPath}/VehiculosServlet" method="post" class="space-y-4">
                    <input type="hidden" name="accion" value="guardar"/>
                    <input type="hidden" name="idVehiculo" value="<%= v.getIdVehiculo()%>" />

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                        <div>
                            <label for="marca" class="block text-sm font-medium text-gray-700 mb-1">Marca (*)</label>
                            <input type="text" id="marca" name="marca" value="<%= v.getMarca()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: Toyota"/>
                        </div>
                        <div>
                            <label for="tipo" class="block text-sm font-medium text-gray-700 mb-1">Tipo (*)</label>
                            <input type="text" id="tipo" name="tipo" value="<%= v.getTipo()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: Sedan, SUV"/>
                        </div>
                        <div>
                            <label for="anio" class="block text-sm font-medium text-gray-700 mb-1">Año (*)</label>
                            <input type="number" id="anio" name="anio" value="<%= v.getAnio()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: 2023"/>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4">
                        <div>
                            <label for="placa" class="block text-sm font-medium text-gray-700 mb-1">Placa (*)</label>
                            <input type="text" id="placa" name="placa" value="<%= v.getPlaca()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: P123-456"/>
                        </div>
                        <div>
                            <label for="precioDia" class="block text-sm font-medium text-gray-700 mb-1">Precio por día ($) (*)</label>
                            <input type="number" step="0.01" id="precioDia" name="precioDia" value="<%= v.getPrecioDia()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: 45.00"/>
                        </div>
                        <div>
                            <label for="kilometraje" class="block text-sm font-medium text-gray-700 mb-1">Kilometraje</label>
                            <input type="number" id="kilometraje" name="kilometraje" value="<%= v.getKilometraje()%>"
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: 15000"/>
                        </div>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-3 gap-4 items-end">
                        <div>
                            <label for="idProveedor" class="block text-sm font-medium text-gray-700 mb-1">Id Proveedor (*)</label>
                            <input type="number" id="idProveedor" name="idProveedor" value="<%= v.getIdProveedor()%>" required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="ID del proveedor"/>
                        </div>
                        <div>
                            <label for="color" class="block text-sm font-medium text-gray-700 mb-1">Color</label>
                            <input type="text" id="color" name="color" value="<%= v.getColor()%>"
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                   placeholder="Ej: Rojo, Gris"/>
                        </div>

                        <%
                            boolean isAuto = "automática".equalsIgnoreCase(v.getTransmision());
                            String transmisionValue = isAuto ? "automática" : "manual";
                        %>
                        <div class="flex items-center justify-between p-3 bg-gray-50 rounded-lg border border-gray-200 h-14">
                            <label class="text-sm font-medium text-gray-700">Transmisión Automática</label>
                            <label class="toggle-switch relative inline-block w-12 h-6">
                                <input type="checkbox" id="transmision-toggle" class="opacity-0 w-0 h-0" <%= isAuto ? "checked" : ""%>>
                                <span class="slider absolute cursor-pointer top-0 left-0 right-0 bottom-0 rounded-full before:absolute before:rounded-full"></span>
                                <input type="hidden" name="transmision" id="transmision-value" value="<%= transmisionValue%>">
                            </label>
                        </div>
                    </div>

                    <div>
                        <label for="estado" class="block text-sm font-medium text-gray-700 mb-1">Estado (*)</label>
                        <% String estadoActual = (v.getEstado() != null ? v.getEstado() : "disponible").toLowerCase();%>
                        <select id="estado" name="estado" required
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                            <option value="disponible" <%= "disponible".equals(estadoActual) ? "selected" : ""%>>Disponible</option>
                            <option value="rentado" <%= "rentado".equals(estadoActual) ? "selected" : ""%>>Rentado</option>
                            <option value="mantenimiento" <%= "mantenimiento".equals(estadoActual) ? "selected" : ""%>>Mantenimiento</option>
                            <option value="vendido" <%= "vendido".equals(estadoActual) ? "selected" : ""%>>Vendido (Fuera de flota)</option>
                        </select>
                    </div>

                    <p class="text-xs text-gray-500 pt-2">(*) Campos requeridos.</p>

                    <div class="mt-6 flex justify-end space-x-3 border-t pt-4">
                        <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=listar"
                           class="px-6 py-3 text-sm font-medium text-gray-700 bg-gray-200 rounded-lg hover:bg-gray-300 transition duration-150 flex items-center">
                            Cancelar
                        </a>
                        <button type="submit"
                                class="px-6 py-3 text-sm font-medium text-white bg-primary-accent rounded-lg shadow-md hover:bg-blue-700 transition duration-150">
                            <%= esEdicion ? "Actualizar Vehículo" : "Guardar Vehículo"%>
                        </button>
                    </div>
                </form>
            </div>

            <script>
                const toggle = document.getElementById('transmision-toggle');
                const hiddenInput = document.getElementById('transmision-value');

                hiddenInput.value = toggle.checked ? 'automática' : 'manual';

                toggle.addEventListener('change', function () {
                    hiddenInput.value = this.checked ? 'automática' : 'manual';
                });
            </script>

            <jsp:include page="layout/footer.jsp" />