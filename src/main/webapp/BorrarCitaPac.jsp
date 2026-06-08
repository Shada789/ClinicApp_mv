<!DOCTYPE html>
<html lang="es">
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

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
            width: 15%;  
        }

        #tablasDia th:nth-child(2),
        #tablasDia td:nth-child(2) {
            width: 25%;  
        }

        #tablasDia th:nth-child(3),
        #tablasDia td:nth-child(3) {
            width: 25%;   
        }
        #tablasDia th:nth-child(4),
        #tablasDia td:nth-child(4) {
            width: 20%;   
        }
        #tablasDia th:nth-child(5),
        #tablasDia td:nth-child(5) {
            width: 15%;   
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
Integer idPaciente = (Integer) session.getAttribute("id_paciente");

if(idPaciente == null){
    response.sendRedirect("login.html");
    return;
}

Connection conecta = null;
PreparedStatement stInsert = null;
PreparedStatement stSelect = null;
ResultSet rs = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

  conecta = DriverManager.getConnection(
    "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
    "root", "n0m3l0"
);

    stSelect = conecta.prepareStatement(
    "SELECT c.id_cita, c.fecha_hora, c.tipo, c.notas, " +
    "u.nombre, u.paterno, u.materno " +
    "FROM cita c " +
    "JOIN medico m ON c.id_medico = m.id_medico " +
    "JOIN usuario u ON m.id_usuario = u.id_usuario " +
    "WHERE c.id_paciente = ? " +
    "AND c.estado = 'programada' " +
    "ORDER BY c.fecha_hora"
    );

    stSelect.setInt(1, idPaciente);
    rs = stSelect.executeQuery();

} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {

}
%>

     <%@ include file="navPaciente.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Cancelar Cita</h1>
    </header>
    <main id="genDoc2">

        <section>

            <table id="tablasDia">
    <thead>
        <tr>
            <th>Medico</th>
            <th>Fecha</th>
            <th>Tipo</th>
            <th>Descripción</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <% if (rs != null) { while (rs.next()) { %>
        <tr>
            <td>
            <%= rs.getString("nombre") %>
            <%= rs.getString("paterno") %>
            <%= rs.getString("materno") %>
            </td>
            <td><%= rs.getString("fecha_hora") %></td>
            <td><%= rs.getString("tipo") %></td>
            <td><%= rs.getString("notas") %></td>
            <td><form action="BorrarCitaPac2.jsp" method="post">
                <input type="hidden" name="id_cita" value="<%= rs.getInt("id_cita") %>">
                <button type="submit" class="botonImportante">
                    Cancelar
                </button>
            </form></td>
        </tr>
        <% }} %>
    </tbody>
</table>
    <button type="button" onclick="location.href='patientAppts.jsp'" class="boton">Regresar</button>
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


</body>

</html>