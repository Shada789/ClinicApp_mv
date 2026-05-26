<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String mensaje = "";
    String claseMensaje = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {

        String nombres  = request.getParameter("nombre");
        String apP      = request.getParameter("apellidoP");
        String apM      = request.getParameter("apellidoM");
        String email    = request.getParameter("correo");
        String cedula   = request.getParameter("cedula");
        String user     = request.getParameter("usuario");
        String password = request.getParameter("contrasenia");
        String confirmar = request.getParameter("confirmar");

        if (!password.equals(confirmar)) {
            mensaje      = "Las contraseñas no coinciden.";
            claseMensaje = "error";
        } else {

            Connection con = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection(
                    "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                    "root", "n0m3l0"
                );

                PreparedStatement chkUser = con.prepareStatement(
                    "SELECT id_usuario FROM usuario WHERE usuario = ? LIMIT 1"
                );
                chkUser.setString(1, user);
                ResultSet rsUser = chkUser.executeQuery();

                if (rsUser.next()) {
                    mensaje      = "Ese nombre de usuario ya existe.";
                    claseMensaje = "error";

                } else {

                    PreparedStatement chkEmail = con.prepareStatement(
                        "SELECT id_usuario FROM usuario WHERE email = ? LIMIT 1"
                    );
                    chkEmail.setString(1, email);
                    ResultSet rsEmail = chkEmail.executeQuery();

                    if (rsEmail.next()) {
                        mensaje      = "Ese correo ya está registrado.";
                        claseMensaje = "error";

                    } else {

                        PreparedStatement stUser = con.prepareStatement(
                            "INSERT INTO usuario (nombre, paterno, materno, email, usuario, contrasena, rol) " +
                            "VALUES (?, ?, ?, ?, ?, ?, 'medico')",
                            Statement.RETURN_GENERATED_KEYS   
                        );
                        stUser.setString(1, nombres);
                        stUser.setString(2, apP);
                        stUser.setString(3, apM);
                        stUser.setString(4, email);
                        stUser.setString(5, user);
                        stUser.setString(6, password);
                        stUser.executeUpdate();

                        ResultSet rsKeys = stUser.getGeneratedKeys();
                        int idUsuario = 0;
                        if (rsKeys.next()) {
                            idUsuario = rsKeys.getInt(1);
                        }

                        PreparedStatement stMed = con.prepareStatement(
                            "INSERT INTO medico (id_usuario, cedula) VALUES (?, ?)"
                        );
                        stMed.setInt(1, idUsuario);
                        stMed.setString(2, cedula);
                        stMed.executeUpdate();

                        mensaje      = "Registro exitoso. Ya puede iniciar sesión.";
                        claseMensaje = "exito";
                    }
                }

            } catch (Exception e) {
                mensaje      = "Error: " + e.getMessage();
                claseMensaje = "error";
            } finally {
                if (con != null) try { con.close(); } catch (Exception ignored) {}
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Registro de Doctor</title>
    <style>
        .error  { color: red;   font-weight: bold; }
        .exito  { color: green; font-weight: bold; }
    </style>
</head>
<body id="bodDoc">

<header>
    <img class="logo" src="imgs/image.png" alt="Logo">
    <h1>Registro de Doctor</h1>
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

                <% if (!mensaje.isEmpty()) { %>
                    <p class="<%= claseMensaje %>"><%= mensaje %></p>
                <% } %>

            </form>
        </article>
    </section>
</main>

</body>
</html>