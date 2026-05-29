<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
    <title>Datos Personales</title>
</head>

<body id="bodDoc">

     <%@ include file="navDoctor.jsp" %>
<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
       
        <section id="deledit">
            <h2>Borrar la Cuenta</h2>
            <form id="formRegistroDoctor">
                <input type="password" placeholder="Password...">
                <input type="password" placeholder="Confirm Password...">
                <button type="button" value="Guardar" onclick="location.href='index.html'">Borrar</button>
            </form>

        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>