<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

<%
String nom;
String apP;
String apM;
String mail;
double ced;
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
conecta=DriverManager.getConnection("jdbc:mysql://localhost:3306/prueba","root", "n0m3lo003");
st=conecta.prepareStatement("INSERT INTO ");
%>