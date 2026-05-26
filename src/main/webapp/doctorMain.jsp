<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    String nombre = "Usuario";
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
            "root", "n0m3l0"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT u.nombre FROM usuario u " +
            "JOIN medico m ON u.id_usuario = m.id_usuario " +
            "WHERE m.id_medico = ? LIMIT 1"
        );
        ps.setInt(1, idMedico);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            nombre = rs.getString("nombre");
        }

    } catch (Exception e) {
        nombre = "Usuario";
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Página Principal</title>
</head>
<body id="bodDoc">

   <%@ include file="navDoctor.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>ClinicApp</h1>
    </header>

    <main id="genDoc2">
        <section>
            <h1>Bienvenido(a), <%= nombre %>!</h1>
        </section>

        <aside id="reloj">
            <h3>Fecha y Hora</h3>
            <p id="hora"></p>
            <p id="fecha"></p>
        </aside>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

    <script>
        function actualizarReloj() {
            const ahora = new Date();
            const opcionesHora  = { hour: '2-digit', minute: '2-digit', hour12: true };
            const opcionesFecha = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            document.getElementById('hora').textContent  = ahora.toLocaleTimeString('es-ES', opcionesHora);
            document.getElementById('fecha').textContent = ahora.toLocaleDateString('es-ES', opcionesFecha);
        }
        actualizarReloj();
        setInterval(actualizarReloj, 1000);
    </script>

</body>
</html>