<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String mensaje = ""; 
    if (request.getMethod().equalsIgnoreCase("POST")) {

        String nombres = request.getParameter("nombre");
        String apP = request.getParameter("apellidoP");
        String apM = request.getParameter("apellidoM");
        String email = request.getParameter("correo");
        String cedulaStr = request.getParameter("cedula");
        String user = request.getParameter("usuario");
        String password = request.getParameter("contrasenia");
        String confirmar = request.getParameter("confirmar");

        try {
            if (!password.equals(confirmar)) {
                mensaje = "Las contraseñas no coinciden.";
            } else {

                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0"
                );

                PreparedStatement check = con.prepareStatement(
                    "SELECT usuario FROM usuario WHERE usuario=? LIMIT 1"
                );
                check.setString(1, user);
                ResultSet rs = check.executeQuery();

                if (rs.next()) {
                    mensaje = "Ese nombre de usuario ya existe.";
                } else {
                    PreparedStatement st = con.prepareStatement(
                        "INSERT INTO usuario (nombre, paterno, materno, gmail, usuario, contrasena, cedula, id_tipo) VALUES (?,?,?,?,?,?,?,?)"
                    );

                    st.setString(1, nombres);
                    st.setString(2, apP);
                    st.setString(3, apM);
                    st.setString(4, email);
                    st.setString(5, user);
                    st.setString(6, password);
                    st.setDouble(7, Double.parseDouble(cedulaStr));
                    st.setInt(8, 2);

                    st.executeUpdate();

                    mensaje = "Registro exitoso. Ahora puede iniciar sesión.";
                }

                con.close();
            }

        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        }
    }
%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Registro de Doctor</title>
</head>

<body id="bodDoc">

<header >
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>Agendar Cita</h1>
    </header>

<main id="indMain">
    <section>
        <h2>Cree su cuenta</h2>

        <article id="registroDoctor">
            <form id="formRegistroDoctor" class="two-columns" method="post" action="registroDoctor.jsp">

                <div class="field">
                        <label for="name"><b>Nombres:</b></label>
                        <input type="text" id="name" name="nombre" placeholder="Nombres" required>
                    </div>

                    <div class="field">
                        <label for="correo"><b>Correo Electrónico:</b></label>
                        <input type="email" id="correo" name="correo" placeholder="Correo Electrónico" required>
                    </div>

                    <div class="field">
                        <label for="paterno"><b>Apellido Paterno:</b></label>
                        <input type="text" id="paterno" name="apellidoP" placeholder="Apellido Paterno" required>
                    </div>

                    <div class="field">
                        <label for="cedula"><b>Cédula Profesional:</b></label>
                        <input type="text" id="cedula" name="cedula" placeholder="Cédula Médica" required>
                    </div>

                    <div class="field">
                        <label for="materno"><b>Apellido Materno:</b></label>
                        <input type="text" id="materno" name="apellidoM" placeholder="Apellido Materno" required>
                    </div>

                    <div class="field">
                        <label for="usuario"><b>Usuario:</b></label>
                        <input type="text" id="usuario" name="usuario" placeholder="Genere un usuario" required>
                    </div>

                    <div class="field">
                        <label for="contrasenia"><b>Contraseña:</b></label>
                        <input type="password" id="contrasenia" name="contrasenia" placeholder="Genere su contraseña" required>
                    </div>

                    <div class="field">
                        <label for="confirmar"><b>Confirmar contraseña:</b></label>
                        <input type="password" id="confirmar" name="confirmar" placeholder="Confirme su contraseña" required>
                    </div>

                <button type="button" onclick="location.href='inDoc.jsp'" class="boton">Regresar</button>
                <button type="submit" class="botonImportante">Registrarse</button>

                <p id="mensaje"><%= mensaje %></p>

            </form>
        </article>
    </section>
</main>

</body>
</html>