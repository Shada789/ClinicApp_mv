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
		String pac;
		String fecha;
		String hora;
		String tipo;
        String id;

        id = request.getParameter("id");
		pac=request.getParameter("paciente");
		fecha=request.getParameter("fecha");
		hora=request.getParameter("hora");
		tipo=request.getParameter("tipo");
        String fecha_hora= fecha + " " + hora;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement("UPDATE citas SET nombre=?, fecha_hora=?, tipo=? WHERE id_cita=?");
	
		st.setString(1, pac);
		st.setString(2, fecha_hora);
		st.setString(3, tipo);
        st.setInt(4, Integer.parseInt(id));
		st.executeUpdate();
	%>
		<h1>Reagendeo de citas</h1>
		<p>Modificación realizada con exito</p>
		<button type="button" class="boton" onclick="location.href='editAppt.jsp'">Lista de Tratamientos </button>
		<button type="button" class="boton" onclick="location.href='editAppt.jsp'">Seguir Modificando </button>
	</body>
</html>