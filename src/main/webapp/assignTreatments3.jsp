<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Asignación Tratamientos</title>
	</head>
	
    <body id="bodDoc">
	<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
		
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Asignar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		<%
		int idPaciente = Integer.parseInt(request.getParameter("id_paciente"));
		int idTratamiento = Integer.parseInt(request.getParameter("id_tratamiento"));
		Integer idMedico = (Integer) session.getAttribute("id_medico");
		String fechaInicio = request.getParameter("fecha_inicio");
		String fechaFin = request.getParameter("fecha_fin");
		String observaciones = request.getParameter("observaciones");
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement ps = conecta.prepareStatement(
    		"INSERT INTO paciente_tratamiento " +
    		"(id_paciente, id_tratamiento, id_medico, " +
    		"fecha_inicio, fecha_fin, observaciones) " +
    		"VALUES (?, ?, ?, ?, ?, ?)"
		);
	
		ps.setInt(1, idPaciente);
		ps.setInt(2, idTratamiento);
		ps.setInt(3, idMedico);
		ps.setDate(4, java.sql.Date.valueOf(fechaInicio));
		ps.setDate(5, java.sql.Date.valueOf(fechaFin));
		ps.setString(6, observaciones);
		ps.executeUpdate();
	%>
		<h1>Asignación realizada con éxito</h1>
		<div style="display: flex; justify-content: center;">
			<button type="button" class="boton" onclick="location.href='assignTreatments.jsp'">Lista de Pacientes
		</div>
        </section>
    </main>
	</body>
</html>