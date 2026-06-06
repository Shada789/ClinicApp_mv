<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="clinic.css" type="text/css">
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
	<title>Gestionar Tratamientos</title>
	</head>
	
	<body id="bodDoc">
	<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Gestionar Tratamientos</h1>
    </header>
	
	<main id="genDoc2">
        <section id="tratamientosProceso">
		
            <h2>Lista de Pacientes</h2>

    <table style="width:100%;" id="tablasNoche">
    <thead>
        <tr>
            <th>Nombre del paciente</th>
            <th></th>
			<th></th>
        </tr>
    <%
        Integer idMedico = (Integer) session.getAttribute("id_medico");

        if (idMedico == null) {
            response.sendRedirect("index.html");
            return;
        }

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection conecta = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs",
            "root",
            "n0m3l0"
        );

        PreparedStatement psPac = conecta.prepareStatement(
            "SELECT p.id_paciente, u.nombre, u.paterno, u.materno " +
            "FROM paciente p " +
            "JOIN usuario u ON p.id_usuario = u.id_usuario " +
            "WHERE p.id_medico = ?"
        );

        psPac.setInt(1, idMedico);

        ResultSet rsPac = psPac.executeQuery();

        while (rsPac.next()) {
    %>

        <tr>
            <td style="width:80%;">
                <%= rsPac.getString("nombre") %>
                <%= rsPac.getString("paterno") %>
                <%= rsPac.getString("materno") %>
            </td>

            <td>
                <a href="assignTreatments2.jsp?id_paciente=<%= rsPac.getInt("id_paciente") %>">
                    <button type="button" class="boton">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Asignar
                    </button>
                </a>
            </td>
			<td>
                <a href="assignTreatments1.jsp?id_paciente=<%= rsPac.getInt("id_paciente") %>">
                    <button type="button" class="boton">
                        <i class="fa-solid fa-pen-to-square"></i>
                        Ver Tratamientos
                    </button>
                </a>
            </td>
        </tr>

    <%
        }

        rsPac.close();
        psPac.close();
        conecta.close();
    %>
	</thead>
	<tbody>
    </tbody>

	</table>

			<br>
			<button type="button" onclick="location.href='docTreatments.jsp'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>