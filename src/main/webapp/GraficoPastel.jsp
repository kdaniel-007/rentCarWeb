    <%@page import="com.mycompany.rentcarweb.model.ReporteGrafico"%>
<%-- 
        Document   : GraficoPastel
        Created on : 13 nov 2025, 1:20:37 p. m.
        Author     : aniba
    --%>

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

                var options = {
                    title: 'Distribución de Vehículos por Marca'
                };

                var chart = new google.visualization.PieChart(document.getElementById('contenedor'));
                chart.draw(data, options);
            }
        </script>
    </head>
    <body>
    <h2 style="text-align:center;">Gráfico de Pastel</h2>
    <div id="contenedor" style="width:1200px; height:800px; margin:auto;"></div>
    </body>
    </html>
