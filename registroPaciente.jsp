<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<%
// Declaración de variables
String nombres = "";
String apP = "";
String apM = "";
String email = "";
String fechaN = "";
String password = "";
String user = "";
String confirmar = "";

// Obtener parámetros del formulario
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
PreparedStatement stCliente = null;

try {
    // Validar que las contraseñas coincidan
    if (!password.equals(confirmar)) {
        out.println("<script>alert('Las contraseñas no coinciden'); window.history.back();</script>");
        return;
    }
    
    // Validar que todos los campos requeridos estén presentes
    if (nombres == null || apP == null || apM == null || email == null || 
        fechaN == null || user == null || password == null) {
        out.println("<script>alert('Todos los campos son requeridos'); window.history.back();</script>");
        return;
    }
    
    // Cargar driver y conectar
    Class.forName("com.mysql.cj.jdbc.Driver");
    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
    
    // Insertar en la tabla usuario (sin cédula)
    String sqlUsuario = "INSERT INTO usuario (nombre, paterno, materno, gmail, fechaNac, usuario, contrasena, id_tipo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    st = conecta.prepareStatement(sqlUsuario, PreparedStatement.RETURN_GENERATED_KEYS);
    st.setString(1, nombres);
    st.setString(2, apP);
    st.setString(3, apM);
    st.setString(4, email);
    st.setString(5, fechaN);
    st.setString(6, user);
    st.setString(7, password);
    st.setInt(8, 1); // 1 = tipo paciente
    
    int filasAfectadas = st.executeUpdate();
    
    if (filasAfectadas > 0) {
        // Obtener el ID del usuario recién insertado
        ResultSet generatedKeys = st.getGeneratedKeys();
        int idUsuario = 0;
        if (generatedKeys.next()) {
            idUsuario = generatedKeys.getInt(1);
            
            // Insertar en la tabla cliente
            String sqlCliente = "INSERT INTO cliente (id_usuario) VALUES (?)";
            stCliente = conecta.prepareStatement(sqlCliente);
            stCliente.setInt(1, idUsuario);
            stCliente.executeUpdate();
            
            out.println("<html><head><title>Registro Exitoso</title>");
            out.println("<script>");
            out.println("alert('Paciente registrado exitosamente');");
            out.println("window.location.href = 'patientManagement.html';");
            out.println("</script>");
            out.println("</head><body></body></html>");
        }
    }
    
} catch (ClassNotFoundException e) {
    out.println("<p>Error: Driver no encontrado - " + e.getMessage() + "</p>");
} catch (SQLException e) {
    out.println("<p>Error de base de datos: " + e.getMessage() + "</p>");
    e.printStackTrace();
} catch (Exception e) {
    out.println("<p>Error general: " + e.getMessage() + "</p>");
} finally {
    // Cerrar recursos
    try {
        if (st != null) st.close();
        if (stCliente != null) stCliente.close();
        if (conecta != null) conecta.close();
    } catch (SQLException e) {
        out.println("<p>Error al cerrar conexión: " + e.getMessage() + "</p>");
    }
}
%>