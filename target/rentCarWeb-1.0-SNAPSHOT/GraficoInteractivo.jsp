<%-- 
    Document   : GraficoInteractivo
    Created on : 14 nov 2025, 11:19:45 a. m.
    Author     : aniba
--%>

<%@page import="com.mycompany.rentcarweb.model.ReporteGrafico"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>


<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/apexcharts"></script>

    <style>
        /* Imagen flotante que aparece al pasar el mouse */
        #hoverImage {
            position: absolute;
            width: 90px;
            height: 90px;
            display: none;
            transition: transform 0.25s ease, opacity 0.25s ease;
            transform: translate(-50%, -80%);
            pointer-events: none;
            z-index: 999;
        }
    </style>
</head>

<body>

<h2 style="text-align:center;">Gráfico Interactivo de Vehículos</h2>

<img id="hoverImage" src="" />

<div id="chart" style="max-width:900px; margin:auto;"></div>

<script>

    /* === LABELS DESDE EL SERVIDOR === */
    var labels = [
        <% List<ReporteGrafico> lista = (List<ReporteGrafico>) request.getAttribute("datos");
           for (ReporteGrafico r : lista) { %>
             "<%= r.getMarca() %>",
        <% } %>
    ];

    /* === CANTIDADES DESDE EL SERVIDOR === */
    var cantidades = [
        <% for (ReporteGrafico r : lista) { %>
             <%= r.getCantidad() %>,
        <% } %>
    ];

    /* === IMÁGENES PERSONALIZADAS POR MARCA === */
   var imagenes = [
    <% for (ReporteGrafico r : lista) { 
           String marca = r.getMarca();
           String img = "";

           switch (marca) {
               case "Toyota":
                   img = "img/Toyota.png";
                   break;
               case "Hyundai":
                   img = "img/Hyundai.png";
                   break;
               case "Nissan":
                   img = "img/Nissan.png";
                   break;
               case "Kia":
                   img = "img/Kia.png"; // si solo tenés KiaRio.png, renómbrala o úsala aquí
                   break;
                     case "Yaris":
                   img = "img/Yaris.png"; //
                   break;
               default:
                   img = "img/default.png"; // opcional para cuando falte imagen
           }
    %>
        "<%= img %>",
    <% } %>
];


    /* === OPCIONES DEL GRÁFICO === */
    var options = {
        chart: { 
            type: 'bar', 
            height: 500,
            events: {
                dataPointMouseEnter: function(event, chartContext, config) {
                    let img = document.getElementById("hoverImage");
                    img.src = imagenes[config.dataPointIndex];
                    img.style.left = event.clientX + "px";
                    img.style.top = (event.clientY - 50) + "px";
                    img.style.display = "block";
                    img.style.opacity = "1";
                    img.style.transform = "translate(-50%, -100%) scale(1)";
                },
                dataPointMouseLeave: function(event, chartContext, config) {
                    let img = document.getElementById("hoverImage");
                    img.style.opacity = "0";
                    img.style.transform = "translate(-50%, -70%) scale(0.8)";
                    setTimeout(() => img.style.display = "none", 200);
                }
            }
        },

        series: [{ 
            name: "Total", 
            data: cantidades 
        }],

        xaxis: { categories: labels },

        fill: {
            type: 'gradient',
            gradient: {
                shade: 'dark',
                type: "vertical",
                gradientToColors: ["#9a9aef"],
                stops: [0, 100]
            }
        },

        plotOptions: {
            bar: {
                distributed: true,
                borderRadius: 12,
                columnWidth: '55%'
            }
        },

        tooltip: {
            custom: function({series, seriesIndex, dataPointIndex, w}) {
                return `
                 <div style="padding:10px;text-align:center;">
                    <img src="${imagenes[dataPointIndex]}" style="width:60px;height:60px;border-radius:10px;" /><br>
                    <strong>${labels[dataPointIndex]}</strong><br>
                    Cantidad: ${series[0][dataPointIndex]}
                 </div>
                `;
            }
        },

        legend: { show: false }
    };

    var chart = new ApexCharts(document.querySelector("#chart"), options);
    chart.render();
</script>

</body>
</html>
