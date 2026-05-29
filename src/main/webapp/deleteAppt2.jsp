<!DOCTYPE html>
<html lang="es">
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Modificar Cita</title>
    <style>
        #formCita label,
#formCita input, #formCita select {

    border: none;
    color: black;
    font-size: 16px;
        background-color: transparent;


}
#formCita button{
    grid-column: 1 / -1;
    justify-self: center;
    padding: 10px 20px;
    font-size: 18px;
}
    </style>
</head>
    <body id="bodDoc">
        <%@ include file="navDoctor.jsp" %>
		<%
		String id;
		id = request.getParameter("id_cita");
		if(id!=null){
			try{
				Connection conecta;
				PreparedStatement st;
				Class.forName("com.mysql.cj.jdbc.Driver");
				
				conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
				st = conecta.prepareStatement("Delete from citas where id_cita = ?");
				st.setString(1, id);
				st.executeUpdate();
			} catch (Exception e){
				out.println("Mensaje de excepción" + e.getMessage());
			}
			out.println("Eliminado correctamente");
		}
	%>
         <%@ include file="navDoctor.jsp" %>

     <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Cancelar Cita</h1>
    </header>
    <main id="genDoc2">
      
        <section>
		<h1>Cancelación de citas</h1>
		<p>Cita cancelada con exito</p>
		<button type="button" class="boton" onclick="location.href='deleteAppt.jsp'">Regresar </button>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
</body>
</html>