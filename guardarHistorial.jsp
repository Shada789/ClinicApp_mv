<%@ page import="java.sql.*" %>
<%
String id = request.getParameter("id");
String texto = request.getParameter("texto");

String url = "jdbc:mysql://localhost/clinicapp";
String user = "root";
String pass = "tuPassword";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(url, user, pass);

    PreparedStatement ps = con.prepareStatement(
        "UPDATE pacientes SET descripcion = ? WHERE id = ?"
    );

    ps.setString(1, texto);
    ps.setString(2, id);
    ps.executeUpdate();

    out.print("ok");

} catch (Exception e) {
    out.print("error");
}
%>