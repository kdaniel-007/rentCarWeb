<%-- 
    Document   : reporteGeneral
    Created on : 16 nov 2025
    Author     : aniba
--%>

<%@page import="com.mycompany.rentcarweb.model.ReporteGeneral"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reporte General</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>

<body class="bg-light">

<div class="container mt-5">

    <h2 class="text-center mb-4">Reporte General de Reservas y Pagos</h2>

    <!-- ===================== -->
    <!-- FORMULARIO DE FILTROS -->
    <!-- ===================== -->
    <form action="ReporteServlet" method="GET" class="d-flex gap-3">

        <div>
            <label>Fecha Inicio</label>
            <input 
                type="date" 
                name="fechaInicio" 
                class="form-control"
                value="<%= request.getAttribute("fechaInicio") != null ? request.getAttribute("fechaInicio") : "" %>"
            >
        </div>

        <div>
            <label>Fecha Fin</label>
            <input 
                type="date" 
                name="fechaFin" 
                class="form-control"
                value="<%= request.getAttribute("fechaFin") != null ? request.getAttribute("fechaFin") : "" %>"
            >
        </div>

        <div class="align-self-end">
            <button type="submit" class="btn btn-primary">Generar Reporte</button>
        </div>

    </form>


    <!-- ===================== -->
    <!-- MOSTRAR ERRORES -->
    <!-- ===================== -->
    <%
        String error = (String) request.getAttribute("error");
        if (error != null) {
    %>
        <div class="alert alert-danger mt-3"><%= error %></div>
    <%
        }
    %>


    <!-- ===================== -->
    <!-- TABLA DE RESULTADOS -->
    <!-- ===================== -->
    <%
        List<ReporteGeneral> lista = (List<ReporteGeneral>) request.getAttribute("listaReporte");
        String fi = (String) request.getAttribute("fechaInicio");
        String ff = (String) request.getAttribute("fechaFin");
    %>

    <div class="card shadow-sm mt-4">
        <div class="card-body">

            <h5 class="card-title">Resultados del Reporte</h5>

            <table class="table table-bordered table-striped mt-3">
                <thead class="table-dark">
                    <tr>
                        <th>ID Reserva</th>
                        <th>Cliente</th>
                        <th>Marca</th>
                        <th>Tipo</th>
                        <th>Placa</th>
                        <th>F. Inicio</th>
                        <th>F. Fin</th>
                        <th>Estado</th>
                        <th>Fecha Pago</th>
                        <th>Forma Pago</th>
                        <th>Total Pagado</th>
                    </tr>
                </thead>

                <tbody>
                <%
                    if (lista != null && !lista.isEmpty()) {
                        for (ReporteGeneral r : lista) {
                %>
                    <tr>
                        <td><%= r.getIdReserva() %></td>
                        <td><%= r.getCliente() %></td>
                        <td><%= r.getMarca() %></td>
                        <td><%= r.getTipo() %></td>
                        <td><%= r.getPlaca() %></td>
                        <td><%= r.getFechaInicio() %></td>
                        <td><%= r.getFechaFin() %></td>
                        <td><%= r.getEstadoReserva() %></td>
                        <td><%= r.getFechaPago() %></td>
                        <td><%= r.getFormaPago() %></td>
                        <td>$<%= r.getTotalPagado() %></td>
                    </tr>
                <%
                        }
                    } else {
                %>
                    <tr>
                        <td colspan="11" class="text-center text-danger">
                            No hay datos para mostrar.
                        </td>
                    </tr>
                <%
                    }
                %>
                </tbody>
            </table>


            <!-- ===================== -->
            <!-- BOTÓN DE EXPORTAR A PDF -->
            <!-- ===================== -->
            <%
                if (lista != null && !lista.isEmpty()) {
            %>

                <form action="ReportePDFServlet" method="GET" class="mt-3" target="_blank">
                    <input type="hidden" name="fechaInicio" value="<%= fi %>">
                    <input type="hidden" name="fechaFin" value="<%= ff %>">
                    <button type="submit" class="btn btn-danger">
                        📄 Exportar a PDF
                    </button>
                </form>

            <%
                }
            %>

        </div>
    </div>

</div>

</body>
</html>
