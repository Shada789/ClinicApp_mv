<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<html>
<body>
<%
String pac = request.getParameter("paciente");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String tipo = request.getParameter("tipo");

String fecha_hora = fecha + " " + hora;

Connection conecta = null;
PreparedStatement st = null;

try {
    Class.forName("com.mysql.cj.jdbc.Driver");

    conecta = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );

    st = conecta.prepareStatement(
        "INSERT INTO citas (fecha_hora, nombre, tipo) VALUES (?,?,?)"
    );

    st.setString(1, fecha_hora);
    st.setString(2, pac);  
    st.setString(3, tipo);

    st.executeUpdate();

    out.println("<p>Todo joya ✔</p>");

} catch (Exception e) {
    out.println("<p>Error: " + e.getMessage() + "</p>");
} finally {
    if (st != null) st.close();
    if (conecta != null) conecta.close();
}
%>

Registro exitoso
</body>
</html>