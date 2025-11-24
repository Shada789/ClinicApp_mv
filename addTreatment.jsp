<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<html>
	<head>
	</head>
	<%
		String desc;
		String nom;
		int price;
		
		nom=request.getParameter("nombre");
		price=Integer.parseInt(request.getParameter("precio"));
		desc=request.getParameter("descripcion");
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st=conecta.prepareStatement("Insert into tratamientos (nombre,precio,descripcion) values(?,?,?)");
		
		st.setString(1,nom);
		st.setInt(2,price);
		st.setString(3,desc);
		st.executeUpdate();
		
	%>
	
	<body>
	
	<h1>Registro de Tratamientos</h1>
	<p>Registro realizado con exito</p>
	
	</body>
	
</html>