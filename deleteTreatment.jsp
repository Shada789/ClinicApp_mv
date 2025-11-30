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
		String code;
		code=request.getParameter("id_tratamiento");
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st = conecta.prepareStatement("DELETE FROM tratamientos WHERE id_tratamiento=?");
		
		st.setString(1,code);
		st.executeUpdate();

	%>
		<h1>Eliminación de Tratamientos</h1>
		<p>Eliminación realizada con exito</p>
		<button type="button" class="boton" onclick="location.href='visualizeTreatment.jsp'">Lista de Tratamientos
		<button type="button" class="boton" onclick="location.href='deleteTreatments.jsp'">Seguir Eliminando
		                                    <button type="button" onclick="location.href='docTreatments.html'" class="boton">Regresar</button>

	</body>
	
</html>