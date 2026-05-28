<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>
	<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="clinic.css" type="text/css">
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
	<title>Modificación Tratamientos</title>
	</head>
	
	<body id="bodDoc">
	<%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Modificar Tratamiento</h1>
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
                        <th></th>
                    </tr>
					
					<%
					Integer idMedico = (Integer) session.getAttribute("id_medico");
                                        if (idMedico == null) {
                                                response.sendRedirect("index.html");
                                                return;
                                        }

					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement("SELECT * FROM tratamiento WHERE id_medico=?");
                    
                                        st.setInt(1,idMedico);
					
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					int code = rs.getInt("id_tratamiento");
					%>	
					
					<tr>
						<td style="width: 25%;"><%=rs.getString("nombre")%></td>
						<td style="width: 10%;">$<%=rs.getString("precio")%>.0</td>
						<td style="width: 65%;"><%=rs.getString("descripcion")%></td>
						<td><a href="editTreatments2.jsp?id_tratamiento=<%=rs.getString("id_tratamiento")%>"><button type="submit" class="boton" id="code" onclick="cargarHistorial(<%= code %>)"><i class="fa-solid fa-pen-to-square"></i>Modificar</td>
					</tr>
					<%
					}
					%>
                </thead>
					
                <tbody>
					
                </tbody>
            </table>
			<br>
			<button type="button" onclick="location.href='docTreatments.html'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>