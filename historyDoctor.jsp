<%@ page import="java.sql.*" %>
<%@ page contentType="application/json" %>


<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Historial Clínico</title>
    <style>
        textarea {
            background-color: transparent;
            border: none;
            outline: none;
        }
        .result-box {
    position: absolute;
    background: white;
    border: 1px solid #ccc;
    width: 250px;
    max-height: 200px;
    overflow-y: auto;
    display: none;
    z-index: 100;
}

.result-box .item {
    padding: 8px;
    cursor: pointer;
}

.result-box .item:hover {
    background: #eee;
}
    </style>
</head>

<body id="bodDoc">
    <nav id="navDoc">
        <ul>
            <li><a href="doctorMain.jsp">
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


        <section id="hist">
            <article>
                <h2>Buscar Paciente </h2>
                <div class="container">
                    <form action="buscarPacientes.jsp" method="GET">
    <input type="text" id="buscarPaciente" placeholder="Nombre(s) o Username" autocomplete="off">
<div id="resultados" class="result-box"></div>
    <button><i class="fa-solid fa-magnifying-glass"></i></button>
</form>
                </div>
                <br>
            </article>

            <article>
                <h2>Historial</h2>
                <br>
                <form id="formRegistroDoctor">

                    <textarea></textarea>

                </form>
            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>

<script>
const input = document.getElementById("buscarPaciente");
const box = document.getElementById("resultados");

input.addEventListener("keyup", () => {
    let term = input.value.trim();

    if (term.length === 0) {
        box.innerHTML = "";
        box.style.display = "none";
        return;
    }

    fetch("searchPatient.jsp?term=" + term)
        .then(res => res.json())
        .then(data => {
            box.innerHTML = "";
            if (data.length === 0) {
                box.style.display = "none";
                return;
            }

            data.forEach(p => {
                let div = document.createElement("div");
                div.classList.add("item");
                div.innerText = p.nombre + " (" + p.username + ")";                
                div.onclick = () => {
                    input.value = p.nombre;
                    box.innerHTML = "";
                    box.style.display = "none";
                };

                box.appendChild(div);
            });

            box.style.display = "block";
        });
});
</script>
</body>

</html>