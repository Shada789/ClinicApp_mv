<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Registro de Tratamiento</title>
   
</head>

<body id="bodDoc">

    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li>
            <li><a href="patientManagement.html"><img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
            <li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li></a></li>
            <li><a href="docTreatments.jsp"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span></a></li>
            <li><a href="insumos.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Insumos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span></a></li>
        </ul>
    </nav>
	
	
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