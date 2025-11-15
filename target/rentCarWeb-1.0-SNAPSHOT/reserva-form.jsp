<%-- 
    Document   : reserva-form
    Created on : 14 nov 2025, 11:49:52 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
<%@page import="com.mycompany.rentcarweb.model.Reserva"%>
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
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%= esEdicion ? "Editar reserva" : "Nueva reserva"%></title>
    </head>
    <body>
        <h1><%= esEdicion ? "Editar reserva" : "Nueva reserva"%></h1>

        <p style="color:red;">
            ${requestScope.error}
        </p>

        <form action="${pageContext.request.contextPath}/ReservasServlet" method="post">
            <input type="hidden" name="accion" value="guardar"/>
            <input type="hidden" name="idReserva" value="<%= r.getIdReserva()%>"/>

            <label>Cliente:</label>
            <select name="idCliente" required>
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
            <br/>

            <label>Vehículo:</label>
            <select name="idVehiculo" required>
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
            <br/>

            <label>Fecha inicio:</label>
            <input type="date" name="fechaInicio"
                   value="<%= r.getFechaInicio() != null ? r.getFechaInicio().toString() : ""%>"
                   required/>
            <br/>

            <label>Fecha fin:</label>
            <input type="date" name="fechaFin"
                   value="<%= r.getFechaFin() != null ? r.getFechaFin().toString() : ""%>"
                   required/>
            <br/>

            <label>Estado:</label>
            <select name="estado">
                <%
                    String estado = (r.getEstado() != null) ? r.getEstado() : "pendiente";
                %>
                <option value="pendiente"  <%= "pendiente".equals(estado) ? "selected" : ""%>>Pendiente</option>
                <option value="confirmada" <%= "confirmada".equals(estado) ? "selected" : ""%>>Confirmada</option>
                <option value="finalizada" <%= "finalizada".equals(estado) ? "selected" : ""%>>Finalizada</option>
                <option value="cancelada"  <%= "cancelada".equals(estado) ? "selected" : ""%>>Cancelada</option>

            </select>
            <br/>

            <label>Observaciones:</label>
            <br/>
            <textarea name="observaciones" rows="3" cols="40"><%= r.getObservaciones() != null ? r.getObservaciones() : ""%></textarea>
            <br/>

            <label>Documento (ruta o nombre archivo):</label>
            <input type="text" name="documento" value="<%= r.getDocumento() != null ? r.getDocumento() : ""%>"/>
            <br/><br/>

            <button type="submit"><%= esEdicion ? "Actualizar" : "Guardar"%></button>
            <a href="${pageContext.request.contextPath}/ReservasServlet?accion=listar">Cancelar</a>
        </form>
    </body>
</html>

