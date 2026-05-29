<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    String msgToast = request.getParameter("msg");
    String msgJS = (msgToast != null) ? msgToast.replace("\"", "\\\"") : "";
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Registro de Paciente</title>
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
        <h1>Paciente Nuevo</h1>
    </header>

    <main id="genDoc2">
        <section>
            <article id="registroPaciente">
                <form id="formRegistroDoctor" action="registroPaciente.jsp" method="post">

                    <label for="name"><b>Nombre(s):</b></label>
                    <input type="text" id="name" name="nombre" placeholder="Nombre(s)" required>

                    <label for="paterno"><b>Apellido Paterno:</b></label>
                    <input type="text" id="paterno" name="apellidoP" placeholder="Paterno" required>

                    <label for="materno"><b>Apellido Materno:</b></label>
                    <input type="text" id="materno" name="apellidoM" placeholder="Materno" required>

                    <label for="correo"><b>Correo Electrónico:</b></label>
                    <input type="email" id="correo" name="correo" placeholder="Correo" required>

                    <label for="fechanac"><b>Fecha de Nacimiento:</b></label>
                    <input type="date" id="fechanac" name="nacimiento" required>

                    <label for="usuario"><b>Usuario:</b></label>
                    <input type="text" id="usuario" name="usuario" placeholder="Username" required>

                    <label for="contrasenia"><b>Contraseña:</b></label>
                    <input type="password" id="contrasenia" name="contrasenia" placeholder="Password" required>

                    <label for="confirm"><b>Confirmar contraseña:</b></label>
                    <input type="password" id="confirm" name="confirmar" placeholder="Confirm Password" required>

                    <button type="submit" class="botonImportante">Registrar</button>
                </form>

                <button type="button" class="boton" onclick="location.href='patientManagement.jsp'">Regresar</button>
            </article>
        </section>

        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

    <div id="toast" class="toast"></div>
    <script>
        window.onload = function() {
            const msg = "<%= msgJS %>";
            if (!msg || msg.trim() === "") return;
            const toast = document.getElementById("toast");
            toast.innerText = msg;
            toast.classList.add("show");
            setTimeout(() => toast.classList.remove("show"), 3000);
        };
    </script>

</body>
</html>