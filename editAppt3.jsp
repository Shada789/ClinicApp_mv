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
		<%
		String pac;
		String fecha;
		String hora;
		String tipo;
        String id;

        id = request.getParameter("id");
		pac=request.getParameter("paciente");
		fecha=request.getParameter("fecha");
		hora=request.getParameter("hora");
		tipo=request.getParameter("tipo");
        String fecha_hora= fecha + " " + hora;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement("UPDATE citas SET nombre=?, fecha_hora=?, tipo=? WHERE id_cita=?");
	
		st.setString(1, pac);
		st.setString(2, fecha_hora);
		st.setString(3, tipo);
        st.setInt(4, Integer.parseInt(id));
		st.executeUpdate();
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

        <h1>Modificar Cita</h1>
    </header>
    <main id="genDoc2">
      
        <section>
		<h1>Reagendeo de citas</h1>
		<p>Modificación realizada con exito</p>
		<button type="button" class="boton" onclick="location.href='editAppt.jsp'">Lista de Citas </button>
		<button type="button" class="boton" onclick="location.href='editAppt.jsp'">Seguir Modificando </button>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
</body>
</html>