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
    PreparedStatement st = null;
    ResultSet rz = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        // ── Verificar que el paciente pertenece a este médico ──────────────
        PreparedStatement chk = conecta.prepareStatement(
            "SELECT id_paciente FROM paciente WHERE id_paciente = ? AND id_medico = ? LIMIT 1"
        );
        chk.setInt(1, idPaciente);
        chk.setInt(2, idMedico);
        ResultSet rsChk = chk.executeQuery();
        if (!rsChk.next()) {
            response.sendRedirect("buscarPaciente.jsp");
            return;
        }

        // ── Procesar POST ──────────────────────────────────────────────────
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String nombre    = request.getParameter("nombre");
            String paterno   = request.getParameter("apellidoP");
            String materno   = request.getParameter("apellidoM");
            String correo    = request.getParameter("correo");
            String nacimiento = request.getParameter("nacimiento");
            String usuario   = request.getParameter("usuario");
            String contrasena = request.getParameter("contrasenia");
            String confirmar = request.getParameter("confirmar");

            if (!contrasena.equals(confirmar)) {
                mensaje = "Las contraseñas no coinciden.";
            } else {
                // Obtener id_usuario del paciente
                PreparedStatement stIdUsr = conecta.prepareStatement(
                    "SELECT id_usuario FROM paciente WHERE id_paciente = ? LIMIT 1"
                );
                stIdUsr.setInt(1, idPaciente);
                ResultSet rsUsr = stIdUsr.executeQuery();
                if (rsUsr.next()) {
                    int idUsuario = rsUsr.getInt("id_usuario");
                    st = conecta.prepareStatement(
                        "UPDATE usuario SET nombre=?, paterno=?, materno=?, email=?, " +
                        "fecha_nac=?, usuario=?, contrasena=? WHERE id_usuario=?"
                    );
                    st.setString(1, nombre);
                    st.setString(2, paterno);
                    st.setString(3, materno);
                    st.setString(4, correo);
                    st.setString(5, nacimiento);
                    st.setString(6, usuario);
                    st.setString(7, contrasena);
                    st.setInt(8, idUsuario);
                    st.executeUpdate();
                    mensaje = "Paciente actualizado correctamente.";
                }
            }
        }

        // ── Cargar datos actuales del paciente ─────────────────────────────
        st = conecta.prepareStatement(
            "SELECT u.id_usuario, u.nombre, u.paterno, u.materno, u.email, " +
            "u.fecha_nac, u.usuario, u.contrasena " +
            "FROM usuario u " +
            "JOIN paciente p ON u.id_usuario = p.id_usuario " +
            "WHERE p.id_paciente = ? LIMIT 1"
        );
        st.setInt(1, idPaciente);
        rz = st.executeQuery();

    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Editar Paciente</title>
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
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Editar Paciente</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article id="registroPaciente">
<%
    if (rz != null && rz.next()) {
%>
                <form action="editarPaciente.jsp?id=<%= idPaciente %>" method="post">

                    <label for="name"><b>Nombre:</b></label>
                    <input type="text" id="name" name="nombre"
                           value="<%= rz.getString("nombre") %>" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP"
                           value="<%= rz.getString("paterno") %>" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM"
                           value="<%= rz.getString("materno") %>" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo"
                           value="<%= rz.getString("email") %>" required>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento"
                           value="<%= rz.getString("fecha_nac") %>" required>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario"
                           value="<%= rz.getString("usuario") %>" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia"
                           value="<%= rz.getString("contrasena") %>" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar"
                           value="<%= rz.getString("contrasena") %>" required>

                    <button type="submit" class="botonImportante">Actualizar</button>
                </form>
<%
    } else {
        out.println("<p>Paciente no encontrado.</p>");
    }
    if (rz  != null) try { rz.close();      } catch (Exception ignored) {}
    if (st  != null) try { st.close();      } catch (Exception ignored) {}
    if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
%>
                <button type="button" class="boton"
                        onclick="location.href='buscarPaciente.jsp'">Regresar</button>
            </article>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

    <div id="toast" class="toast"></div>
    <script>
        <% if (!mensaje.isEmpty()) { %>
            window.onload = function() {
                const toast = document.getElementById("toast");
                toast.innerText = "<%= mensaje.replace("\"", "\\\"") %>";
                toast.classList.add("show");
                setTimeout(() => toast.classList.remove("show"), 3000);
            };
        <% } %>
    </script>

</body>
</html>