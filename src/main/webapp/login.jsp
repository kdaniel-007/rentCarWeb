<%-- 
    Document   : login
    Created on : 13 nov 2025, 12:31:16 p. m.
    Author     : KevDev
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <jsp:include page="layout/head.jsp" />
    <title>Login - RentCarWeb</title>
</head>
<body class="bg-gray-100 flex items-center justify-center min-h-screen p-4">

    <div class="bg-white p-8 md:p-10 rounded-xl shadow-2xl w-full max-w-sm">
        <div class="text-center mb-8">
            <h1 class="text-3xl font-bold text-primary-dark tracking-wider">Rent<span class="text-primary-accent">Car</span></h1>
            <p class="text-sm text-gray-500 mt-2">Ingresa a tu cuenta de gestión de vehículos</p>
        </div>

        <p class="text-sm font-medium text-danger text-center mb-4">
            ${requestScope.error}
        </p>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post" class="space-y-6">
            <div>
                <label for="usuario" class="block text-sm font-medium text-gray-700 mb-1">Usuario</label>
                <input type="text" id="usuario" name="usuario" required
                       class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                       placeholder="Nombre de usuario o Correo" />
            </div>

            <div>
                <label for="password" class="block text-sm font-medium text-gray-700 mb-1">Contraseña</label>
                <input type="password" id="password" name="password" required
                       class="w-full p-3 border border-gray-300 rounded-lg focus:ring-primary-accent focus:border-primary-accent" 
                       placeholder="********" />
            </div>

            <button type="submit" 
                    class="w-full py-3 bg-primary-accent text-white font-semibold rounded-lg shadow-md hover:bg-blue-700 transition duration-150">
                Ingresar
            </button>
        </form>

        <p class="text-center mt-6 text-sm">
            <a href="${pageContext.request.contextPath}/register.jsp" class="text-primary-accent hover:underline">
                ¿No tienes una cuenta? registrate aquí
            </a>
        </p>
    </div>
</body>
</html>