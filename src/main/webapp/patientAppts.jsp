<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Página Principal Paciente</title>
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
            <h2>Cancelar Citas</h2>
            <p>
                Aquí podrá cancelar la cita que ya tenía programada.<br>
            </p>
            <button type="button" class="boton" onclick="location.href='BorrarCitaPac.jsp'">Cancelar Cita</button>
        </article>

        <article>
                <h2>Visualizar Citas</h2>
                <p>Aquí podrá visualizar las proximas citas que tenga.</p>
                <button type="button" class="boton" onclick="location.href='PacienteCita.jsp'">Ver</button>
            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>