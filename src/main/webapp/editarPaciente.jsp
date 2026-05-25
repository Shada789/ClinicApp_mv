<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

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
    .toast.show {
        right: 30px;
        opacity: 1;
    }
    </style>
</head>
<body id="bodDoc">
    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp"><img src="imgs/Codementor--Streamline-Simple-Icons.svg"><span>Inicio</span></a></li>
            <li><a href="patientManagement.html"><img src="imgs/patient-svgrepo-com.svg"><span>Pacientes</span></a></li>
            <li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg"><span>Historial</span></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg"><span>Citas</span></a></li>
            <li><a href="docTreatments.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg"><span>Tratamientos</span></a></li>
            <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg"><span>Perfil</span></a></li>
        </ul>
    </nav>

    <main id="genDoc2">
        <header>
            <h1>Editar Información del Paciente</h1>
        </header>
        <section>
            <h2>Modificar Datos del Paciente</h2>
            <article id="registroPaciente">
                <%
                String id = request.getParameter("id");
                String mensaje = "";
                Connection conecta = null;
                PreparedStatement st = null;
                ResultSet rz = null;
                
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
                    
                    if(request.getMethod().equalsIgnoreCase("POST")) {
                        String nombre = request.getParameter("nombre");
                        String paterno = request.getParameter("apellidoP");
                        String materno = request.getParameter("apellidoM");
                        String correo = request.getParameter("correo");
                        String nacimiento = request.getParameter("nacimiento");
                        String usuario = request.getParameter("usuario");
                        String contrasena = request.getParameter("contrasenia");
                        String confirmar = request.getParameter("confirmar");
                        String idUsr = request.getParameter("id_usuario");

                        if(!contrasena.equals(confirmar)) {
                            mensaje = "Las contraseñas no coinciden.";
                        } else {
                            st = conecta.prepareStatement(
                                "UPDATE usuario SET nombre=?, paterno=?, materno=?, gmail=?, fechaNac=?, usuario=?, contrasena=? WHERE id_usuario=?"
                            );
                            st.setString(1, nombre);
                            st.setString(2, paterno);
                            st.setString(3, materno);
                            st.setString(4, correo);
                            st.setString(5, nacimiento);
                            st.setString(6, usuario);
                            st.setString(7, contrasena);
                            st.setString(8, idUsr);
                            st.executeUpdate();
                            mensaje = "Paciente actualizado correctamente.";
                        }
                    }

                    // Cargar los datos actuales del paciente
                    st = conecta.prepareStatement("SELECT * FROM usuario WHERE id_usuario = ?");
                    st.setString(1, id);
                    rz = st.executeQuery();
                    
                    if (rz.next()) {
                %>
                <form id="formRegistroDoctor" action="editarPaciente.jsp?id=<%=id%>" method="post">
                    <input type="hidden" name="id_usuario" value="<%=rz.getInt("id_usuario")%>"/>
                    
                    <label for="name"><b>Nombre:</b></label>
                    <input type="text" id="name" name="nombre" value="<%=rz.getString("nombre")%>" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" value="<%=rz.getString("paterno")%>" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" value="<%=rz.getString("materno")%>" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" value="<%=rz.getString("gmail")%>" required>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento" value="<%=rz.getString("fechaNac")%>" required>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" value="<%=rz.getString("usuario")%>" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" value="<%=rz.getString("contrasena")%>" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" value="<%=rz.getString("contrasena")%>" required>

                    <button type="submit" class="botonImportante">Actualizar Paciente</button>
                </form>
                <%
                    } else {
                        out.println("<p>Paciente no encontrado</p>");
                    }
                } catch(Exception e) {
                    out.println("<p>ERROR: " + e.getMessage() + "</p>");
                } finally {
                    try { if (rz != null) rz.close(); if (st != null) st.close(); if (conecta != null) conecta.close(); } catch(SQLException e) {}
                }
                %>
                <button type="button" class="boton" onclick="location.href='buscarPaciente.jsp'">Regresar</button> 
            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

    <div id="toast" class="toast"></div>
    <script>
    function mostrarToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("show");
        setTimeout(() => { toast.classList.remove("show"); }, 3000);
    }

    <% if(!mensaje.isEmpty()) { %>
        mostrarToast("<%=mensaje.replace("\"","\\\"")%>");
    <% } %>
    </script>
</body>
</html>