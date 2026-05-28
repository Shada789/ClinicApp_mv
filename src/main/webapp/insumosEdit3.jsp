<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Modificación Insumos</title>
	</head>
	
    <body id="bodDoc">
	<%@ include file="navDoctor.jsp" %>
		
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Modificar Insumo</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		<%
		int code;
		String nom;
		int cantidad;
		
		code=Integer.parseInt(request.getParameter("id_insumo"));
		nom=request.getParameter("nombre");
		cantidad=Integer.parseInt(request.getParameter("cantidad"));
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement("UPDATE insumo SET nombre=?, cantidad_actual=? WHERE id_insumo=?");
	
		st.setString(1,nom);
		st.setInt(2,cantidad);
		st.setInt(3,code);
		st.executeUpdate();
	%>
		<h1>Modificación realizada con exito<h1>
			<button type="button" class="boton" onclick="location.href='insumosSearch.jsp'">Lista de Insumos
			<button type="button" class="boton" onclick="location.href='insumosEdit.jsp'">Seguir Modificando
        </section>
    </main>
	</body>
</html>