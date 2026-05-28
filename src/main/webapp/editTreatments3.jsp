<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Modificación Tratamientos</title>
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
        <h1>Modificar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		<%
		int code;
		String nom;
		int precio;
		String desc;
		
		code=Integer.parseInt(request.getParameter("id_tratamiento"));
		nom=request.getParameter("nombre");
		precio=Integer.parseInt(request.getParameter("precio"));
		desc=request.getParameter("descripcion");
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement("UPDATE tratamiento SET nombre=?, precio=?, descripcion=? WHERE id_tratamiento=?");
	
		st.setString(1,nom);
		st.setInt(2,precio);
		st.setString(3,desc);
		st.setInt(4,code);
		st.executeUpdate();
	%>
		<h1>Modificación realizada con exito<h1>
			<button type="button" class="boton" onclick="location.href='searchTreatment1.jsp'">Lista de Tratamientos
			<button type="button" class="boton" onclick="location.href='editTreatments1.jsp'">Seguir Modificando
        </section>
    </main>
	</body>
</html>