<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String nombre = "Doctor";
    String cedula = "";
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT u.nombre, u.paterno, m.cedula " +
            "FROM usuario u " +
            "JOIN medico m ON u.id_usuario = m.id_usuario " +
            "WHERE m.id_medico = ? LIMIT 1"
        );
        ps.setInt(1, idMedico);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("nombre") + " " + rs.getString("paterno");
            cedula = rs.getString("cedula") != null ? rs.getString("cedula") : "";
        }

    } catch (Exception e) {
        nombre = "Doctor";
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Mi Perfil</title>
</head>
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Mi Perfil</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article>
                <div class="image">
                    <img src="imgs/icprofile.png" alt="">
                </div>
                <div class="content">
                    <h2><%= nombre %></h2>
                    <p>Doctor</p>
                    <% if (!cedula.isEmpty()) { %>
                        <p>Cédula: <%= cedula %></p>
                    <% } %>
                    <button type="button" class="boton"
                            onclick="location.href='editAccount.jsp'">Editar Perfil</button>
                    <button type="button" class="botonImportante"
                            onclick="location.href='logout.jsp'">Cerrar Sesión</button>
                </div>
            </article>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

</body>
</html>