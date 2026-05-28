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
	<title>Modificación Insumos</title>
	</head>
	
	<body id="bodDoc">
		<%Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);%>
	<%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Modificar Insumo</h1>
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
					Integer idMedico = (Integer) session.getAttribute("id_medico");
                                        if (idMedico == null) {
                                                response.sendRedirect("index.html");
                                                return;
                                        }

					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement("SELECT * FROM insumo WHERE id_medico=?");
                    
                                        st.setInt(1,idMedico);
					
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					int code = rs.getInt("id_insumo");
					%>	
					
					<tr>
						<td style="width: 70%;"><%=rs.getString("nombre")%></td>
						<td style="width: 15%;"><%=rs.getString("cantidad_actual")%></td>
						<td><a href="insumosEdit2.jsp?id_insumo=<%=rs.getString("id_insumo")%>"><button type="submit" class="boton" id="code" onclick="cargarHistorial(<%= code %>)"><i class="fa-solid fa-pen-to-square"></i>Modificar</td>
					</tr>
					<%
					}
					%>
                </thead>
					
                <tbody>
					
                </tbody>
            </table>
			<br>
			<button type="button" onclick="location.href='insumos.jsp'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>