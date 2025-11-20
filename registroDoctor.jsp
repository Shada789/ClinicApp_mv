<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<html>
<head></head>
<body>
<%
String nombres;
String apP;
String apM;
String email;
double cedula;
String password;
String user;

nombres=request.getParameter("nombre");
apP=request.getParameter("apellidoP");
apM=request.getParameter("apellidoM");
email=request.getParameter("correo");
cedula=Double.parseDouble(request.getParameter("precio"));

Connection conecta;
PreparedStatement st;

Class.forName("com.mysql.cj.jdbc.Driver");
conecta=DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba","root", "n0m3l0");
st=conecta.prepareStatement("INSERT INTO usuario (nombre, paterno, materno, gmail, 
usuario, contraseña, cedula, id_tipo) VALUES (?,?,?,?,?,?,?,?)");
st.setString (1, nombre);
st.setString (2, apP);
st.setString (3, apM);
st.setString (4, email);
st.setString (5, user);
st.setString (6, password);
st.setDouble (7, cedula);
st.setInt (8, 2);
st.executeUpdate();

out.println("<p>Todo joya<p>");

%>Hola</body></html>