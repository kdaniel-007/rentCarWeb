<%-- 
    Document   : sidebar
    Created on : 16 nov 2025, 14:53:43
    Author     : kdaniel
--%>

<%@page import="com.mycompany.rentcarweb.model.Usuario"%>
<%
    Usuario u = (Usuario) request.getSession().getAttribute("usuarioLogueado");
    String nombreUsuario = (u != null) ? u.getNombreUsuario() : "Invitado";
    String rolUsuario = (u != null) ? u.getRol() : "N/A";

    String paginaActiva = (String) request.getAttribute("paginaActiva");
%>

<aside id="sidebar" class="sidebar fixed z-40 md:relative w-64 bg-primary-dark shadow-xl h-full flex-shrink-0 hidden-mobile">
    <div class="p-6">
        <h1 class="text-white text-2xl font-bold tracking-wider">Rent<span class="text-primary-accent">Car</span></h1>
        <p class="text-sm text-gray-400 mt-1">Bienvenido, <%= nombreUsuario%></p>
    </div>

    <nav class="mt-4 flex-grow overflow-y-auto">
        <ul class="space-y-2 px-4">
            <%
                String activeClass = "flex items-center p-3 text-white rounded-lg bg-primary-accent hover:bg-blue-700";
                String normalClass = "flex items-center p-3 text-gray-300 hover:bg-primary-dark/80 rounded-lg";
            %>

            <li>
                <a href="menu.jsp" class="<%= "dashboard".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><rect x="3" y="3" width="18" height="18" rx="2" ry="2"/><line x1="9" y1="3" x2="9" y2="21"/><line x1="15" y1="3" x2="15" y2="21"/><line x1="3" y1="9" x2="21" y2="9"/><line x1="3" y1="15" x2="21" y2="15"/></svg>
                    Dashboard
                </a>
            </li>

            <li class="pt-4 text-xs font-semibold uppercase text-gray-400 pl-3">SECCIÓN 1: Usuarios</li>
                <% if ("admin".equalsIgnoreCase(rolUsuario)) {%>
            <li>
                <a href="#" class="<%= "gestion_usuarios".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><path d="M22 21v-2a4 4 0 0 0-3-3.87"/><path d="M16 3.13a4 4 0 0 1 0 7.75"/></svg>
                    Gestión de Empleados/Prov.
                </a>
            </li>
            <% }%>

            <li class="pt-4 text-xs font-semibold uppercase text-gray-400 pl-3">SECCIÓN 2: Renta</li>
            <li>
                <a href="${pageContext.request.contextPath}/ReservasServlet?accion=listar" class="<%= "reservas".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"/><line x1="16" y1="2" x2="16" y2="6"/><line x1="8" y1="2" x2="8" y2="6"/><line x1="3" y1="10" x2="21" y2="10"/><polyline points="9 16 12 19 19 12"/></svg>
                    Gestión de Reservas
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/VehiculosServlet?accion=listar" class="<%= "vehiculos".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><path d="M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.9 10.9 16.6 10 12 10s-6.9.9-7.5 1.1c-.8.2-1.5 1-1.5 1.9v3c0 .6.4 1 1 1h2"/><circle cx="7" cy="17" r="2"/><circle cx="17" cy="17" r="2"/><path d="M15 17H9"/></svg>
                    Gestión de Vehículos
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/ClientesServlet?accion=listar" class="<%= "clientes".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><path d="M16 21v-2a4 4 0 0 0-4-4H6a4 4 0 0 0-4 4v2"/><circle cx="9" cy="7" r="4"/><line x1="17" y1="10" x2="17" y2="16"/><line x1="14" y1="13" x2="20" y2="13"/></svg>
                    Gestión de Clientes
                </a>
            </li>

            <li class="pt-4 text-xs font-semibold uppercase text-gray-400 pl-3">SECCIÓN 3: Finanzas y Reportes</li>
            <li>
                <a href="#" class="<%= "registro_pago".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><line x1="12" y1="1" x2="12" y2="23"/><path d="M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                    Registro de Pago (Pendiente)
                </a>
            </li>
            <li>
                <a href="#" class="<%= "reportes".equals(paginaActiva) ? activeClass : normalClass%>">
                    <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-3"><line x1="12" y1="20" x2="12" y2="10"/><line x1="18" y1="20" x2="18" y2="4"/><line x1="6" y1="20" x2="6" y2="16"/><line x1="3" y1="20" x2="21" y2="20"/></svg>
                    Reportes y Análisis (Pendiente)
                </a>
            </li>
        </ul>
    </nav>

    <div class="p-6 border-t border-gray-700">
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="text-danger hover:text-red-600 flex items-center p-2 rounded-lg">
            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/><polyline points="16 17 21 12 16 7"/><line x1="21" y1="12" x2="9" y2="12"/></svg>
            Cerrar sesión
        </a>
    </div>
</aside>


<main id="mainContent" class="main-content flex-1 overflow-y-auto">
    <header class="bg-white shadow-md sticky top-0 z-30">
        <div class="p-4 flex justify-between items-center">
            <button id="menuToggle" class="text-primary-dark md:hidden focus:outline-none">
                <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="3" y1="12" x2="21" y2="12"/><line x1="3" y1="6" x2="21" y2="6"/><line x1="3" y1="18" x2="21" y2="18"/></svg>
            </button>

            <h2 class="text-xl font-semibold text-text-dark hidden md:block"><%= request.getAttribute("tituloPagina") != null ? request.getAttribute("tituloPagina") : "Panel de Control"%></h2>

            <div class="flex items-center space-x-4">
                <span class="text-sm text-gray-600 hidden sm:block">Rol: <%= rolUsuario%></span>

                <div class="relative w-8 h-8 rounded-full bg-primary-accent flex items-center justify-center text-white font-bold cursor-pointer" id="avatarBtn">
                    <%= nombreUsuario.substring(0, 1).toUpperCase()%>
                </div>

                <!-- Ventana emergente debajo del avatar -->
                <div id="avatarMenu" class="hidden absolute right top-10 transform -translate-x-1/2 mt-2 w-40 bg-white border border-gray-300 rounded shadow-lg z-50">
                    <a href="${pageContext.request.contextPath}/LogoutServlet" class="flex items-center px-4 py-2 text-sm text-gray-700 hover:bg-red-500 hover:text-white rounded">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="mr-2">
                            <path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"/>
                            <polyline points="16 17 21 12 16 7"/>
                            <line x1="21" y1="12" x2="9" y2="12"/>
                        </svg>
                        Salir
                    </a>
                </div>

                <script>
                    const avatarBtn = document.getElementById('avatarBtn');
                    const avatarMenu = document.getElementById('avatarMenu');

                    avatarBtn.addEventListener('click', () => {
                        avatarMenu.classList.toggle('hidden');
                    });

                    // Cerrar si haces click fuera
                    document.addEventListener('click', (e) => {
                        if (!avatarBtn.contains(e.target) && !avatarMenu.contains(e.target)) {
                            avatarMenu.classList.add('hidden');
                        }
                    });
                </script>
            </div>
        </div>
    </header>

    <div class="p-4 md:p-8">
