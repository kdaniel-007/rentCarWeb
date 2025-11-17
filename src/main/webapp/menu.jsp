<%-- 
    Document   : menu
    Created on : 13 nov 2025, 12:37:57 p. m.
    Author     : KevDev
--%>

<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%


    request.setAttribute("paginaActiva", "dashboard");
    request.setAttribute("tituloPagina", "Dashboard de Gestión");
%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title>Menú principal - RentCarWeb</title>
    </head>
    <body class="bg-gray-100 font-sans antialiased">
        <div class="flex h-screen overflow-hidden">
            <jsp:include page="layout/sidebar.jsp" />

            <h1 class="text-3xl font-bold text-text-dark mb-6">Panel Principal</h1>
            <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
                <div class="bg-white p-6 rounded-xl shadow-lg border-l-4 border-primary-accent">
                    <p class="text-sm font-medium text-gray-500">Reservas Activas</p>
                    <p class="text-3xl font-bold text-text-dark mt-1">45</p>
                    <span class="text-xs text-success">↑ 12% esta semana</span>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-lg border-l-4 border-success">
                    <p class="text-sm font-medium text-gray-500">Vehículos Disponibles</p>
                    <p class="text-3xl font-bold text-text-dark mt-1">28 / 35</p>
                    <span class="text-xs text-warning">¡Solo 7 rentados!</span>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-lg border-l-4 border-warning">
                    <p class="text-sm font-medium text-gray-500">Ingresos (Mes)</p>
                    <p class="text-3xl font-bold text-text-dark mt-1">$15,420</p>
                    <span class="text-xs text-success">Meta alcanzada</span>
                </div>
                <div class="bg-white p-6 rounded-xl shadow-lg border-l-4 border-danger">
                    <p class="text-sm font-medium text-gray-500">Nuevos Clientes (Hoy)</p>
                    <p class="text-3xl font-bold text-text-dark mt-1">3</p>
                    <span class="text-xs text-danger">↓ 20% respecto a ayer</span>
                </div>
            </div>

            <div class="bg-white p-6 rounded-xl shadow-lg">
                <h3 class="text-2xl font-semibold text-text-dark mb-4">Análisis y Gráficos</h3>
                <div class="grid grid-cols-1 lg:grid-cols-3 gap-6">
                    <div class="h-64 border border-gray-200 rounded-lg flex items-center justify-center text-gray-500">Gráfico 1: Ingresos por mes</div>
                    <div class="h-64 border border-gray-200 rounded-lg flex items-center justify-center text-gray-500">Gráfico 2: Rentas por tipo de vehículo</div>
                    <div class="h-64 border border-gray-200 rounded-lg flex items-center justify-center text-gray-500">Gráfico 3: Clientes más frecuentes</div>
                </div>
            </div>

            <jsp:include page="layout/footer.jsp" />