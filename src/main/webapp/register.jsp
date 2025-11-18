<%-- 
    Document   : register
    Created on : 17 nov 2025, 12:33:41 a. m.
    Author     : sg596
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="layout/head.jsp" />
        <title>Registro - RentCarWeb</title>
    </head>
    <body class="bg-gray-100 flex items-center justify-center min-h-screen p-4">

        <div class="bg-white p-8 md:p-10 rounded-xl shadow-2xl w-full max-w-sm">
            <div class="text-center mb-8">
                <h1 class="text-3xl font-bold text-primary-dark tracking-wider">Crear Cuenta</h1>
                <p class="text-sm text-gray-500 mt-2">Regístrate para gestionar tus reservas</p>
            </div>

            <p class="text-sm font-medium text-danger text-center mb-4">
                ${requestScope.error}
            </p>

            <form action="${pageContext.request.contextPath}/RegisterServlet" method="post" class="space-y-6">

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Nombre de Usuario</label>
                    <input type="text" name="usuario" required
                           class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                           placeholder="Usuario" />
                </div>
                <div>
                    <label for="correo" class="block text-sm font-medium text-gray-700 mb-1">Correo</label>
                    <input type="email" id="correo" name="correo" required
                           class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                           placeholder="sunombre@correo.com" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                    <input type="password" name="password" required
                           class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent"
                           placeholder="********" />
                </div>

                <div>
                    <label class="block text-sm font-medium text-gray-700 mb-1">Rol</label>
                    <select name="rol" required
                            class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent">
                        <option value="cliente">Cliente</option>
                        <option value="empleado">Empleado</option>
                        <!-- admin NO se permite registrar -->
                    </select>
                </div>

                <button type="submit"
                        class="w-full py-3 bg-primary-accent text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-150">
                    Crear Cuenta
                </button>

            </form>

            <p class="text-center mt-6 text-sm">
                <a href="${pageContext.request.contextPath}/login.jsp"
                   class="text-primary-accent hover:underline">
                    ¿Ya tienes una cuenta? Inicia sesión
                </a>
            </p>
        </div>
    </body>
</html>
