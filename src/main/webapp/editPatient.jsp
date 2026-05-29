<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Datos Personales Paciente</title>
</head>

<body id="bodDoc">
             <%@ include file="navDoctor.jsp" %>


<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Editar Paciente</h1>
    </header>
    <main id="genDoc2">
       
        <section>
            <article id="registro">
                <form id="formRegistroDoctor">
                   <label for="name"><b>Nombre(s):</b></label>
                    <input type="text" id="name" name="nombre" placeholder="Nombre(s)" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" placeholder=" Paterno" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" placeholder=" Materno" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" placeholder="Correo " required>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento" required>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" placeholder="Username" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" placeholder="Password" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" placeholder="Confirm Password" required>


                    <button type="button" onclick="location.href='patientManagement.html'" class="botonImportante">Guardar</button>
                </form>
                                <button type="button" class="boton" onclick="location.href='patientManagement.html'">Regresar </button> 

            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>