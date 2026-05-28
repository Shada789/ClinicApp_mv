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
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        PreparedStatement ps = con.prepareStatement(
            "SELECT notas_medico, registrado_en FROM historial " +
            "WHERE id_paciente = ? AND id_medico = ? " +
            "AND id_cita IS NULL AND id_tratamiento IS NULL " +
            "ORDER BY registrado_en DESC"
        );
        ps.setInt(1, idPaciente);
        ps.setInt(2, idMedico);
        ResultSet rs = ps.executeQuery();

        StringBuilder sb = new StringBuilder();
        while (rs.next()) {
            sb.append("[").append(rs.getString("registrado_en")).append("]\n");
            sb.append(rs.getString("notas_medico")).append("\n\n");
        }
        out.print(sb.toString());

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>