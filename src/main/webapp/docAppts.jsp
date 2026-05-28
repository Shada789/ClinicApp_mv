<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
    <title>Inicio de Sesión</title>
</head>

<body id="bodDoc">

       <%@ include file="navDoctor.jsp" %>

<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>

    <main id="genDoc2">
      
        <section id="regist1">
            <article>
                <h2>Agendar Nueva Cita</h2>
                <p>Aquí se pueden agregar nuevas citas que se le mostrarán tanto a usted como al paciente.</p>
                <button type="button" class="boton" id="agCitas" onclick="location.href='addAppt1.jsp'">Agendar</button>
            </article>

            <article>
                <h2>Modificar citas</h2>
                <p>Aquí podrá modificar las citas previamente agendadas. Los cambios se generarán para el paciente
                    también.</p>
                <button type="button" class="boton" id="RegisPac" onclick="location.href='editAppt.jsp'">Reagendar</button>
            </article>
            <article>
                <h2>Cancelar Citas</h2>
                <p>Aquí podrá cancelar citas que ya tenía programadas. Se le informará al paciente de esto.</p>
                <button type="button" class="boton" onclick="location.href='deleteAppt.jsp'">Eliminar</button>
            </article>

            <article>
                <h2>Visualizar Citas</h2>
                <p>Aquí podrá visualizar las proximas citas que tenga.</p>
                <button type="button" class="boton" onclick="location.href='viewAppt.jsp'">Ver</button>
            </article>
        </section>
        
      
    </main>
</body>

</html>