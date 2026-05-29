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

    String mensaje  = "";
    String destino  = "";

    if (!password.equals(confirmar)) {
        response.sendRedirect("registropac.jsp?msg=" + java.net.URLEncoder.encode("Las contraseñas no coinciden.", "UTF-8"));
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
            rsChk.close(); chk.close();
            response.sendRedirect("registropac.jsp?msg=" + java.net.URLEncoder.encode("Ese usuario ya existe.", "UTF-8"));
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

response.sendRedirect("registropac.jsp?msg=" + java.net.URLEncoder.encode("Paciente registrado exitosamente.", "UTF-8"));
    } catch (SQLException e) {
        response.sendRedirect("registropac.jsp?msg=" + java.net.URLEncoder.encode("Error: " + e.getMessage(), "UTF-8"));
    } finally {
        if (st      != null) try { st.close();      } catch (Exception ignored) {}
        if (stPac   != null) try { stPac.close();   } catch (Exception ignored) {}
        if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registrando paciente...</title>
    <style>
        .toast {
            position: fixed;
            bottom: 30px;
            right: -300px;
            background: linear-gradient(135deg, #A80139, rgb(16, 51, 121));
            color: white;
            padding: 15px 25px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 16px;
            box-shadow: 0 0 18px rgba(0,0,0,0.25);
            opacity: 0;
            transition: all 0.6s ease;
            z-index: 2000;
        }
        .toast.show { right: 30px; opacity: 1; }
    </style>
</head>
<body>
 <%
String msgToast = request.getParameter("msg");
String msgJS = (msgToast != null)
    ? msgToast.replace("\"", "\\\"")
    : "";
%>

<div id="toast" class="toast"></div>

<script>
function mostrarToast(msg) {
    if (!msg) return;

    const toast = document.getElementById("toast");
    toast.innerText = msg;
    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}

mostrarToast("<%= msgJS %>");
</script>
</body>
</html>