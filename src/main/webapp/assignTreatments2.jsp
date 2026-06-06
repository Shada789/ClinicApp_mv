<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>

	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Asignación de Tratamientos</title>
	</head>
    
	<body id="bodDoc">
	<%response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
    <%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Asignar Tratamiento</h1>
    </header>
	
    <main id="genDoc2">
        <section id="formTrat">
		
	<%
		int idPaciente = Integer.parseInt(request.getParameter("id_paciente"));
		Integer idMedico = (Integer) session.getAttribute("id_medico");
    	if (idMedico == null) {
            response.sendRedirect("index.html");
            return;
        }
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		PreparedStatement psTrat = conecta.prepareStatement(
    		"SELECT id_tratamiento, nombre " +
    		"FROM tratamiento " +
    		"WHERE id_medico = ?"
		);

		psTrat.setInt(1, idMedico);
		ResultSet rsTrat = psTrat.executeQuery();	
	%>
		<article>

	<form action="assignTreatments3.jsp" method="post">
    	<input type="hidden" name="id_paciente" value="<%= idPaciente %>">

    <label>Tratamiento:</label>
    <select name="id_tratamiento" required>
			<option value="">Seleccione un tratamiento</option>
        <%
        while(rsTrat.next()){
        %>
            <option value="<%= rsTrat.getInt("id_tratamiento") %>">
                <%= rsTrat.getString("nombre") %>
            </option>
        <%
        }
        %>
    </select>

    <label>.    Fecha inicio:</label>
    <input type="date" name="fecha_inicio" required>

    <label>.    Fecha fin:</label>
    <input type="date" name="fecha_fin" required>
	<br><br>

    <label>Observaciones:</label>
    <textarea name="observaciones"></textarea>
	<br><br>

    <button class="botonImportante" type="submit" id="code">
        Asignar Tratamiento
    </button>

</form>
		<button type="button" onclick="location.href='assignTreatments.jsp'" class="boton">Regresar</button>
		</article>
		
		</section>
	</main>
</body>
</html>