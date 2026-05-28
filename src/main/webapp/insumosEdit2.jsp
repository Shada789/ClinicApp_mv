<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>

	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
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
        <section id="formTrat">
		
	<%
	String codigo = request.getParameter("id_insumo");
    String nombre = "";
    String cantidad = "";
    
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
			PreparedStatement st = conecta.prepareStatement("SELECT * FROM insumo WHERE id_insumo=?");
			st.setInt(1, Integer.parseInt(codigo));

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				nombre = rs.getString("nombre");
				cantidad = rs.getString("cantidad_actual");
			}

		}
		catch (Exception e) {
			out.println("ERROR al cargar: " + e.getMessage());
		}
	%>
		<article>
			<form id="formRegistroDoctor" action="insumosEdit3.jsp" method="post">
	
				<label style="display: none;">Código:</label>
				<input style="display: none;" type="text" name="id_insumo" value="<%= codigo %>" readonly>
		
				<label><b>Nombre:</b></label><br>
				<input type="text" name="nombre" placeholder="Nombre del Insumo" value="<%= nombre %>" required><br>

				<label><b>Cantidad:</b></label><br>
				<input type="number" name="cantidad" placeholder=cantidad" value="<%= cantidad %>" required><br>
				
				<button type="submit" class="botonImportante" id="code">Guardar Cambios</button>
			
			</form>
			<button type="button" onclick="location.href='insumosEdit.jsp'" class="boton">Regresar</button>
		</article>
		
		</section>
	</main>
</body>
</html>