<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

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
        .toast.show {
            right: 30px;
            opacity: 1;
        }
    </style>
</head>
<body>
<div id="toast" class="toast"></div>

<%
    String id = request.getParameter("id");

    if(id != null){
        Connection conecta = null;
        PreparedStatement st = null;
        String mensaje = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");

            // 1. Eliminar registros de infocliente
            st = conecta.prepareStatement(
                "DELETE FROM infocliente WHERE id_cliente = (SELECT id_cliente FROM cliente WHERE id_usuario=?)"
            );
            st.setString(1, id);
            st.executeUpdate();
            st.close();

            // 2. Eliminar cliente
            st = conecta.prepareStatement("DELETE FROM cliente WHERE id_usuario = ?");
            st.setString(1, id);
            st.executeUpdate();
            st.close();

            // 3. Eliminar usuario
            st = conecta.prepareStatement("DELETE FROM usuario WHERE id_usuario = ?");
            st.setString(1, id);
            int filasAfectadas = st.executeUpdate();
            st.close();

            if(filasAfectadas > 0) {
                mensaje = "Paciente eliminado correctamente";
            } else {
                mensaje = "Error: No se pudo eliminar el paciente";
            }

            conecta.close();

        } catch(Exception e) {
            mensaje = "ERROR: " + e.getMessage();
        }
%>

<script>
    function mostrarToast(msg, redirect = null) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("show");
        setTimeout(() => {
            toast.classList.remove("show");
            if(redirect) window.location.href = redirect;
        }, 3000);
    }

    mostrarToast("<%= mensaje %>", "buscarPaciente.jsp");
</script>

<%
    } else {
%>
<script>
    mostrarToast("ID de paciente no proporcionado", "buscarPaciente.jsp");
</script>
<%
    }
%>
</body>
</html>