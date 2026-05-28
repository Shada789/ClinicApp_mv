<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String user = request.getParameter("usuario");
    String pass = request.getParameter("contra");
    String errorMsg = "";

    if (user != null && pass != null) {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                "root", "n0m3l0"
            );

            PreparedStatement ps = con.prepareStatement(
                "SELECT id_usuario, rol FROM usuario WHERE usuario = ? AND contrasena = ? LIMIT 1"
            );
            ps.setString(1, user);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int    idUsuario = rs.getInt("id_usuario");
                String rol       = rs.getString("rol");

                // Solo pacientes pueden entrar por aquí
                if (rol.equals("paciente")) {
                    session.setAttribute("id_usuario", idUsuario);
                    session.setAttribute("rol", rol);

                    PreparedStatement psPac = con.prepareStatement(
                        "SELECT id_paciente FROM paciente WHERE id_usuario = ? LIMIT 1"
                    );
                    psPac.setInt(1, idUsuario);
                    ResultSet rsPac = psPac.executeQuery();
                    if (rsPac.next()) {
                        session.setAttribute("id_paciente", rsPac.getInt("id_paciente"));
                    }
                    response.sendRedirect("patientMain.jsp");

                } else {
                    errorMsg = "Esta página es solo para pacientes.";
                }

            } else {
                errorMsg = "Usuario o contraseña incorrectos.";
            }

        } catch (Exception e) {
            errorMsg = "Error: " + e.getMessage();
        } finally {
            if (con != null) try { con.close(); } catch (Exception ignored) {}
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Inicio de Sesión Paciente</title>
    <style>
        .error { color: red; font-weight: bold; }
    </style>
</head>
<body id="bodDoc">

    <header>
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>ClinicApp</h1>
        <div class="refs">
            <a href="index.html">Regresar</a>
        </div>
    </header>

    <main id="indMain">
        <section>
            <h1>Iniciar Sesión</h1>

            <article id="registroDoctor">
                <form id="formRegistroDoctor" method="post">

                    <label for="user"><b>Usuario:</b></label><br>
                    <input type="text" id="user" name="usuario" placeholder="Username" required><br><br>

                    <label for="password"><b>Contraseña:</b></label><br>
                    <input type="password" id="password" name="contra" placeholder="Password" required><br><br>

                    <button type="submit" class="botonImportante">Iniciar Sesión</button>

                </form>

                <% if (!errorMsg.isEmpty()) { %>
                    <p class="error"><%= errorMsg %></p>
                <% } %>

            </article>
        </section>
    </main>

</body>
</html>