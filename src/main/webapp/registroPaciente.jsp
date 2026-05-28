<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    String password = request.getParameter("contrasenia");
    if (password == null) {
        response.sendRedirect("registropac.jsp");
        return;
    }

    String nombres   = request.getParameter("nombre");
    String apP       = request.getParameter("apellidoP");
    String apM       = request.getParameter("apellidoM");
    String email     = request.getParameter("correo");
    String fechaN    = request.getParameter("nacimiento");
    String user      = request.getParameter("usuario");
    String confirmar = request.getParameter("confirmar");

    if (!password.equals(confirmar)) {
        out.println("<script>alert('Las contraseñas no coinciden'); window.history.back();</script>");
        return;
    }

    Connection conecta = null;
    PreparedStatement st = null;
    PreparedStatement stPac = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        PreparedStatement chk = conecta.prepareStatement(
            "SELECT id_usuario FROM usuario WHERE usuario = ? LIMIT 1"
        );
        chk.setString(1, user);
        ResultSet rsChk = chk.executeQuery();
        if (rsChk.next()) {
            out.println("<script>alert('Ese usuario ya existe'); window.history.back();</script>");
            return;
        }
        rsChk.close(); chk.close();

        st = conecta.prepareStatement(
            "INSERT INTO usuario (nombre, paterno, materno, email, fecha_nac, usuario, contrasena, rol) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, 'paciente')",
            Statement.RETURN_GENERATED_KEYS
        );
        st.setString(1, nombres);
        st.setString(2, apP);
        st.setString(3, apM);
        st.setString(4, email);
        st.setString(5, fechaN);
        st.setString(6, user);
        st.setString(7, password);
        st.executeUpdate();

        ResultSet keys = st.getGeneratedKeys();
        if (keys.next()) {
            int idUsuario = keys.getInt(1);
            stPac = conecta.prepareStatement(
                "INSERT INTO paciente (id_usuario, id_medico) VALUES (?, ?)"
            );
            stPac.setInt(1, idUsuario);
            stPac.setInt(2, idMedico);
            stPac.executeUpdate();
        }
        keys.close();

        out.println("<script>");
        out.println("alert('Paciente registrado exitosamente');");
        out.println("window.location.href = 'patientManagement.jsp';");
        out.println("</script>");

    } catch (SQLException e) {
        out.println("<script>alert('Error: " + e.getMessage().replace("'", "\\'") + "'); window.history.back();</script>");
    } finally {
        if (st      != null) try { st.close();      } catch (Exception ignored) {}
        if (stPac   != null) try { stPac.close();   } catch (Exception ignored) {}
        if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
    }
%>