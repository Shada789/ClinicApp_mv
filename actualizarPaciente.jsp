<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<%
// Declaración de variables
String id_usuario = "";
String nombres = "";
String apP = "";
String apM = "";
String email = "";
String fechaN = "";
String password = "";
String user = "";
String confirmar = "";

// Obtener parámetros del formulario
id_usuario = request.getParameter("id_usuario");
nombres = request.getParameter("nombre");
apP = request.getParameter("apellidoP");
apM = request.getParameter("apellidoM");
email = request.getParameter("correo");
fechaN = request.getParameter("nacimiento");
user = request.getParameter("usuario");
password = request.getParameter("contrasenia");
confirmar = request.getParameter("confirmar");

Connection conecta = null;
PreparedStatement st = null;

try {
    // Validar que las contraseñas coincidan
    if (!password.equals(confirmar)) {
        out.println("<script>alert('Las contraseñas no coinciden'); window.history.back();</script>");
        return;
    }
    
    // Cargar driver y conectar
    Class.forName("com.mysql.cj.jdbc.Driver");
    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
    
    // Actualizar en la tabla usuario
    String sqlUsuario = "UPDATE usuario SET nombre = ?, paterno = ?, materno = ?, gmail = ?, fechaNac = ?, usuario = ?, contrasena = ? WHERE id_usuario = ?";
    st = conecta.prepareStatement(sqlUsuario);
    st.setString(1, nombres);
    st.setString(2, apP);
    st.setString(3, apM);
    st.setString(4, email);
    st.setString(5, fechaN);
    st.setString(6, user);
    st.setString(7, password);
    st.setString(8, id_usuario);
    
    int filasAfectadas = st.executeUpdate();
    
    if (filasAfectadas > 0) {
        out.println("<html><head><title>Actualización Exitosa</title>");
        out.println("<script>");
        out.println("alert('Paciente actualizado exitosamente');");
        out.println("window.location.href = 'buscarPaciente.jsp';");
        out.println("</script>");
        out.println("</head><body></body></html>");
    } else {
        out.println("<script>alert('Error: No se pudo actualizar el paciente'); window.history.back();</script>");
    }
} catch (Exception e) {
    out.println("<p>Error general: " + e.getMessage() + "</p>");
} finally {
    try {
        if (st != null) st.close();
        if (conecta != null) conecta.close();
    } catch (SQLException e) {
        out.println("<p>Error al cerrar conexión: " + e.getMessage() + "</p>");
    }
}
%>