<%-- 
    Document   : login
    Created on : 13 nov 2025, 12:31:16 p. m.
    Author     : KevDev
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login - RentCarWeb</title>
    </head>
    <body>
        <h1>Login RentCarWeb</h1>

        <form action="${pageContext.request.contextPath}/LoginServlet" method="post">
            <label>Usuario:</label>
            <input type="text" name="usuario" required />
            <br/>

            <label>Contraseña:</label>
            <input type="password" name="password" required />
            <br/>

            <button type="submit">Ingresar</button>
        </form>

        <p style="color:red;">
            ${requestScope.error}
        </p>

        <p><a href="${pageContext.request.contextPath}/">Volver al inicio</a></p>
    </body>
</html>
