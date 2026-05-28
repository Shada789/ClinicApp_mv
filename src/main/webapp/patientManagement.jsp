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
    <title>Gestión de Pacientes</title>
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
                <h2>Registrar Pacientes</h2>
                <p>
                    Aquí se pueden agregar pacientes nuevos al sistema, creando tanto
                    su perfil como una cuenta para que ellos inicien sesión y puedan ver
                    su información.
                </p>
                <button type="button" class="boton" onclick="location.href='registropac.jsp'">Registrar</button>
            </article>

            <article>
                <h2>Buscar Pacientes</h2>
                <p>Aquí podrá buscar a algún paciente con su nombre o usuario.</p>
                <button type="button" class="boton" onclick="location.href='buscarPaciente.jsp'">Buscar</button>
            </article>

        </section>
    </main>

</body>
</html>