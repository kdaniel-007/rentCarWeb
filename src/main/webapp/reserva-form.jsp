<%-- 
    Document   : reserva-form
    Created on : 14 nov 2025, 11:49:52 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
<%@page import="com.mycompany.rentcarweb.model.Reserva"%>
<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession sesion = request.getSession(false);
    if (sesion == null || sesion.getAttribute("usuarioLogueado") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    Reserva r = (Reserva) request.getAttribute("reserva");
    if (r == null) {
        r = new Reserva();
    }
    boolean esEdicion = r.getIdReserva() > 0;

    List<Cliente> clientes = (List<Cliente>) request.getAttribute("listaClientes");
    List<Vehiculo> vehiculos = (List<Vehiculo>) request.getAttribute("listaVehiculos");

    request.setAttribute("paginaActiva", "reservas");
    request.setAttribute("tituloPagina", esEdicion ? "Editar Reserva" : "Nueva Reserva");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title><%= esEdicion ? "Editar reserva" : "Nueva reserva"%></title>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="layout/sidebar.jsp" />

            <div class="bg-white p-6 rounded-xl shadow-lg max-w-xl w-full mx-auto">
                <h3 class="text-2xl font-semibold text-text-dark mb-6 border-b pb-3">
                    <%= esEdicion ? "Modificar Reserva" : "Crear Nueva Reserva"%>
                </h3>

                <p class="text-sm font-medium text-danger mb-4">
                    ${requestScope.error}
                </p>

                <form action="${pageContext.request.contextPath}/ReservasServlet" method="post" class="space-y-4">
                    <input type="hidden" name="accion" value="guardar"/>
                    <input type="hidden" name="idReserva" value="<%= r.getIdReserva()%>"/>

                    <div>
                        <label for="idCliente" class="block text-sm font-medium text-gray-700 mb-1">Cliente (*)</label>
                        <select id="idCliente" name="idCliente" required
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                            <option value="">-- Seleccione --</option>
                            <%
                                if (clientes != null) {
                                    for (Cliente c : clientes) {
                                        boolean sel = (c.getIdCliente() == r.getIdCliente());
                            %>
                            <option value="<%= c.getIdCliente()%>" <%= sel ? "selected" : ""%>>
                                <%= c.getNombres() + " " + c.getApellidos()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div>
                        <label for="idVehiculo" class="block text-sm font-medium text-gray-700 mb-1">Vehículo (*)</label>
                        <select id="idVehiculo" name="idVehiculo" required
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                            <option value="">-- Seleccione --</option>
                            <%
                                if (vehiculos != null) {
                                    for (Vehiculo v : vehiculos) {
                                        boolean sel = (v.getIdVehiculo() == r.getIdVehiculo());
                            %>
                            <option value="<%= v.getIdVehiculo()%>" <%= sel ? "selected" : ""%>>
                                <%= v.getMarca() + " " + v.getTipo() + " - " + v.getPlaca()%>
                            </option>
                            <%
                                    }
                                }
                            %>
                        </select>
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label for="fechaInicio" class="block text-sm font-medium text-gray-700 mb-1">Fecha inicio (*)</label>
                            <input type="date" id="fechaInicio" name="fechaInicio"
                                   value="<%= r.getFechaInicio() != null ? r.getFechaInicio().toString() : ""%>"
                                   required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"/>
                        </div>
                        <div>
                            <label for="fechaFin" class="block text-sm font-medium text-gray-700 mb-1">Fecha fin (*)</label>
                            <input type="date" id="fechaFin" name="fechaFin"
                                   value="<%= r.getFechaFin() != null ? r.getFechaFin().toString() : ""%>"
                                   required
                                   class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"/>
                        </div>
                    </div>

                    <div>
                        <label for="estado" class="block text-sm font-medium text-gray-700 mb-1">Estado</label>
                        <% String estado = (r.getEstado() != null) ? r.getEstado() : "pendiente";%>
                        <select id="estado" name="estado"
                                class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                            <option value="pendiente"  <%= "pendiente".equals(estado) ? "selected" : ""%>>Pendiente</option>
                            <option value="confirmada" <%= "confirmada".equals(estado) ? "selected" : ""%>>Confirmada</option>
                            <option value="finalizada" <%= "finalizada".equals(estado) ? "selected" : ""%>>Finalizada</option>
                            <option value="cancelada"  <%= "cancelada".equals(estado) ? "selected" : ""%>>Cancelada</option>
                        </select>
                    </div>

                    <div>
                        <label for="observaciones" class="block text-sm font-medium text-gray-700 mb-1">Observaciones</label>
                        <textarea id="observaciones" name="observaciones" rows="3"
                                  class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                                  placeholder="Notas importantes sobre la reserva..."><%= r.getObservaciones() != null ? r.getObservaciones() : ""%></textarea>
                    </div>

                    <div>
                        <label for="documento" class="block text-sm font-medium text-gray-700 mb-1">Documento (ruta o nombre archivo)</label>
                        <input type="text" id="documento" name="documento" value="<%= r.getDocumento() != null ? r.getDocumento() : ""%>"
                               class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                               placeholder="Ej: contrato_1020.pdf"/>
                    </div>

                    <p class="text-xs text-gray-500 pt-2">(*) Campos requeridos.</p>

                    <div class="mt-6 flex justify-end space-x-3 border-t pt-4">
                        <a href="${pageContext.request.contextPath}/ReservasServlet?accion=listar"
                           class="px-6 py-3 text-sm font-medium text-gray-700 bg-gray-200 rounded-lg hover:bg-gray-300 transition duration-150 flex items-center">
                            Cancelar
                        </a>
                        <button type="submit"
                                class="px-6 py-3 text-sm font-medium text-white bg-primary-accent rounded-lg shadow-md hover:bg-blue-700 transition duration-150">
                            <%= esEdicion ? "Actualizar Reserva" : "Guardar Reserva"%>
                        </button>
                    </div>
                </form>
            </div>

            <jsp:include page="layout/footer.jsp" />