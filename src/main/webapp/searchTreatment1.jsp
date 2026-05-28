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
        <h1>Lista de Tratamientos</h1>
    </header>
	
    <main id="genDoc2">
	
        <section id="buscarTratamiento">
            <article>
                <h2>Buscar Tratamiento</h2>
                    <form action="searchTreatment2.jsp" method="post">
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre de Tratamiento...">
                        <button type="submit" id="code">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
                    </form>
            </article>
			<br>
            
			
            <table style="width: 100%;" id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Precio</th>
                        <th>Descripción</th>
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
						<td style="width: 70%;"><%=rs.getString("descripcion")%></td>
						<td style="border:none;"></td>
					</tr>
					<%
					}
					%>
                </thead>
            </table>
		<br>
		<button type="button" onclick="location.href='docTreatments.jsp'" class="boton">Regresar</button>
        </section>
    </main>
</body>
</html>