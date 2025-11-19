<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<html>
<head></head>
<body>
<%
String nom;
String apP;
String apM;
String mail;
double cedula;
String user;
String pass;

nom=request.getParameter("nombre");
apP=request.getParameter("apellidoP");
apM=request.getParameter("apellidoM");
mail=request.getParameter("correo");
cedula=request.getParameter("cedula");
user=request.getParameter("usuario");
pass=request.getParameter("contrasenia");

Class.forName("com.mysql.cj.jdbc.Driver");
conecta=DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba","root", "n0m3l0");
st = conecta.prepareStatement(
    "INSERT INTO usuario (nombre, paterno, materno, gmail, usuario, contraseña, cedula, id_tipo) " +
    "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
);
st.setString(1, request.getParameter("nombre"));
st.setString(2, request.getParameter("apellidoP"));
st.setString(3, request.getParameter("apellidoM"));
st.setString(4, request.getParameter("correo"));
st.setString(5, request.getParameter("usuario"));
st.setString(6, request.getParameter("contrasenia"));
st.setString(7, request.getParameter("cedula"));
st.setInt(8, Integer.parseInt(request.getParameter("id_tipo")));
st.executeUpdate();
out.println("Registro Exitoso");
%></body></html>