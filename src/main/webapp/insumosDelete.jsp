<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="clinic.css" type="text/css">
	<title>Eliminación de Insumo</title>
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
	</head>
	<body id="bodDoc">
	<nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li><li><a href="patientManagement.html">
                    <img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
            <li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li></a></li>
            <li><a href="docTreatments.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span></a></li>
			<li><a href="insumos.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Insumos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span></a></li>
        </ul>
    </nav>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Eliminar Insumo</h1>
    </header>
	
	<main id="genDoc2">
        <section id="tratamientosProceso">
		
            <h2>Insumos Listados</h2>
            <table style="width:100%;" id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Cantidad</th>
						<th></th>
                    </tr>
					
					<%
					String name;
					String marc;
					double price;
		
					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement("SELECT * FROM tratamiento");
		
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					%>	
					
					<tr>
						<td style="width: 25%;"><%=rs.getString("nombre")%></td>
						<td style="width: 10%;"><%=rs.getString("precio")%></td>
						<td><a href="deleteTreatment.jsp?id_tratamiento=<%=rs.getString("id_tratamiento")%>" onclick="return confirm('¿Esta seguro de querer eliminar este tratamiento?')">
						<button type="submit" class="boton" id="code" >
						<i class="fa-solid fa-trash"></i>Eliminar</td>
					</tr>
					<%
					}
					%>
                </thead>
					
                <tbody>
					
                </tbody>
            </table>
			<br>
			<button type="button" onclick="location.href='insumos.html'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>