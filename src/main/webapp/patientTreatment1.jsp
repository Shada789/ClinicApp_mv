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
    <%@ include file="navPaciente.jsp" %>

	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Tratamientos</h1>
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
						<th style="display: none;"></th>
                    </tr>
					
					<%
					Integer idPaciente = (Integer) session.getAttribute("id_paciente");
    				if (idPaciente == null) {
        				response.sendRedirect("index.html");
        				return;
    				}

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
						<td style="width: 15%;">$<%=rs.getString("precio")%>.0</td>
						<td style="width: 30%;"><%=rs.getString("descripcion")%></td>
						<td style="width: 29%;"><%=rs.getString("observaciones")%></td>
						<td style="width: 1%; border: none;"></td>
					</tr>
					<%
					}
					%>
                </thead>
                <tbody>
                </tbody>

            </table>
			<br>
			<button type="button" onclick="location.href='patientTreatment.jsp'" class="boton">Regresar</button>
        </section>
    </main>

</body>

</html>