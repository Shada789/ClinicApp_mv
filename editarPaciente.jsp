<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Editar Paciente</title>
</head>
<body id="bodDoc">
    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.html">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li>
            <li><a href="patientManagement.html">
                    <img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
            <li><a href="historyDoctor.html"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li>
            <li><a href="docTreatments.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span></a></li>
        </ul>
    </nav>

    <main id="genDoc2">
        <header>
            <h1>Editar Información del Paciente</h1>
        </header>
        <section>
            <h2>Modificar Datos del Paciente</h2>
            <article id="editarPaciente">
                <%
                String id = request.getParameter("id");
                Connection conecta = null;
                PreparedStatement st = null;
                ResultSet rz = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
                    
                    // Cargar los datos actuales del paciente
                    st = conecta.prepareStatement("SELECT * FROM usuario WHERE id_usuario = ?");
                    st.setString(1, id);
                    rz = st.executeQuery();
                    
                    if (rz.next()) {
                %>
                <form id="formEditarPaciente" action="actualizarPaciente.jsp" method="post">
                    <input type="hidden" name="id_usuario" value="<%=rz.getInt("id_usuario")%>"/>
                    
                    <label for="name"><b>Nombre:</b></label>
                    <input type="text" id="name" name="nombre" value="<%=rz.getString("nombre")%>" required><br><br>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" value="<%=rz.getString("paterno")%>" required><br><br>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" value="<%=rz.getString("materno")%>" required><br><br>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" value="<%=rz.getString("gmail")%>" required><br><br>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento" value="<%=rz.getString("fechaNac")%>" required><br><br>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" value="<%=rz.getString("usuario")%>" required><br><br>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" value="<%=rz.getString("contrasena")%>" required><br><br>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" value="<%=rz.getString("contrasena")%>" required><br><br>

                    <button type="submit" class="boton">Actualizar Paciente</button>
                </form>
                <%
                    } else {
                        out.println("<p>Paciente no encontrado</p>");
                    }
                } catch(Exception e) {
                    out.println("<p>ERROR: " + e.getMessage() + "</p>");
                } finally {
                    // Cerrar recursos
                    try {
                        if (rz != null) rz.close();
                        if (st != null) st.close();
                        if (conecta != null) conecta.close();
                    } catch (SQLException e) {
                        out.println("<p>Error al cerrar conexión: " + e.getMessage() + "</p>");
                    }
                }
                %>
                <button type="button" class="boton" onclick="location.href='buscarPaciente.jsp'">Regresar</button> 
            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
</body>
</html>