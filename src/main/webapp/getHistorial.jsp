<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) { out.print("ERROR: sesión inválida"); return; }

    String idPacStr = request.getParameter("idPaciente");
    if (idPacStr == null) { out.print(""); return; }

    int idPaciente = Integer.parseInt(idPacStr);
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
            "root", "n0m3l0"
        );

        StringBuilder sb = new StringBuilder();

        // ── 1. Citas del paciente ──────────────────────────────────────────
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

        sb.append("=== CITAS ===\n");
        boolean hayCitas = false;
        while (rsCitas.next()) {
            hayCitas = true;
            sb.append("• ").append(rsCitas.getString("fecha_hora"))
              .append(" | ").append(rsCitas.getString("tipo"))
              .append(" | Estado: ").append(rsCitas.getString("estado"));
            String notas = rsCitas.getString("notas");
            if (notas != null && !notas.trim().isEmpty()) {
                sb.append(" | Notas: ").append(notas);
            }
            sb.append("\n");
        }
        if (!hayCitas) sb.append("Sin citas registradas.\n");

        // ── 2. Tratamientos asignados ──────────────────────────────────────
        PreparedStatement psTrat = con.prepareStatement(
            "SELECT t.nombre, t.descripcion, pt.fecha_inicio, pt.fecha_fin, pt.observaciones " +
            "FROM paciente_tratamiento pt " +
            "JOIN tratamiento t ON pt.id_tratamiento = t.id_tratamiento " +
            "WHERE pt.id_paciente = ? AND pt.id_medico = ? " +
            "ORDER BY pt.fecha_inicio DESC"
        );
        psTrat.setInt(1, idPaciente);
        psTrat.setInt(2, idMedico);
        ResultSet rsTrat = psTrat.executeQuery();

        sb.append("\n=== TRATAMIENTOS ===\n");
        boolean hayTrat = false;
        while (rsTrat.next()) {
            hayTrat = true;
            sb.append("• ").append(rsTrat.getString("nombre"))
              .append(" | Inicio: ").append(rsTrat.getString("fecha_inicio"));
            String fin = rsTrat.getString("fecha_fin");
            if (fin != null) sb.append(" | Fin: ").append(fin);
            String obs = rsTrat.getString("observaciones");
            if (obs != null && !obs.trim().isEmpty()) {
                sb.append(" | Obs: ").append(obs);
            }
            sb.append("\n");
        }
        if (!hayTrat) sb.append("Sin tratamientos asignados.\n");

        // ── 3. Notas del médico ────────────────────────────────────────────
        PreparedStatement psNotas = con.prepareStatement(
            "SELECT notas_medico, registrado_en " +
            "FROM historial " +
            "WHERE id_paciente = ? AND id_medico = ? " +
            "AND id_cita IS NULL AND id_tratamiento IS NULL " +
            "ORDER BY registrado_en DESC"
        );
        psNotas.setInt(1, idPaciente);
        psNotas.setInt(2, idMedico);
        ResultSet rsNotas = psNotas.executeQuery();

        sb.append("\n=== NOTAS DEL MÉDICO ===\n");
        boolean hayNotas = false;
        while (rsNotas.next()) {
            hayNotas = true;
            sb.append("[").append(rsNotas.getString("registrado_en")).append("]\n");
            sb.append(rsNotas.getString("notas_medico")).append("\n\n");
        }
        if (!hayNotas) sb.append("Sin notas registradas.\n");

        out.print(sb.toString());

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>