<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    Connection conecta = null;
    PreparedStatement st = null;
    ResultSet rz = null;
    String mensaje = "";

    String nombres = "", apP = "", apM = "", email = "", cedulaStr = "", user = "", password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection(
            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
            "root", "n0m3l0"
        );

        // ── Procesar POST ──────────────────────────────────────────────────
        if (request.getMethod().equalsIgnoreCase("POST")) {
            String nombresNew  = request.getParameter("nombre");
            String apPNew      = request.getParameter("apellidoP");
            String apMNew      = request.getParameter("apellidoM");
            String emailNew    = request.getParameter("correo");
            String cedulaNew   = request.getParameter("cedula");
            String userNew     = request.getParameter("usuario");
            String passNew     = request.getParameter("contrasenia");
            String confirmNew  = request.getParameter("confirmar");

            if (!passNew.equals(confirmNew)) {
                mensaje = "Las contraseñas no coinciden.";
            } else {
                // Actualizar usuario
                PreparedStatement stUsr = conecta.prepareStatement(
                    "UPDATE usuario u " +
                    "JOIN medico m ON u.id_usuario = m.id_usuario " +
                    "SET u.nombre=?, u.paterno=?, u.materno=?, u.email=?, " +
                    "    u.usuario=?, u.contrasena=? " +
                    "WHERE m.id_medico=?"
                );
                stUsr.setString(1, nombresNew);
                stUsr.setString(2, apPNew);
                stUsr.setString(3, apMNew);
                stUsr.setString(4, emailNew);
                stUsr.setString(5, userNew);
                stUsr.setString(6, passNew);
                stUsr.setInt(7, idMedico);
                stUsr.executeUpdate();
                stUsr.close();

                // Actualizar cédula en tabla medico
                PreparedStatement stMed = conecta.prepareStatement(
                    "UPDATE medico SET cedula=? WHERE id_medico=?"
                );
                stMed.setString(1, cedulaNew);
                stMed.setInt(2, idMedico);
                stMed.executeUpdate();
                stMed.close();

                mensaje = "Datos actualizados correctamente.";
            }
        }

        // ── Cargar datos actuales ──────────────────────────────────────────
        st = conecta.prepareStatement(
            "SELECT u.nombre, u.paterno, u.materno, u.email, u.usuario, " +
            "u.contrasena, m.cedula " +
            "FROM usuario u " +
            "JOIN medico m ON u.id_usuario = m.id_usuario " +
            "WHERE m.id_medico = ? LIMIT 1"
        );
        st.setInt(1, idMedico);
        rz = st.executeQuery();

        if (rz.next()) {
            nombres    = rz.getString("nombre");
            apP        = rz.getString("paterno");
            apM        = rz.getString("materno");
            email      = rz.getString("email");
            cedulaStr  = rz.getString("cedula") != null ? rz.getString("cedula") : "";
            user       = rz.getString("usuario");
            password   = rz.getString("contrasena");
        }

    } catch (Exception e) {
        mensaje = "Error: " + e.getMessage();
    } finally {
        if (rz      != null) try { rz.close();      } catch (Exception ignored) {}
        if (st      != null) try { st.close();      } catch (Exception ignored) {}
        if (conecta != null) try { conecta.close(); } catch (Exception ignored) {}
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Editar Cuenta</title>
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
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<script>
    window.onpageshow = function(e) {
        if (e.persisted) window.location.reload();
    };
</script>
</head>
<body id="bodDoc">

    <%@ include file="navDoctor.jsp" %>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Editar Cuenta</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article id="registro">
                <form id="formRegistroDoctor" class="two-columns" method="post" action="editAccount.jsp">

                    <div class="field">
                        <label for="name"><b>Nombres:</b></label>
                        <input type="text" id="name" name="nombre" value="<%= nombres %>" required>
                    </div>

                    <div class="field">
                        <label for="correo"><b>Correo Electrónico:</b></label>
                        <input type="email" id="correo" name="correo" value="<%= email %>" required>
                    </div>

                    <div class="field">
                        <label for="paterno"><b>Apellido Paterno:</b></label>
                        <input type="text" id="paterno" name="apellidoP" value="<%= apP %>" required>
                    </div>

                    <div class="field">
                        <label for="cedula"><b>Cédula Profesional:</b></label>
                        <input type="text" id="cedula" name="cedula" value="<%= cedulaStr %>">
                    </div>

                    <div class="field">
                        <label for="materno"><b>Apellido Materno:</b></label>
                        <input type="text" id="materno" name="apellidoM" value="<%= apM %>" required>
                    </div>

                    <div class="field">
                        <label for="usuario"><b>Usuario:</b></label>
                        <input type="text" id="usuario" name="usuario" value="<%= user %>" required>
                    </div>

                    <div class="field">
                        <label for="contrasenia"><b>Contraseña:</b></label>
                        <input type="password" id="contrasenia" name="contrasenia" value="<%= password %>" required>
                    </div>

                    <div class="field">
                        <label for="confirm"><b>Confirmar contraseña:</b></label>
                        <input type="password" id="confirm" name="confirmar" value="<%= password %>" required>
                    </div>

                    <button type="submit" class="botonImportante">Guardar</button>
                    <button type="button" class="boton" onclick="location.href='myProfile.jsp'">Cancelar</button>
                </form>
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