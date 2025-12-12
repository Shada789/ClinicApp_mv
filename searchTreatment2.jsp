<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.*" %>

<html>
<head>
	<link rel="stylesheet" href="clinic.css" content="text/css">
	<title>Busqueda de Tratamiento</title>
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
</head>
	
<body id="bodDoc">

    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp">
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
        <h1>Buscar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="buscarTratamiento">
			
			<article>
                <h2>Buscar Tratamiento</h2>
                
                    <form action="searchTreatment2.jsp" method="post">
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre de Tratamiento...">
                        <button type="submit" id="code">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
                    </form>
            </article>
			<br>
			
            <table style="width:100%;"  id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Descripción</th>
                    </tr>
	<%
		String nom;
		nom=request.getParameter("nombre");
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		
		st=conecta.prepareStatement("SELECT * FROM tratamientos where nombre=?");
		st.setString(1,nom);
		
		ResultSet rs = st.executeQuery();
		while(rs.next()){
	%>
		<tr>
			<td style="width: 25%;"><%=rs.getString("nombre")%></td>
			<td style="width: 10%;">$<%=rs.getString("precio")%>.0</td>
			<td style="width: 70%;"><%=rs.getString("descripcion")%></td>
			<td style="border:none;"></td>
		</tr>
	<%}
	%>
		</thead>
        </table>
		<br>
		
		<button type="button" onclick="location.href='searchTreatment1.jsp'" class="boton">Deshacer Busqueda</button>
        </section>
    </main>
</body>
</html>