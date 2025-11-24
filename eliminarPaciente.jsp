<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<%
    String id = request.getParameter("id");
    
    if(id != null){
        try {
            Connection conecta;
            PreparedStatement st;
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
            
            // Primero eliminar de la tabla cliente (por la clave foránea)
            st = conecta.prepareStatement("DELETE FROM cliente WHERE id_usuario = ?");
            st.setString(1, id);
            st.executeUpdate();
            st.close();
            
            // Luego eliminar de la tabla usuario
            st = conecta.prepareStatement("DELETE FROM usuario WHERE id_usuario = ?");
            st.setString(1, id);
            int filasAfectadas = st.executeUpdate();
            
            if(filasAfectadas > 0) {
                out.println("<html><head><title>Eliminación Exitosa</title>");
                out.println("<script>");
                out.println("alert('Paciente eliminado correctamente');");
                out.println("window.location.href = 'buscarPaciente.jsp';");
                out.println("</script>");
                out.println("</head><body></body></html>");
            } else {
                out.println("<script>alert('Error: No se pudo eliminar el paciente'); window.history.back();</script>");
            }
            
            st.close();
            conecta.close();
            
        } catch(Exception e) {
            out.println("<html><head><title>Error</title>");
            out.println("<script>");
            out.println("alert('ERROR: " + e.getMessage() + "');");
            out.println("window.history.back();");
            out.println("</script>");
            out.println("</head><body></body></html>");
        }
    } else {
        out.println("<script>alert('ID de paciente no proporcionado'); window.history.back();</script>");
    }
%>