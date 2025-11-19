<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>

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
%>