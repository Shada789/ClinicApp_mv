<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
        <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>

    <title>Tratamientos del Paciente</title>
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
                <h2>Lista de Doctores y sus Tratamientos</h2>
                <p>Aquí podrá elegir un doctor y visualizar todos sus tratamientos.</p>
                <button type="button" class="boton" id="BVtr" onclick="location.href='patientTreatment1.jsp'">Buscar</button>
            </article>			
			
        </section>
    </main>
</body>

</html>