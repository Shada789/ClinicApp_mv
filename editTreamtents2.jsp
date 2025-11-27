<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	</head>
    <body>
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
	
		PreparedStatement st = conecta.prepareStatement("UPDATE tratamientos SET nombre=?, precio=?, descripcion=? WHERE id_tratamiento=?");
	
		st.setString(1,nom);
		st.setInt(2,precio);
		st.setString(3,desc);
		st.setInt(4,code);
		st.executeUpdate();
	%>
		<h1>Modificación de Tratamientos</h1>
		<p>Modificación realizada con exito</p>
		<button type="button" class="boton" onclick="location.href='visualizeTreatment.jsp'">Lista de Tratamientos
		<button type="button" class="boton" onclick="location.href='editTreatment.jsp'">Seguir Modificando
	</body>
</html>