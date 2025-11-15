<%-- 
    Document   : vehiculo-form
    Created on : 13 nov 2025, 1:55:47 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Vehiculo"%>
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
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%= esEdicion ? "Editar vehículo" : "Nuevo vehículo"%></title>
    </head>
    <body>

        <h1><%= esEdicion ? "Editar vehículo" : "Nuevo vehículo"%></h1>

        <p style="color:red;">
            ${requestScope.error}
        </p>

        <form action="${pageContext.request.contextPath}/VehiculosServlet" method="post">
            <input type="hidden" name="accion" value="guardar"/>
            <input type="hidden" name="idVehiculo" value="<%= v.getIdVehiculo()%>" />

            <label>Id Proveedor:</label>
            <input type="number" name="idProveedor" value="<%= v.getIdProveedor()%>" required />
            <br/>

            <label>Marca:</label>
            <input type="text" name="marca" value="<%= v.getMarca()%>" required />
            <br/>

            <label>Tipo:</label>
            <input type="text" name="tipo" value="<%= v.getTipo()%>" required />
            <br/>

            <label>Año:</label>
            <input type="number" name="anio" value="<%= v.getAnio()%>" required />
            <br/>

            <label>Placa:</label>
            <input type="text" name="placa" value="<%= v.getPlaca()%>" required />
            <br/>

            <label>Transmisión:</label>
            <input type="text" name="transmision" value="<%= v.getTransmision()%>" required />
            <br/>

            <label>Estado:</label>
            <input type="text" name="estado"
                   value="<%= (v.getEstado() != null ? v.getEstado() : "disponible")%>" required />
            <br/>

            <label>Precio por día:</label>
            <input type="number" step="0.01" name="precioDia" value="<%= v.getPrecioDia()%>" required />
            <br/>

            <label>Color:</label>
            <input type="text" name="color" value="<%= v.getColor()%>" />
            <br/>

            <label>Kilometraje:</label>
            <input type="number" name="kilometraje" value="<%= v.getKilometraje()%>" />
            <br/><br/>

            <button type="submit"><%= esEdicion ? "Actualizar" : "Guardar"%></button>
            <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=listar">Cancelar</a>
        </form>

    </body>
</html>
