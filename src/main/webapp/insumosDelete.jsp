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
	<%@ include file="navDoctor.jsp" %>
	
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
					%>	
					
					<tr>
						<td style="width: 70%;"><%=rs.getString("nombre")%></td>
						<td style="width: 15%;"><%=rs.getString("cantidad_actual")%></td>
						<td><a href="insumosDelete2.jsp?id_insumo=<%=rs.getString("id_insumo")%>" onclick="return confirm('¿Esta seguro de querer eliminar este tratamiento?')">
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
			<button type="button" onclick="location.href='insumos.jsp'" class="boton">Regresar</button>
        </section>
        
    </main>

	</body>
</html>