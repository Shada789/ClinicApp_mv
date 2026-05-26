<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Registro de Paciente</title>
</head>
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Paciente Nuevo</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article id="registroPaciente">
                <form id="formRegistroDoctor" action="registroPaciente.jsp" method="post">

                    <label for="name"><b>Nombre(s):</b></label>
                    <input type="text" id="name" name="nombre" placeholder="Nombre(s)" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" placeholder="Paterno" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" placeholder="Materno" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" placeholder="Correo" required>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento" required>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" placeholder="Username" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" placeholder="Password" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" placeholder="Confirm Password" required>

                    <button type="submit" class="botonImportante">Registrar</button>
                </form>

                <button type="button" class="boton" onclick="location.href='patientManagement.jsp'">Regresar</button>
            </article>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

</body>
</html>