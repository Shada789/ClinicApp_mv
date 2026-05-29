<!DOCTYPE html>
<html lang="es">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
    <title>Inicio de Sesión</title>
     
  <style>
        #formCita label,
#formCita input, #formCita select {

    border: none;
    color: black;
    font-size: 16px;
        background-color: transparent;


}
#formCita button{
    grid-column: 1 / -1;
    justify-self: center;
    padding: 10px 20px;
    font-size: 18px;
}
    </style>
</head>

<body id="bodDoc">

     <%@ include file="navDoctor.jsp" %>
 <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Eliminar Cita</h1>
    </header>                            

    <main id="genDoc2">
      
        <section>

            <form id="formCita">
                <label for="paciente">Paciente:</label>
                <input type="text" id="paciente" name="paciente" placeholder="Nombre del paciente" required>
                <button type="submit" class="boton">Buscar Cita</button><br><br>

                <label for="fecha">Fecha de la cita:</label>
                <input type="date" id="fecha" name="fecha" required>
                <button type="submit" class="boton">Buscar Cita</button><br><br>

                <label for="hora">Hora de la cita:</label>
                <input type="time" id="hora" name="hora" required>
                <button type="submit" class="boton">Buscar Cita</button><br><br>

                <label for="tipo">Tipo de cita:</label>
                <select id="tipo" name="tipo" required>
                    <option value="">Selecciona tipo</option>
                    <option value="consulta">Consulta</option>
                    <option value="control">Control</option>
                    <option value="urgencia">Urgencia</option>
                </select><br><br>

                <button type="button" class="botonImportante" onclick="location.href='docAppts.html'">Eliminar Cita</button>
            </form>
                <button type="button" onclick="location.href='docAppts.html'" class="boton">Regresar</button>

            <table id="tablasDia">
                <thead>
                    <tr>
                        <th>Doctor</th>
                        <th>Paciente</th>
                        <th>Fecha</th>
                        <th>Tipo</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos </p>
        </footer>
    </main>


</body>

</html>