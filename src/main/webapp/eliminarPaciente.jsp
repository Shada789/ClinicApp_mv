<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    String idPacStr = request.getParameter("id");
    if (idPacStr == null) {
        response.sendRedirect("buscarPaciente.jsp");
        return;
    }
    int idPaciente = Integer.parseInt(idPacStr);

    String mensaje = "";
    Connection conecta = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        // ── Verificar que el paciente pertenece a este médico ──────────────
        PreparedStatement chk = conecta.prepareStatement(
            "SELECT id_usuario FROM paciente WHERE id_paciente = ? AND id_medico = ? LIMIT 1"
        );
        chk.setInt(1, idPaciente);
        chk.setInt(2, idMedico);
        ResultSet rsChk = chk.executeQuery();

        if (!rsChk.next()) {
            mensaje = "No tienes permiso para eliminar este paciente.";
        } else {
            int idUsuario = rsChk.getInt("id_usuario");

            // Con ON DELETE CASCADE en la BD, eliminar usuario
            // borra automáticamente el registro en paciente
            PreparedStatement st = conecta.prepareStatement(
                "DELETE FROM usuario WHERE id_usuario = ?"
            );
            st.setInt(1, idUsuario);
            int filas = st.executeUpdate();
            st.close();

            mensaje = filas > 0
                ? "Paciente eliminado correctamente."
                : "No se pudo eliminar el paciente.";
        }

} catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    } finally {
        if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
    }
    String mensajeJS = mensaje.replace("\"", "\\\"");
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Eliminar Paciente</title>
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
    <%@ include file="navDoctor.jsp" %>
    <div id="toast" class="toast"></div>
    <script>
        function mostrarToast(msg, redirect) {
            const toast = document.getElementById("toast");
            toast.innerText = msg;
            toast.classList.add("show");
            setTimeout(() => {
                toast.classList.remove("show");
                window.location.href = redirect;
            }, 3000);
        }
        mostrarToast("<%= mensajeJS %>", "buscarPaciente.jsp");
    </script>
</body>
</html>
