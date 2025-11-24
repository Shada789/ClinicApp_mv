<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<html>
<head></head>
<body>
<%
String pac = request.getParameter("paciente");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String tipo = request.getParameter("tipo");
String fecha_hora = fecha + " " + hora;

Class.forName("com.mysql.cj.jdbc.Driver");
conecta=DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root", "n0m3l0");
st = conecta.prepareStatement("INSERT INTO citas (fecha_hora, nombre, tipo) VALUES (?,?,?)");

st.setString(1, fecha_hora);
st.setString(2, nombre);
st.setString(3, tipo);

st.executeUpdate();

out.println("<p>Todo joya<p>");

%>Registro exitoso</body></html>