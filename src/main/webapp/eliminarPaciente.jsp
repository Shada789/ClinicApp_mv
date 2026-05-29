<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    String idPacStr = request.getParameter("id");
    if (idPacStr == null) {
        response.sendRedirect("buscarPaciente.jsp");
        return;
    }
    int idPaciente = Integer.parseInt(idPacStr);

    String mensaje = "";
    Connection conecta = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        PreparedStatement chk = conecta.prepareStatement(
            "SELECT id_usuario FROM paciente WHERE id_paciente = ? AND id_medico = ? LIMIT 1"
        );
        chk.setInt(1, idPaciente);
        chk.setInt(2, idMedico);
        ResultSet rsChk = chk.executeQuery();

        if (!rsChk.next()) {
            mensaje = "No tienes permiso para eliminar este paciente.";
        } else {
            int idUsuario = rsChk.getInt("id_usuario");
            rsChk.close(); chk.close();

            PreparedStatement st = conecta.prepareStatement(
                "DELETE FROM usuario WHERE id_usuario = ?"
            );
            st.setInt(1, idUsuario);
            int filas = st.executeUpdate();
            st.close();

            mensaje = filas > 0
                ? "Paciente eliminado correctamente."
                : "No se pudo eliminar el paciente.";
        }

    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    } finally {
        if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
    }

    response.sendRedirect("buscarPaciente.jsp?msg=" +
        java.net.URLEncoder.encode(mensaje, "UTF-8"));
%>
