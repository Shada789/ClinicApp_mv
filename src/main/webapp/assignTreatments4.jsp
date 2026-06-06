<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Ver Tratamientos</title>
	</head>
	
    <body id="bodDoc">
	<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
		
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Ver Tratamientos</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		<%
		int idAsignacion = Integer.parseInt(request.getParameter("id_asignacion"));
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement(
    		"DELETE FROM paciente_tratamiento WHERE id = ?"
		);
	
		st.setInt(1, idAsignacion);
		st.executeUpdate();
	%>
		<h1>Tratamiento desasignado con éxito</h1>
		<div style="display: flex; justify-content: center;">
			<button type="button" class="boton" onclick="location.href='assignTreatments.jsp'">Regresar
		</div>
        </section>
    </main>
	</body>
</html>