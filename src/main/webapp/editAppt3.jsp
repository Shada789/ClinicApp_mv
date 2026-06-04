<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
String id = request.getParameter("id_cita");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String descripcion = request.getParameter("descripcion");
String tipo = request.getParameter("tipo");

String fechaHora = fecha + " " + hora + ":00";

String mensaje = "";
String claseMensaje = "";

Connection con = null;
PreparedStatement st = null;

try{

    Class.forName("com.mysql.cj.jdbc.Driver");

    con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );
    st = con.prepareStatement(
        "UPDATE cita " +
        "SET fecha_hora = ?, notas = ?, tipo = ? " +
        "WHERE id_cita = ?"
    );
    st.setString(1, fechaHora);
    st.setString(2, descripcion);
    st.setString(3, tipo);
    st.setInt(4, Integer.parseInt(id));

    int filas = st.executeUpdate();

    if(filas > 0){
        mensaje = "Cita actualizada correctamente";
        claseMensaje = "mensajeExito";
    }else{
        mensaje = "No se encontró la cita";
        claseMensaje = "mensajeError";
    }
}catch(Exception e){
    mensaje = "Error: " + e.getMessage();
    claseMensaje = "mensajeError";
}finally{
    if(st != null) st.close();
    if(con != null) con.close();
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Modificar Cita</title>
    <link rel="stylesheet" href="clinictyle.css">
</head>

<body id="bodDoc">

<%@ include file="navDoctor.jsp" %>

<header class="nave">
    <img class="logo" src="imgs/image.png" alt="Logo">
    <h1>Modificar Cita</h1>
</header>
<main id="genDoc2">
<section>
    <p class="<%= claseMensaje %>">
        <%= mensaje %>
    </p>
    <button type="button" class="botonImportante" onclick="location.href='editAppt.jsp'"> Volver a citas </button>
</section>
<footer>
    <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
</footer>

</main>

</body>
</html>