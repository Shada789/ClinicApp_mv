<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


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
<%
String pac = request.getParameter("paciente");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String tipo = request.getParameter("tipo");

String fecha_hora = fecha + " " + hora;

Connection conecta = null;
PreparedStatement st = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conecta = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );

    st = conecta.prepareStatement(
        "INSERT INTO citas (fecha_hora, nombre, tipo) VALUES (?,?,?)"
    );

    st.setString(1, fecha_hora);
    st.setString(2, pac);  
    st.setString(3, tipo);

    st.executeUpdate();

    out.println("<p>Todo joya ✔</p>");

} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {
    if (st != null) st.close();
    if (conecta != null) conecta.close();
}
%>

<nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li>
            <li><a href="patientManagement.html">
                    <img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
            <li><a href="historyDoctor.html"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li></a></li>
            <li><a href="docTreatments.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span></a></li>
        </ul>
    </nav>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Agendar Cita</h1>
    </header>
    <main id="genDoc2">

        <section>

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