<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>

<html>
<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	<title>Registro de Tratamiento</title>
</head>
	<%
		String desc;
		String nom;
		int price;
		
		nom=request.getParameter("nombre");
		price=Integer.parseInt(request.getParameter("precio"));
		desc=request.getParameter("descripcion");

                Integer idMedico = (Integer) session.getAttribute("id_medico");
                if (idMedico == null) {
                        response.sendRedirect("index.html");
                        return;
                }
		
		Connection conecta;
		PreparedStatement st;
		Class.forName("com.mysql.cj.jdbc.Driver");
		conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
		st=conecta.prepareStatement("Insert into tratamiento (id_medico,nombre,precio,descripcion) values(?,?,?,?)");
		
		st.setInt(1,idMedico);
		st.setString(2,nom);
		st.setInt(3,price);
		st.setString(4,desc);
		st.executeUpdate();
		
	%>
	
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Registrar Tratamiento</h1>
    </header>
    <main id="genDoc2">
        <section id="formTrat">
			<h1>Registro realizado con exito<h1>
			<button type="button" class="boton" onclick="location.href='searchTreatment1.jsp'">Lista de Tratamientos
			<button type="button" class="boton" onclick="location.href='addTreatment.jsp'">Seguir Registrando
        </section>
    </main>
	
</body>
</html>