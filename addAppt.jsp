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
        #formCita input,
        #formCita select {
            border: none;
            color: black;
            font-size: 16px;
            background-color: transparent;
        }
        #formCita button {
            grid-column: 1 / -1;
            justify-self: center;
            padding: 10px 20px;
            font-size: 18px;
        } 
        #tablasDia {
    width: 100% !important;
    border-collapse: collapse !important;
    display: table !important;
    float: none !important;
}

#tablasDia th, 
#tablasDia td {
    border: 1px solid #ccc !important;
    padding: 10px !important;
    text-align: left !important;
}

#tablasDia th {
    background: linear-gradient(90deg, #8b0b44, #1c3a7e) !important;
    color: white !important;
}
#tablasDia th:nth-child(1),
#tablasDia td:nth-child(1) {
    width: 40%;  
}

#tablasDia th:nth-child(2),
#tablasDia td:nth-child(2) {
    width: 35%;  
}

#tablasDia th:nth-child(3),
#tablasDia td:nth-child(3) {
    width: 25%;   
}
#Regreso{
    text-align:right !important;
    width:10% !important;
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
PreparedStatement stInsert = null;
PreparedStatement stSelect = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conecta = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );

    stInsert = conecta.prepareStatement(
        "INSERT INTO citas (fecha_hora, nombre, tipo) VALUES (?,?,?)"
    );

    stInsert.setString(1, fecha_hora);
    stInsert.setString(2, pac);
    stInsert.setString(3, tipo);

    stInsert.executeUpdate();
    out.println("<p>Todo joya ✔</p>");

    stSelect = conecta.prepareStatement("SELECT * FROM citas");
    rs = stSelect.executeQuery();

} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {

}
%>

<nav id="navDoc">
    <ul>
        <li><a href="doctorMain.jsp"><img src="imgs/Codementor--Streamline-Simple-Icons.svg"><span>Inicio</span></a></li>
        <li><a href="patientManagement.html"><img src="imgs/patient-svgrepo-com.svg"><span>Pacientes</span></a></li>
        <li><a href="historyDoctor.html"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg"><span>Historial</span></a></li>
        <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg"><span>Citas</span></a></li>
        <li><a href="docTreatments.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg"><span>Tratamientos</span></a></li>
        <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg"><span>Perfil</span></a></li>
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
            <th>Paciente</th>
            <th>Fecha</th>
            <th>Tipo</th>
        </tr>
    </thead>
    <tbody>
        <% if (rs != null) { while (rs.next()) { %>
        <tr>
            <td><%= rs.getString("nombre") %></td>
            <td><%= rs.getString("fecha_hora") %></td>
            <td><%= rs.getString("tipo") %></td>
        </tr>
        <% }} %>
    </tbody>
</table>
    </section>

    <footer>
        <p>&copy; 2025 ClinicApp | Todos los derechos</p>
    </footer>
</main>

<%
    if (rs != null) rs.close();
    if (stInsert != null) stInsert.close();
    if (stSelect != null) stSelect.close();
    if (conecta != null) conecta.close();
%>

<button type="button" onclick="location.href='addAppt.html'" class="boton" id="Regreso">Regresar</button>

</body>
</html>