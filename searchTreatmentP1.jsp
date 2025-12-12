<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinic.css" type="text/css">
    <title>Busqueda de Tratamientos</title>
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
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
	
        <section id="buscarTratamiento">
            <article>
                <h2>Buscar Tratamiento</h2>
                    <form action="searchTreatmentP2.jsp" method="post">
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
		int code;
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
			<td style="width: 25%;"><%=rs.getString("nombre")%></td>
			<td style="width: 10%;">$<%=rs.getString("precio")%>.0</td>
			<td style="width: 65%;"><%=rs.getString("descripcion")%></td>
			<td style="border: none;"></td>
		</tr>
		<%}
		%>
		</thead>
        </table>
		<br>
		
		<button type="button" onclick="location.href='patientTreatment1.jsp'" class="boton">Regresar</button>
        </section>
    </main>
</body>
</html>