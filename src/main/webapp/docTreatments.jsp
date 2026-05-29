<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Página Principal</title>
</head>

<body id="bodDoc">
    <%Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>

         <%@ include file="navDoctor.jsp" %>

	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>ClinicApp</h1>
    </header>

    <main id="genDoc2">
        <section id="trat">
		
            <article>
                <h2>Registrar tratamiento</h2>
                <p>Aquí podrá agregar tratamientos nuevos.</p>
                <button type="button" class="boton" id="RegisTrat" onclick="location.href='addTreatment.html'">Registrar</button>
            </article>

			<article>
                <h2>Lista de Tratamientos</h2>
                <p>Aquí podrá visualizar y buscar todos los tratamientos previamente registrados.</p>
                <button type="button" class="boton" id="BVtr" onclick="location.href='searchTreatment1.jsp'">Buscar</button>
            </article>

            <article>
                <h2>Modificar tratamiento</h2>
                <p>Aquí podrá seleccionar algún tratamiento y modificarlo.</p>
                <button type="button" class="boton" id="modTrat" onclick="location.href='editTreatments1.jsp'">Modificar</button>
            </article>

            <article>
                <h2>Eliminar tratamiento</h2>
                <p>Aquí podrá seleccionar algún tratamiento y eliminarlo.</p>
                <button type="button" class="boton" id="EliTrat" onclick="location.href='deleteTreatments.jsp'">Eliminar</button>
            </article>
			
        </section>
    </main>
</body>
</html>