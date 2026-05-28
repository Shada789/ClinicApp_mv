<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.*" %>

<html>
<head>
	<link rel="stylesheet" href="clinic.css" content="text/css">
	<title>Busqueda de Insumos</title>
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
        <h1>Buscar Insumo</h1>
    </header>
	
    <main id="genDoc2">
        <section id="buscarTratamiento">
			
			<article>
                <h2>Buscar Insumo</h2>
                
                    <form action="insumosSearch2.jsp" method="post">
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre de Insumo...">
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
                        <th>Cantidad</th>
                    </tr>
	<%
		String nom;
		nom=request.getParameter("nombre");

        Integer idMedico = (Integer) session.getAttribute("id_medico");
        if (idMedico == null) {
             response.sendRedirect("index.html");
            return;
        }
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		
		st=conecta.prepareStatement("SELECT * FROM insumo where nombre=? AND id_medico=?");
                
		st.setString(1,nom);
		st.setInt(2,idMedico);
		
		ResultSet rs = st.executeQuery();
		while(rs.next()){
	%>
		<tr>
			<td style="width: 70%;"><%=rs.getString("nombre")%></td>
			<td style="width: 30%;"><%=rs.getString("cantidad_actual")%></td>
			<td style="border:none;"></td>
		</tr>
	<%}
	%>
		</thead>
        </table>
		<br>
		
		<button type="button" onclick="location.href='insumosSearch.jsp'" class="boton">Deshacer Busqueda</button>
        </section>
    </main>
</body>
</html>