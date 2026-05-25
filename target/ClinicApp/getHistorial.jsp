<%@ page import="java.sql.*" %>
<%
String idCliente = request.getParameter("idCliente");
String resultado = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection c = DriverManager.getConnection(
        "jdbc:mysql://localhost/chambs",
        "root",
        "n0m3l0"
    );

    // Si solo hay UN historial por paciente, solo necesitamos uno
    String sql = "SELECT h.descripcion " +
                 "FROM historial h " +
                 "INNER JOIN infoCliente ic ON h.id_historial = ic.id_historial " +
                 "WHERE ic.id_cliente = ? " +
                 "LIMIT 1";

    PreparedStatement ps = c.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(idCliente));

    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        resultado = rs.getString("descripcion");
    } else {
        resultado = "";   // Sin historial aún → área en blanco
    }

    rs.close();
    ps.close();
    c.close();

} catch(Exception e) {
    resultado = "Error: " + e.getMessage();
}

out.print(resultado);
%>