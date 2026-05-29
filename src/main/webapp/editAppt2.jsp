<!DOCTYPE html>
<html lang="es">
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Modificar Cita</title>
    <style>
        #formCita label,
#formCita input, #formCita select {

    border: none;
    color: black;
    font-size: 16px;
        background-color: transparent;


}
#formCita button{
    grid-column: 1 / -1;
    justify-self: center;
    padding: 10px 20px;
    font-size: 18px;
}
    </style>
</head>

<body id="bodDoc">
<%
String id = request.getParameter("id_cita");
String pac = "";
    String fecha = "";
    String hora = "";
    String tipo = "";

		try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conecta = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
        );

        PreparedStatement st = conecta.prepareStatement(
            "SELECT * FROM citas WHERE id_cita=?"
        );
        st.setInt(1, Integer.parseInt(id));

        ResultSet rs = st.executeQuery();

        if (rs.next()) {
            pac = rs.getString("nombre");
            tipo = rs.getString("tipo");

            String fecha_hora = rs.getString("fecha_hora");

            fecha = fecha_hora.substring(0, 10);
            hora = fecha_hora.substring(11, 16);
        }

    } catch (Exception e) {
        out.println("ERROR al cargar: " + e.getMessage());
    }
		
	%>


            <%@ include file="navDoctor.jsp" %>

     <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Modificar Cita</h1>
    </header>
    <main id="genDoc2">
      
        <section>

            <form id="formCita" action="editAppt3.jsp" method="post">

                <label for="id">ID:</label>
                <input type="text" id="id" name="id" value="<%= id %>" readonly><br><br>

                <label for="paciente">Paciente:</label>
                <input type="text" id="paciente" name="paciente" value="<%= pac %>"><br><br>

                <label for="fecha">Fecha de la cita:</label>
                <input type="date" id="fecha" name="fecha" value="<%= fecha %>" required><br><br>

                <label for="hora">Hora de la cita:</label>
                <input type="time" id="hora" name="hora" value="<%= hora %>" required><br><br>

                <label for="tipo">Tipo de cita:</label>
                <select id="tipo" name="tipo" required>
                    <option value="">Selecciona tipo</option>
                    <option value="consulta" <%= tipo.equals("consulta") ? "selected" : "" %>>Consulta</option>
                    <option value="control"   <%= tipo.equals("control") ? "selected" : "" %>>Control</option>
                    <option value="urgencia"  <%= tipo.equals("urgencia") ? "selected" : "" %>>Urgencia</option>
                </select><br><br>

                <button type="submit" class="botonImportante" id ="code">Reagendar Cita</button>
                
            </form>
            <button type="button" class="botonImportante" onclick="location.href='editAppt.jsp'">Regresar a selección </button>     
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>