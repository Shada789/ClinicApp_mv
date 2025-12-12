<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    // Obtener id del usuario logueado desde sesión
    Integer id = (Integer) session.getAttribute("usuario");
    Integer tipo = (Integer) session.getAttribute("tipo");

    if(id == null) {
        // No hay usuario logueado, redirigir a inicio
        response.sendRedirect("index.html");
        return;
    }

    // Solo los doctores (tipo = 2) pueden entrar
    if(tipo != 2) {
        response.sendRedirect("patientMain.jsp");
        return;
    }

    Connection conecta = null;
    PreparedStatement st = null;
    ResultSet rz = null;

    String mensaje = "";

    String nombres = "", apP = "", apM = "", email = "", cedulaStr = "", user = "", password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");

        if(request.getMethod().equalsIgnoreCase("POST")) {
            String nombresNew = request.getParameter("nombre");
            String apPNew = request.getParameter("apellidoP");
            String apMNew = request.getParameter("apellidoM");
            String emailNew = request.getParameter("correo");
            String cedulaNew = request.getParameter("cedula");
            String userNew = request.getParameter("usuario");
            String passNew = request.getParameter("contrasenia");
            String confirmNew = request.getParameter("confirmar");

            if(!passNew.equals(confirmNew)) {
                mensaje = "Las contraseñas no coinciden.";
            } else {
                st = conecta.prepareStatement(
                    "UPDATE usuario SET nombre=?, paterno=?, materno=?, gmail=?, usuario=?, contrasena=?, cedula=? WHERE id_usuario=?"
                );
                st.setString(1, nombresNew);
                st.setString(2, apPNew);
                st.setString(3, apMNew);
                st.setString(4, emailNew);
                st.setString(5, userNew);
                st.setString(6, passNew);
                st.setString(7, cedulaNew);
                st.setInt(8, id);
                st.executeUpdate();
                mensaje = "Datos actualizados correctamente.";

                // Actualizar las variables para mostrar en los inputs
                nombres = nombresNew;
                apP = apPNew;
                apM = apMNew;
                email = emailNew;
                cedulaStr = cedulaNew;
                user = userNew;
                password = passNew;
            }
        }

        // Cargar datos actuales desde DB
        st = conecta.prepareStatement("SELECT * FROM usuario WHERE id_usuario=?");
        st.setInt(1, id);
        rz = st.executeQuery();

        if(rz.next()) {
            nombres = rz.getString("nombre");
            apP = rz.getString("paterno");
            apM = rz.getString("materno");
            email = rz.getString("gmail");
            cedulaStr = rz.getString("cedula");
            user = rz.getString("usuario");
            password = rz.getString("contrasena");
        }

    } catch(Exception e) {
        mensaje = "Error: " + e.getMessage();
    } finally {
        try { if(rz != null) rz.close(); if(st != null) st.close(); if(conecta != null) conecta.close(); } catch(SQLException e) {}
    }
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css">
    <title>Editar Cuenta</title>
</head>
<body id="bodDoc">
    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp"><img src="imgs/Codementor--Streamline-Simple-Icons.svg"><span>Inicio</span></a></li>
            <li><a href="patientManagement.html"><img src="imgs/patient-svgrepo-com.svg"><span>Pacientes</span></a></li>
            <li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg"><span>Historial</span></a></li>
            <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg"><span>Citas</span></a></li>
            <li><a href="docTreatments.html"><img src="imgs/tooth-with-mouthwash-svgrepo-com.svg"><span>Tratamientos</span></a></li>
            <li><a href="myProfile.jsp"><img src="imgs/profile-1341-svgrepo-com.svg"><span>Perfil</span></a></li>
        </ul>
    </nav>

    <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Editar Cuenta</h1>
    </header>

    <main id="genDoc2">
        <section>
            <h1>Edite su cuenta</h1>
            <article id="registro">
                <form id="formRegistroDoctor" method="post" action="editarCuenta.jsp">
                    <label for="name"><b>Nombres:</b></label>
                    <input type="text" id="name" name="nombre" value="<%=nombres%>" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" value="<%=apP%>" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" value="<%=apM%>" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" value="<%=email%>" required>

                    <label for="cedula"><b>Cédula Profesional:</b></label>
                    <input type="text" id="cedula" name="cedula" value="<%=cedulaStr%>">

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" value="<%=user%>" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" value="<%=password%>" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" value="<%=password%>" required>

                    <p style="color:red;"><%=mensaje%></p>

                    <button type="submit" class="botonImportante">Guardar</button>
                    <button type="button" class="boton" onclick="location.href='myProfile.jsp'">Cancelar</button>
                </form>
            </article>
        </section>
    </main>
</body>
</html>