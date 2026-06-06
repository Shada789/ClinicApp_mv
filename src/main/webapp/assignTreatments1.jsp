<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="clinic.css" type="text/css">
	<title>Ver Tratamientos</title>
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
	</head>
	<body id="bodDoc">
		<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Ver Tratamientos</h1>
    </header>
	
	<main id="genDoc2">
        <section id="tratamientosProceso">
		
            <h2>Tratamientos Listados</h2>
            <table style="width:100%;" id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Descripción</th>
						<th>Observaciones</th>
						<th></th>
                    </tr>
					
					<%
					Integer idMedico = (Integer) session.getAttribute("id_medico");
                    if (idMedico == null) {
                        response.sendRedirect("index.html");
                        return;
					}
					int idPaciente = Integer.parseInt(request.getParameter("id_paciente"));

					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement(
						"SELECT pt.id, t.id_tratamiento, t.nombre, t.precio, t.descripcion, pt.observaciones "+ 
						"FROM paciente_tratamiento pt " + 
						"INNER JOIN tratamiento t " + 
						"ON pt.id_tratamiento = t.id_tratamiento " + 
						"WHERE pt.id_paciente = ?"
					);
                    
                    st.setInt(1, idPaciente);
		
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					%>	
					
					<tr>
						<td style="width: 20%;"><%=rs.getString("nombre")%></td>
						<td style="width: 10%;"><%=rs.getString("precio")%></td>
						<td style="width: 30%;"><%=rs.getString("descripcion")%></td>
						<td style="width: 30%;"><%=rs.getString("observaciones")%></td>
						<td><a href="assignTreatments4.jsp?id_asignacion=<%=rs.getString("id")%>" onclick="return confirm('¿Esta seguro de querer eliminar este tratamiento?')">
						<button type="submit" class="boton" id="code" >
						<i class="fa-solid fa-trash"></i>Desasignar</td>
					</tr>
					<%
					}
					%>
                </thead>
                <tbody>
                </tbody>

            </table>
			<br>
			<button type="button" onclick="location.href='assignTreatments.jsp'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>