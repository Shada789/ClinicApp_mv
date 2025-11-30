<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    Integer usuario = (Integer) session.getAttribute("usuario");
    Integer tipo = (Integer) session.getAttribute("tipo");

    if (usuario == null) {
        response.sendRedirect("index.html");
        return;
    }

    if (tipo != 2) { 
        response.sendRedirect("patientMain.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Página Principal</title>
</head>

<body id="bodDoc">
    
        <nav id="navDoc">
            <ul>
                <li><a href="doctorMain.html">
                    <img src="imgs/Codementor--Streamline-Simple-Icons.svg">
                    <span>Inicio</span></a></li>
                <li><a href="patientManagement.html">
                    <img src="imgs/patient-svgrepo-com.svg">
                    <span>Pacientes</span></a></li>
                <li><a href="historyDoctor.html"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
                <span>Historial</span></a></li></a></li>
                <li><a href="docAppts.html"><img src="imgs/calendar-symbol-svgrepo-com.svg">
                <span>Citas</span></a></li></a></li>
                <li><a href="docTreatments.html">
                    <img src="imgs/tooth-with-mouthwash-svgrepo-com.svg">
                   <span>Tratamientos</span></a></li>
                <li><a href="myProfile.html"><img src="imgs/profile-1341-svgrepo-com.svg">
                <span>Perfil</span></a></li>
            </ul>
        </nav>
    
 <header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
        
        <section>
            <p>Bienvenido(a), [Nombre]!</p>
        </section>

        <section id="tablasDia">
            <article>
                <h2>Citas del Día</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Paciente</th>
                            <th>Hora</th>
                            <th>Motivo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>
                    </tbody>
                </table>
            </article>

            <article>
                <h2>Tratamientos del Día</h2>
                <table>
                    <thead>
                        <tr>
                            <th>Paciente</th>
                            <th>Tratamiento</th>
                            <th>Estado</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>0</td>
                            <td>0</td>
                            <td>0</td>
                        </tr>
                    </tbody>
                </table>
            </article>

            <aside id="reloj">
                <h3>Fecha y Hora</h3>
                <p id="hora">[HORA]</p>
                <p id="fecha">[FECHA]</p><br>
            </aside>
        </section>
        <footer>
        <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
    </footer>
    </main>
<script>
    function actualizarReloj() {
            const ahora = new Date();

            const opcionesHora = { hour: '2-digit', minute: '2-digit', hour12: true };
            const horaFormateada = ahora.toLocaleTimeString('es-ES', opcionesHora);
            
            const opcionesFecha = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            const fechaFormateada = ahora.toLocaleDateString('es-ES', opcionesFecha);
            
            document.getElementById('hora').textContent = horaFormateada;
            document.getElementById('fecha').textContent = fechaFormateada;
        }
        actualizarReloj();
        setInterval(actualizarReloj, 1000);
</script>
</body>
</html>