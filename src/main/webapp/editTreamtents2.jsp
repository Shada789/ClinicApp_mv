<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Modificación Tratamientos</title>
	</head>
	
    <body id="bodDoc">
	<nav id="navDoc">
		<ul>
			<li><a href="doctorMain.html">
					<img src="imgs/Codementor--Streamline-Simple-Icons.svg">
					<span>Inicio</span></a></li>
			<li><a href="patientManagement.html">
					<img src="imgs/patient-svgrepo-com.svg">
					<span>Pacientes</span></a></li>
			<li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
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
        <h1>Modificar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		<%
		int code;
		String nom;
		int precio;
		String desc;
		
		code=Integer.parseInt(request.getParameter("id_tratamiento"));
		nom=request.getParameter("nombre");
		precio=Integer.parseInt(request.getParameter("precio"));
		desc=request.getParameter("descripcion");
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
	
		PreparedStatement st = conecta.prepareStatement("UPDATE tratamientos SET nombre=?, precio=?, descripcion=? WHERE id_tratamiento=?");
	
		st.setString(1,nom);
		st.setInt(2,precio);
		st.setString(3,desc);
		st.setInt(4,code);
		st.executeUpdate();
	%>
		<h1>Modificación realizada con exito<h1>
			<button type="button" class="boton" onclick="location.href='searchTreatment1.jsp'">Lista de Tratamientos
			<button type="button" class="boton" onclick="location.href='editTreatments.jsp'">Seguir Modificando
        </section>
    </main>
	</body>
</html>