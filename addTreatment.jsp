<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<html>
	<head>
	<link rel="stylesheet" href="estiloia.css">
	</head>
	<%
		int code;
		String name;
		String marc;
		double price;
	
		
		code=Integer.parseInt(request.getParameter("codigo"));
		name=request.getParameter("nombre");
		marc=request.getParameter("marca");
		price=Double.parseDouble(request.getParameter("precio"));
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba","root","n0m3l0");
		st=conecta.prepareStatement("Insert into productos values(?,?,?,?)");
		st.setInt(1,code);
		st.setString(2,name);
		st.setString(3,marc);
		st.setDouble(4,price);
		st.executeUpdate();
		
		System.out.println(code);
		System.out.println(name);
		
		System.out.println(price);
	
	
	%>
	
	<body>
	
	<h1>Registro de Productos</h1>
	<p>Registro realizado con exito</p>
	<form action="addTreatment.html" method="post">
    <input type="submit" value="Vale!">
	</body>
	
</html>