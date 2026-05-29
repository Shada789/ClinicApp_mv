<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Registro de Insumo</title>
   
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
        <h1>Registrar Insumo</h1>
    </header>

    <main id="genDoc2">
	
        <section id="formTrat">
		<article>
            <form id="formRegistroDoctor" action="insumosAdd2.jsp" method="post">

                <label for="nombre"><b>Nombre:</b></label><br>
                <input type="text" id="nombre" name="nombre" placeholder="Nombre del Insumo" required><br>

                <label for="precio"><b>Cantidad:</b></label><br>
                <input type="number" id="cant" name="cant" placeholder="Cantidad" required><br>
                
				
                <button type="submit" class="botonImportante" id="code">Registrar
            </form>
			<button type="button" onclick="location.href='insumos.jsp'" class="boton">Regresar</button>
		</article>
		
        </section>
    </main>
</body>
</html>