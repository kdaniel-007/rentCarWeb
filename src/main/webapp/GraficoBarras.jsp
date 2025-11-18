<%-- 
    Document   : GraficoBarras
    Created on : 13 nov 2025, 1:42:54 p. m.
    Author     : aniba
--%>

<%@page import="com.mycompany.rentcarweb.model.ReporteGrafico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>




<html>
<head>
    <script src="https://www.gstatic.com/charts/loader.js"></script>
    <script>
        google.charts.load("current", {packages:['corechart']});
        google.charts.setOnLoadCallback(draw);

        function draw() {
            var data = google.visualization.arrayToDataTable([
                ['Marca', 'Cantidad'],

                <%  
                List<ReporteGrafico> lista = (List<ReporteGrafico>) request.getAttribute("datos");
                for (ReporteGrafico r : lista) {
                %>
                    ['<%= r.getMarca() %>', <%= r.getCantidad() %>],
                <% } %>
            ]);

            var chart = new google.visualization.ColumnChart(document.getElementById('contenedor'));
            chart.draw(data);
        }
    </script>
</head>
<body>
<h2 style="text-align:center;">Gráfico de Barras - Vehículos por Marca</h2>
<div id="contenedor" style="width:900px; height:500px; margin:auto;"></div>
</body>
</html>
