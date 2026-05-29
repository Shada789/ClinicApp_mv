<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Buscar Cita</title>
    <style>
        #formRegistroDoctor label,
#formRegistroDoctor input, #formRegistroDoctor select {

    border: none;
    color: black;
    font-size: 16px;
        background-color: transparent;

}
#formRegistroDoctor button{
    grid-column: 1 / -1;
    justify-self: center;
    padding: 10px 20px;
    font-size: 18px;
}
    </style>
</head>

<body id="bodDoc">
             <%@ include file="navPaciente.jsp" %>

<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
       

        <section id="buscarCita">
            <h1>Buscar Cita</h1>

            <form id="formRegistroDoctor">
                <label for="fechaCita">Fecha de la cita:</label>
                <input type="date" id="fechaCita" name="fechaCita">

                <label for="horaCita">Hora de la cita:</label>
                <input type="time" id="horaCita" name="horaCita">

                <label for="tipoCita">Tipo de cita:</label>
                <select id="tipoCita" name="tipoCita">
                    <option value="">Selecciona tipo</option>
                    <option value="consulta">Consulta</option>
                    <option value="control">Control</option>
                </select>

                <button type="button" class="botonImportante" id="btnBuscarCita" onclick="location.href='docAppts.html'">Buscar Cita</button>
            </form>
                <button type="button" onclick="location.href='patientAppts.html'" class="boton">Regresar</button>

            <table id="tablasDia">
                <thead>
                    <tr>
                        <th>Fecha</th>
                        <th>Hora</th>
                        <th>Tipo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </section><footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
    
</body>

</html>