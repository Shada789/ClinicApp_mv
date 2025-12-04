<%@ page import="java.sql.*" %>
<%
response.setContentType("text/plain");

String id = request.getParameter("id");

String url = "jdbc:mysql://localhost/clinicapp";
String user = "root";
String pass = "tuPassword";

StringBuilder historial = new StringBuilder();

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, user, pass);

    PreparedStatement ps = con.prepareStatement(
        "SELECT descripcion FROM historial WHERE idPaciente = ? ORDER BY fecha ASC"
    );
    ps.setString(1, id);
    ResultSet rs = ps.executeQuery();

    while (rs.next()) {
        historial.append(rs.getString(1)).append("\n\n");
    }

    out.print(historial.toString());

} catch (Exception e) {
    out.print("");
}
%>