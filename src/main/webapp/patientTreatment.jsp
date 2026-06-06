<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
        <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>

    <title>Tratamientos del Paciente</title>
</head>

<body id="bodDoc">
    <%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ include file="navPaciente.jsp" %>   
    <%
					Integer idPaciente = (Integer) session.getAttribute("id_paciente");
    				if (idPaciente == null) {
        				response.sendRedirect("index.html");
        				return;
    				}
    %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>ClinicApp</h1>
    </header>
	
    <main id="genDoc2">
        <section>

			<article>
                <h2>Tratamientos Asignados</h2>
                <p>Aquí podrá ver los tratamientos que le han sido asignados.</p>
                <button type="button" class="boton" id="BVtr" onclick="location.href='patientTreatment1.jsp'">Buscar</button>
            </article>			
			
        </section>
    </main>
</body>

</html>