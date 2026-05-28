<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Registro de Tratamiento</title>
   
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
        <h1>Registrar Tratamiento</h1>
    </header>

    <main id="genDoc2">
	
        <section id="formTrat">
		<article>
            <form id="formRegistroDoctor" action="addTreatment1.jsp" method="post">

                <label for="nombre"><b>Nombre:</b></label><br>
                <input type="text" id="nombre" name="nombre" placeholder="Nombre del Tratamiento" required><br>

                <label for="precio"><b>Precio:</b></label><br>
                <input type="number" id="precio" name="precio" placeholder="Precio" required><br>

                <label for="descripcion"><b>Descripción:</b></label><br>
				
                <textarea id="descripcion" name="descripcion" cols="50" rows="1"
                placeholder="Escribe una breve descripción del tratamiento, su propósito y las indicaciones">
Descripción general: 

Propósito del tratamiento: 

Indicaciones: 

Composición o principios activos:

Notas Adicionales:</textarea><br>

                <button type="submit" class="botonImportante" id="code">Registrar
            </form>
			<button type="button" onclick="location.href='docTreatments.jsp'" class="boton">Regresar</button>
		</article>
		
        </section>
    </main>
</body>
</html>