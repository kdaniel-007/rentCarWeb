<%-- 
    Document   : index
    Created on : 13 nov 2025, 11:22:44 a. m.
    Author     : KevDev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>RentCarWeb - Inicio</title>
    </head>
    <body>
        <h1>RentCarWeb</h1>
        <p>Sistema de alquiler de vehículos - Proyecto JSP / Jakarta EE.</p>

        <ul>
            <li><a href="${pageContext.request.contextPath}/login.jsp">Ir al login</a></li>
            <li><a href="${pageContext.request.contextPath}/test-conexion">Probar conexión a la BD</a></li>
        </ul>
        
          <a href="graficos?view=pastel">Ver gráfico de pastel</a><br><br>
        <a href="graficos?view=barras">Ver gráfico de barras</a><br><br>
        <a href="graficos?view=interactivo">Gráfico interactivo</a><br><br>

        <hr>

        <a href="reporteGeneral.jsp">Ver Reporte General</a>
    </body>
</html>
