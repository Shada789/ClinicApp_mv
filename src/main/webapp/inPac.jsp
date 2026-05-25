<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Inicio de Sesión</title>
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
                <form  id="formRegistroDoctor" method="post">
                    <label for="user"><b>Usuario:</b></label><br>
                    <input type="text" id="user" name="usuario" placeholder="Username" required><br><br>

                    <label for="password"><b>Contraseña:</b></label><br>
                    <input type="password" id="password" name="contra" placeholder="Password" required><br><br>

                    <button type="submit" class="botonImportante">Iniciar Sesión</button>
                </form>

                
            </article>

            <%
                String user = request.getParameter("usuario");
                String pass = request.getParameter("contra");

                if (user != null && pass != null) {
                    try {
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(
                            "jdbc:mysql://localhost:3306/chambs",
                            "root",
                            "n0m3l0"
                        );

                        PreparedStatement ps = con.prepareStatement(
                            "SELECT id_usuario, id_tipo FROM usuario WHERE usuario=? AND contrasena=? LIMIT 1"
                        );
                        ps.setString(1, user);
                        ps.setString(2, pass);

                        ResultSet rs = ps.executeQuery();

                        if (rs.next()) {
                            int tipo = rs.getInt("id_tipo");

                            session.setAttribute("nombrePaciente", user);
                            session.setAttribute("usuario", rs.getInt("id_usuario"));
                            session.setAttribute("tipo", tipo);

                            if (tipo == 2) {
                                response.sendRedirect("doctorMain.jsp");
                            } else if (tipo == 1) {
                                response.sendRedirect("patientMain.jsp");
                            }
                        } else {
                            out.println("<p style='color:red;'>Usuario o contraseña incorrectos</p>");
                        }

                        con.close();
                    } catch (Exception e) {
                        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    }
                }
            %>

        </section>
    </main>

</body>

</html>