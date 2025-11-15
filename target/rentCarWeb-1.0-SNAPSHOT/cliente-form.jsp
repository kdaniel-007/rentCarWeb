<%-- 
    Document   : cliente-form
    Created on : 14 nov 2025, 10:55:44 a. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Cliente"%>
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
%>
<!DOCTYPE html>
<html>
    <head>
        <title><%= esEdicion ? "Editar cliente" : "Nuevo cliente" %></title>
    </head>
    <body>
        <h1><%= esEdicion ? "Editar cliente" : "Nuevo cliente" %></h1>

        <p style="color:red;">
            ${requestScope.error}
        </p>

        <form action="${pageContext.request.contextPath}/ClientesServlet" method="post">
            <input type="hidden" name="accion" value="guardar"/>
            <input type="hidden" name="idCliente" value="<%= c.getIdCliente() %>"/>

            <label>IdUsuario (opcional):</label>
            <input type="number" name="idUsuario"
                   value="<%= c.getIdUsuario() != null ? c.getIdUsuario() : "" %>"/>
            <br/>

            <label>Nombres:</label>
            <input type="text" name="nombres" value="<%= c.getNombres() %>" required/>
            <br/>

            <label>Apellidos:</label>
            <input type="text" name="apellidos" value="<%= c.getApellidos() %>" required/>
            <br/>

            <label>Licencia:</label>
            <input type="text" name="licencia" value="<%= c.getLicencia() %>" required/>
            <br/>

            <label>Teléfono:</label>
            <input type="text" name="telefono" value="<%= c.getTelefono() %>"/>
            <br/>

            <label>Correo:</label>
            <input type="email" name="correo" value="<%= c.getCorreo() %>"/>
            <br/>

            <label>Dirección:</label>
            <input type="text" name="direccion" value="<%= c.getDireccion() %>"/>
            <br/>

            <label>Estado:</label>
            <select name="estado">
                <option value="1" <%= c.isEstado() ? "selected" : "" %>>Activo</option>
                <option value="0" <%= !c.isEstado() ? "selected" : "" %>>Inactivo</option>
            </select>
            <br/><br/>

            <button type="submit"><%= esEdicion ? "Actualizar" : "Guardar" %></button>
            <a href="${pageContext.request.contextPath}/ClientesServlet?accion=listar">Cancelar</a>
        </form>
    </body>
</html>
