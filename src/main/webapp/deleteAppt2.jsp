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
    <nav id="navDoc2">

        <ul>
            <li><a href="doctorMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li>
            <li><a href="patientManagement.html">
                    <img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
            <li><a href="historyDoctor.html"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li></a></li>
            <li><a href="docTreatments.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span></a></li>
        </ul>
    </nav>
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