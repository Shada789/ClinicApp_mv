<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html>

	<head>
	<link rel="stylesheet" href="clinictyle.css" content="text/css">
	</head>
    <body>
		<h1> Modificación de productos </h1>

	<%
	String codigo = request.getParameter("id_tratamiento");
    String nombre = "";
    String precio = "";
    String desc = "";

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
			PreparedStatement st = conecta.prepareStatement("SELECT * FROM tratamientos WHERE id_tratamiento=?");
			st.setInt(1, Integer.parseInt(codigo));

			ResultSet rs = st.executeQuery();

			if (rs.next()) {
				nombre = rs.getString("nombre");
				precio = rs.getString("precio");
				desc = rs.getString("descripcion");
			}

		}
		catch (Exception e) {
			out.println("ERROR al cargar: " + e.getMessage());
		}
		
	
		if (request.getParameter("nombre") != null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");

				PreparedStatement st = conecta.prepareStatement("UPDATE tratamientos SET nombre=?, precio=?, descripcion=? WHERE codigo=?");

				st.setString(1, request.getParameter("nombre"));
				st.setString(2, request.getParameter("precio"));
				st.setDouble(3, Double.parseDouble(request.getParameter("descripcion")));
				st.setInt(4, Integer.parseInt(codigo));

				st.executeUpdate();
				out.println("Cambios guardados");

			} 
			catch (Exception e) { 
			}
		}
	%>
	<form action="editTreamtents2.jsp" method="post">

    <p>
        <label>Código:</label>
        <input type="text" name="id_tratamiento" value="<%= codigo %>" readonly>
    </p>

    <p>
        <label>Nombre:</label>
        <input type="text" name="nombre" value="<%= nombre %>" required>
    </p>

    <p>
        <label>Precio:</label>
        <input type="text" name="precio" value="<%= precio %>" required>
    </p>

    <p>
        <label>Descripción:</label>
        <input type="text" name="descripcion" value="<%= desc %>" required>
    </p>

    <button type="submit" class="boton" id="code">Guardar Cambios
	</body>
</html>