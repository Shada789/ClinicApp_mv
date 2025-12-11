<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinic.css" type="text/css">
        <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>

    <title>Tratamientos del Paciente</title>
</head>

<body id="bodDoc">
    <nav id="navDoc">
        <ul>
            <li><a href="patientMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span> Inicio</span></a></li>
            <li><a href="patientHistory.jsp">
                    <img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li>
            <li><a href="patientAppts.html">
                    <img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li>
            <li><a href="patientTreatment.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span>
                </a></li>
            <li><a href="patientMyProfile.html">
                    <img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span>
                </a></li>
        </ul>
    </nav>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Tratamientos</h1>
    </header>
	
    <main id="genDoc2">
        <section id="tratamientosProceso">
		
            <h2>Lista de Doctores</h2>
            <table style="width:100%;"  id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre(s)</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
						<th></th>
                    </tr>
		
	<%
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st = conecta.prepareStatement("SELECT * FROM usuario where id_tipo>=2");
		
		
		ResultSet rs = st.executeQuery();
		while(rs.next()){
	%>
		</thead>	
        <tbody>
		<tr>
			<td style="width: 27%;"><%=rs.getString("nombre")%></td>
			<td style="width: 27%;"><%=rs.getString("paterno")%></td>
			<td style="width: 27%;"><%=rs.getString("materno")%></td>
			<td style="width: 19%; text-align: center;"><a href="searchTreatmentP1.jsp?id_tratamiento=<%=rs.getString("id_usuario")%>">
			<button type="submit" class="boton" id="code" >
			Ver Tratamientos</td>
		</tr>
	<%}
	%>
				</tbody>
            </table>
			<br>
			
		<button type="button" onclick="location.href='patientTreatment.html'" class="boton">Regresar</button>	
        </section>
    </main>
</body>

</html>