<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idPaciente = (Integer) session.getAttribute("id_paciente");
    if (idPaciente == null) { response.sendRedirect("index.html"); return; }

    String id = request.getParameter("id_cita");
    String mensaje = "";

    if (id != null) {
        Connection conecta = null;
        PreparedStatement st = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection(
                "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                "root", "n0m3l0"
            );
            st = conecta.prepareStatement(
                "UPDATE cita SET estado='cancelada' WHERE id_cita=? AND id_paciente=?"
            );
            st.setInt(1, Integer.parseInt(id));
            st.setInt(2, idPaciente);
            int filas = st.executeUpdate();
            mensaje = filas > 0 ? "Cita cancelada correctamente." : "No se encontró la cita.";
        } catch (Exception e) {
            mensaje = "Error: " + e.getMessage();
        } finally {
            if (st != null) try { st.close(); } catch (Exception ignored) {}
            if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
        }
    }

    response.sendRedirect("patientAppts.jsp?msg=" + java.net.URLEncoder.encode(mensaje, "UTF-8"));
%>