<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<html>
<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Registro de Insumo</title>
</head>
	<%
		String nom;
		int cant;
		
		nom=request.getParameter("nombre");
		cant=Integer.parseInt(request.getParameter("cant"));

        Integer idMedico = (Integer) session.getAttribute("id_medico");
        if (idMedico == null) {
                response.sendRedirect("index.html");
                return;
        }
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st=conecta.prepareStatement("Insert into insumo (id_medico,nombre,cantidad_actual) values(?,?,?)");
		
		st.setInt(1,idMedico);
		st.setString(2,nom);
		st.setInt(3,cant);
		st.executeUpdate();
		
	%>
	
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Registrar Insumo</h1>
    </header>
    <main id="genDoc2">
        <section id="formTrat">
			<h1>Registro realizado con exito<h1>
			<button type="button" class="boton" onclick="location.href='insumosSearch.jsp'">Lista de Insumos
			<button type="button" class="boton" onclick="location.href='insumosAdd.html'">Seguir Registrando
        </section>
    </main>
	
</body>
</html>