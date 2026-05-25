<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>

<%
    String term = request.getParameter("term");
    if (term == null || term.trim().isEmpty()) {
        out.print("[]");
        return;
    }

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");

        String sql = "SELECT u.id_usuario, u.nombre, u.paterno, u.materno, u.username " +
                     "FROM usuario u " +
                     "WHERE u.id_tipo = 1 AND (" +
                     "u.nombre LIKE ? OR u.paterno LIKE ? OR u.materno LIKE ? OR u.username LIKE ?" +
                     ") ORDER BY u.paterno, u.nombre";

        ps = conn.prepareStatement(sql);

        String like = "%" + term + "%";
        ps.setString(1, like);
        ps.setString(2, like);
        ps.setString(3, like);
        ps.setString(4, like);

        rs = ps.executeQuery();

        // JSON manual
        StringBuilder json = new StringBuilder();
        json.append("[");

        boolean first = true;

        while (rs.next()) {
            if (!first) json.append(",");
            first = false;

            json.append("{");
            json.append("\"id\": \"" + rs.getInt("id_usuario") + "\",");
            json.append("\"nombre\": \"" + rs.getString("nombre") + " " +
                                         rs.getString("paterno") + " " +
                                         rs.getString("materno") + "\",");
            json.append("\"username\": \"" + rs.getString("username") + "\"");
            json.append("}");
        }

        json.append("]");
        out.print(json.toString());

    } catch (Exception e) {
        out.print("[]");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception ex) {}
        try { if (ps != null) ps.close(); } catch (Exception ex) {}
        try { if (conn != null) conn.close(); } catch (Exception ex) {}
    }
%>