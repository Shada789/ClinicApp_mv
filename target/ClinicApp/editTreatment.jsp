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
        <h1>Modificar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		
	<%
	String codigo = request.getParameter("id_tratamiento");
    String nombre = "";
    String precio = "";
    String desc = "";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
			PreparedStatement st = conecta.prepareStatement("SELECT * FROM tratamientos WHERE id_tratamiento=?");
			st.setInt(1, Integer.parseInt(codigo));

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				nombre = rs.getString("nombre");
				precio = rs.getString("precio");
				desc = rs.getString("descripcion");
			}

		}
		catch (Exception e) {
			out.println("ERROR al cargar: " + e.getMessage());
		}
	%>
		<article>
			<form id="formRegistroDoctor" action="editTreamtents2.jsp" method="post">
	
				<label style="display: none;">Código:</label>
				<input style="display: none;" type="text" name="id_tratamiento" value="<%= codigo %>" readonly>
		
				<label><b>Nombre:</b></label><br>
				<input type="text" name="nombre" placeholder="Nombre del Tratamiento" value="<%= nombre %>" required><br>

				<label><b>Precio:</b></label><br>
				<input type="number" name="precio" placeholder="Precio" value="<%= precio %>" required><br>

				<label><b>Descripción:</b></label><br>
				<textarea id="areaHistorial" name="descripcion" cols="50" rows="1"
                placeholder="Escribe una breve descripción del tratamiento, su propósito y las indicaciones"><%= desc %></textarea>
				
				<button type="submit" class="botonImportante" id="code">Guardar Cambios</button>
			
			</form>
			<button type="button" onclick="location.href='editTreatments.jsp'" class="boton">Regresar</button>
		</article>
		
		</section>
	</main>
</body>
</html>