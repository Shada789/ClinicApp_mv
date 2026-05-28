<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idPaciente = (Integer) session.getAttribute("id_paciente");
    if (idPaciente == null) {
        response.sendRedirect("index.html");
        return;
    }

    Connection con = null;
    StringBuilder historial = new StringBuilder();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        PreparedStatement psCitas = con.prepareStatement(
            "SELECT c.fecha_hora, c.estado, c.notas, tc.nombre AS tipo " +
            "FROM cita c " +
            "JOIN tipo_cita tc ON c.id_tipo_cita = tc.id_tipo_cita " +
            "WHERE c.id_paciente = ? " +
            "ORDER BY c.fecha_hora DESC"
        );
        psCitas.setInt(1, idPaciente);
        ResultSet rsCitas = psCitas.executeQuery();

        historial.append("<h3>Citas</h3>");
        boolean hayCitas = false;
        while (rsCitas.next()) {
            hayCitas = true;
            historial.append("<p><b>").append(rsCitas.getString("fecha_hora")).append("</b>")
                     .append(" — ").append(rsCitas.getString("tipo"))
                     .append(" | Estado: ").append(rsCitas.getString("estado"));
            String notas = rsCitas.getString("notas");
            if (notas != null && !notas.trim().isEmpty()) {
                historial.append("<br><i>").append(notas).append("</i>");
            }
            historial.append("</p><hr>");
        }
        if (!hayCitas) historial.append("<p>Sin citas registradas.</p>");
        rsCitas.close(); psCitas.close();

        PreparedStatement psTrat = con.prepareStatement(
            "SELECT t.nombre, t.descripcion, pt.fecha_inicio, pt.fecha_fin, pt.observaciones " +
            "FROM paciente_tratamiento pt " +
            "JOIN tratamiento t ON pt.id_tratamiento = t.id_tratamiento " +
            "WHERE pt.id_paciente = ? " +
            "ORDER BY pt.fecha_inicio DESC"
        );
        psTrat.setInt(1, idPaciente);
        ResultSet rsTrat = psTrat.executeQuery();

        historial.append("<h3>Tratamientos</h3>");
        boolean hayTrat = false;
        while (rsTrat.next()) {
            hayTrat = true;
            historial.append("<p><b>").append(rsTrat.getString("nombre")).append("</b>")
                     .append(" | Inicio: ").append(rsTrat.getString("fecha_inicio"));
            String fin = rsTrat.getString("fecha_fin");
            if (fin != null) historial.append(" | Fin: ").append(fin);
            String obs = rsTrat.getString("observaciones");
            if (obs != null && !obs.trim().isEmpty()) {
                historial.append("<br><i>").append(obs).append("</i>");
            }
            historial.append("</p><hr>");
        }
        if (!hayTrat) historial.append("<p>Sin tratamientos asignados.</p>");
        rsTrat.close(); psTrat.close();

        PreparedStatement psNotas = con.prepareStatement(
            "SELECT notas_medico, registrado_en " +
            "FROM historial " +
            "WHERE id_paciente = ? " +
            "AND id_cita IS NULL AND id_tratamiento IS NULL " +
            "ORDER BY registrado_en DESC"
        );
        psNotas.setInt(1, idPaciente);
        ResultSet rsNotas = psNotas.executeQuery();

        historial.append("<h3>Notas del Médico</h3>");
        boolean hayNotas = false;
        while (rsNotas.next()) {
            hayNotas = true;
            historial.append("<p><b>[").append(rsNotas.getString("registrado_en")).append("]</b><br>")
                     .append(rsNotas.getString("notas_medico")).append("</p><hr>");
        }
        if (!hayNotas) historial.append("<p>Sin notas registradas.</p>");
        rsNotas.close(); psNotas.close();

    } catch (Exception e) {
        historial.append("Error al cargar historial: ").append(e.getMessage());
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Mi Historial</title>
</head>
<body id="bodDoc">

    <%@ include file="navPaciente.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Mi Historial</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article id="historialPaciente">
                <%= historial.toString() %>
            </article>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

</body>
</html>