<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Página Principal</title>
</head>

<body id="bodDoc">
             <%@ include file="navPaciente.jsp" %>

 <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
      

        <section>
            <article>
                <h2>Cerrar Sesión</h2>
                <p>Aquí puede cerrar de manera segura la sesión de su cuenta</p>
                <button type="button" class="boton" id="editCuenta" onclick="location.href='index.html'"><b>Cerrar Sesión</b></button>
            </article>

        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>