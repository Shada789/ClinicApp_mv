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
                <h2>Registrar insumo</h2>
                <p>Aquí podrá agregar insumos nuevos.</p>
                <button type="button" class="boton" id="RegisTrat" onclick="location.href='insumosAdd.jsp'">Registrar</button>
            </article>

			<article>
                <h2>Lista de Insumos</h2>
                <p>Aquí podrá visualizar y buscar todos los insumos previamente registrados.</p>
                <button type="button" class="boton" id="BVtr" onclick="location.href='insumosSearch.jsp'">Buscar</button>
            </article>

            <article>
                <h2>Modificar insumo</h2>
                <p>Aquí podrá seleccionar algún insumo y modificarlo.</p>
                <button type="button" class="boton" id="modTrat" onclick="location.href='insumosEdit.jsp'">Modificar</button>
            </article>

            <article>
                <h2>Eliminar insumo</h2>
                <p>Aquí podrá seleccionar algún insumo y eliminarlo.</p>
                <button type="button" class="boton" id="EliTrat" onclick="location.href='insumosDelete.jsp'">Eliminar</button>
            </article>
			
        </section>
    </main>
</body>
</html>