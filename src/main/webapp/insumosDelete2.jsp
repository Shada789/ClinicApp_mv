<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Eliminación de Tratamiento</title>
	</head>
	<body id="bodDoc">
		<%Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
		
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Eliminar Tratamiento</h1>
    </header>

	<main id="genDoc2">
        <section id="formTrat">
	<%
		String code;
		code=request.getParameter("id_insumo");
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st = conecta.prepareStatement("DELETE FROM insumo WHERE id_insumo=?");
		
		st.setString(1,code);
		st.executeUpdate();

	%>
		<h1>Eliminación realizada con exito<h1>
			<button type="button" class="boton" onclick="location.href='insumosSearch.jsp'">Lista de Tratamientos
			<button type="button" class="boton" onclick="location.href='insumosDelete.jsp'">Seguir Eliminando
		</section>
    </main>	
	</body>
</html>