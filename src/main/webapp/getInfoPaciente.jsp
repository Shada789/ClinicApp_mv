<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) { out.print(""); return; }

    String idPacStr = request.getParameter("idPaciente");
    if (idPacStr == null) { out.print(""); return; }

    int idPaciente = Integer.parseInt(idPacStr);
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        StringBuilder sb = new StringBuilder();

        PreparedStatement psCitas = con.prepareStatement(
            "SELECT c.fecha_hora, c.estado, c.notas, tc.nombre AS tipo " +
            "FROM cita c " +
            "JOIN tipo_cita tc ON c.id_tipo_cita = tc.id_tipo_cita " +
            "WHERE c.id_paciente = ? AND c.id_medico = ? " +
            "ORDER BY c.fecha_hora DESC"
        );
        psCitas.setInt(1, idPaciente);
        psCitas.setInt(2, idMedico);
        ResultSet rsCitas = psCitas.executeQuery();

        sb.append("<b>Citas</b><br>");
        boolean hayCitas = false;
        while (rsCitas.next()) {
            hayCitas = true;
            sb.append("• ").append(rsCitas.getString("fecha_hora"))
              .append(" | ").append(rsCitas.getString("tipo"))
              .append(" | ").append(rsCitas.getString("estado"));
            String notas = rsCitas.getString("notas");
            if (notas != null && !notas.trim().isEmpty())
                sb.append(" — ").append(notas);
            sb.append("<br>");
        }
        if (!hayCitas) sb.append("Sin citas.<br>");
        rsCitas.close(); psCitas.close();

        PreparedStatement psTrat = con.prepareStatement(
            "SELECT t.nombre, pt.fecha_inicio, pt.fecha_fin, pt.observaciones " +
            "FROM paciente_tratamiento pt " +
            "JOIN tratamiento t ON pt.id_tratamiento = t.id_tratamiento " +
            "WHERE pt.id_paciente = ? AND pt.id_medico = ? " +
            "ORDER BY pt.fecha_inicio DESC"
        );
        psTrat.setInt(1, idPaciente);
        psTrat.setInt(2, idMedico);
        ResultSet rsTrat = psTrat.executeQuery();

        sb.append("<br><b>Tratamientos</b><br>");
        boolean hayTrat = false;
        while (rsTrat.next()) {
            hayTrat = true;
            sb.append("• ").append(rsTrat.getString("nombre"))
              .append(" | Inicio: ").append(rsTrat.getString("fecha_inicio"));
            String fin = rsTrat.getString("fecha_fin");
            if (fin != null) sb.append(" | Fin: ").append(fin);
            String obs = rsTrat.getString("observaciones");
            if (obs != null && !obs.trim().isEmpty())
                sb.append(" — ").append(obs);
            sb.append("<br>");
        }
        if (!hayTrat) sb.append("Sin tratamientos.<br>");
        rsTrat.close(); psTrat.close();

        out.print(sb.toString());

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>