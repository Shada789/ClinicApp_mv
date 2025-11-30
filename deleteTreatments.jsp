<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="clinictyle.css" type="text/css">
	<title>Tratamientos en Proceso</title>
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
	
	
	<main id="genDoc2">
        <header id="headerTratamientos">
            <h1>ClinicApp</h1>
        </header>

        <section id="tratamientosProceso">
            <h2>Tratamientos Listados</h2>
			
            <table id="tablasDia">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Descripción</th>
                    </tr>
					
					<%
					String name;
					String marc;
					double price;
		
					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement("SELECT * FROM tratamientos");
		
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					%>	
					
					<tr>
						<td><%=rs.getString("nombre")%></td>
						<td><%=rs.getString("precio")%></td>
						<td><%=rs.getString("descripcion")%></td>
						<td><a href="deleteTreatment.jsp?id_tratamiento=<%=rs.getString("id_tratamiento")%>"><button type="submit" class="boton" id="code">Eliminar</td>
					</tr>
					<%
					}
					%>
                </thead>
					
                <tbody>
					
                </tbody>
            </table>
        </section>
        <footer id="footerTratamientos">
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

	</body>
</html>