<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) { out.print("ERROR: sesión inválida"); return; }

    String idPacStr = request.getParameter("idPaciente");
    String texto    = request.getParameter("texto");

    if (idPacStr == null || texto == null) { out.print("ERROR: datos incompletos"); return; }

    int idPaciente = Integer.parseInt(idPacStr);
    Connection con = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
            "root", "n0m3l0"
        );

        // Verifica que el paciente pertenece a este médico antes de guardar
        PreparedStatement chk = con.prepareStatement(
            "SELECT id_paciente FROM paciente WHERE id_paciente = ? AND id_medico = ? LIMIT 1"
        );
        chk.setInt(1, idPaciente);
        chk.setInt(2, idMedico);
        ResultSet rs = chk.executeQuery();

        if (!rs.next()) {
            out.print("ERROR: paciente no autorizado");
            return;
        }

        // Inserta nueva nota en historial
        PreparedStatement ps = con.prepareStatement(
            "INSERT INTO historial (id_paciente, id_medico, notas_medico) VALUES (?, ?, ?)"
        );
        ps.setInt(1, idPaciente);
        ps.setInt(2, idMedico);
        ps.setString(3, texto);
        ps.executeUpdate();

        out.print("OK");

    } catch (Exception e) {
        out.print("Error: " + e.getMessage());
    } finally {
        if (con != null) try { con.close(); } catch (Exception ignored) {}
    }
%>