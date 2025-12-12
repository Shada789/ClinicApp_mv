<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    Integer usuario = (Integer) session.getAttribute("usuario");
    Integer tipo = (Integer) session.getAttribute("tipo");

    if (usuario == null) {
        response.sendRedirect("index.html");
        return;
    }

    if (tipo != 1) { 
        response.sendRedirect("doctorMain.jsp");
        return;
    }

    String nombre = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs",
            "root",
            "n0m3l0"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT nombre FROM usuario WHERE id_usuario = ? LIMIT 1"
        );
        ps.setInt(1, usuario);

        ResultSet rs = ps.executeQuery();
        
        if (rs.next()) {
            nombre = rs.getString("nombre");
        }

        con.close();
    } catch (Exception e) {
        nombre = "Usuario";
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
    <nav id="navDoc">
        <ul>
            <li><a href="patientMain.jsp">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span> Inicio</span></a></li>
            <li><a href="patientHistory.jsp">
                    <img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                    <span>Historial</span></a></li>
            <li><a href="patientAppts.html">
                    <img src="imgs/calendar-symbol-svgrepo-com.svg">
                    <span>Citas</span></a></li>
            <li><a href="patientTreatment.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                    <span>Tratamientos</span>
                </a></li>
            <li><a href="patientMyProfile.html">
                    <img src="imgs/profile-1341-svgrepo-com.svg">
                    <span>Perfil</span>
                </a></li>
        </ul>
    </nav>
  <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
     

        <section>
<h1>Bienvenido(a), <%= nombre %> !</h1>        </section>

        <section >
           

            <aside id="reloj">
                <h3>Fecha y Hora</h3>
                <p id="hora">[HORA]</p>
                <p id="fecha">[FECHA]</p><br>

            </aside>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
    <script>
        function actualizarReloj() {
            const ahora = new Date();

            const opcionesHora = { hour: '2-digit', minute: '2-digit', hour12: true };
            const horaFormateada = ahora.toLocaleTimeString('es-ES', opcionesHora);

            const opcionesFecha = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const fechaFormateada = ahora.toLocaleDateString('es-ES', opcionesFecha);

            // Actualizar elementos
            document.getElementById('hora').textContent = horaFormateada;
            document.getElementById('fecha').textContent = fechaFormateada;
        }
        actualizarReloj();
        setInterval(actualizarReloj, 1000);
    </script>
</body>

</html>