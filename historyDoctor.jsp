<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.*" %>
<%
    Connection conn = null;
    Statement stGlobal = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/chambs", "root", "n0m3l0");
        stGlobal = conn.createStatement();
    } catch (Exception e) {
        out.println("Error de conexión: " + e);
    }
%> 
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <style>
    tr{
        background:white;
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
#historialBox {
    display: none;
}
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
.result-box .item {
    padding: 8px;
    cursor: pointer;
}

.result-box .item:hover {
    background: #eee;
}

    </style>
    <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Buscar Paciente</title>

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
            <li><a href="historyDoctor.jsp"><img src="imgs/clinic-history-folder-with-plus-sign-svgrepo-com.svg">
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

        <h1>Historial Pacientes</h1>
    </header>
    <main id="genDoc2">
       
        
        <section id="busc">
            
            <div class="container">
                <form class="form-busqueda" method="post">
                    <input type="text" name="busqueda" placeholder="Buscar" 
                           value="<%= request.getParameter("busqueda") != null ? request.getParameter("busqueda") : "" %>" 
                           class="input-busqueda">
                    <button type="submit" class="btn-busqueda">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>
        </section>

        <section id="tablaPacientesSection">
<%
    String busqueda = request.getParameter("busqueda");
    
    if (busqueda != null && !busqueda.trim().isEmpty()) {
        Connection conecta = null;
        PreparedStatement st = null;
        ResultSet rs = null;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conecta = DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs", "root", "n0m3l0");
            
            // Consulta para buscar pacientes por nombre o apellido
            String sql = "SELECT u.nombre, u.paterno, u.materno, u.gmail, u.fechaNac, " +
                         "c.id_cliente, u.id_usuario " +
                         "FROM usuario u " +
                         "INNER JOIN cliente c ON u.id_usuario = c.id_usuario " +
                         "WHERE u.id_tipo = 1 " +
                         "AND (u.nombre LIKE ? OR u.paterno LIKE ? OR u.materno LIKE ? OR u.gmail LIKE ?) " +
                         "ORDER BY u.paterno, u.materno, u.nombre";
            
            st = conecta.prepareStatement(sql);
            String parametroBusqueda = "%" + busqueda + "%";
            st.setString(1, parametroBusqueda);
            st.setString(2, parametroBusqueda);
            st.setString(3, parametroBusqueda);
            st.setString(4, parametroBusqueda);
            
            rs = st.executeQuery();
            %>
            
            <table id="tablasDia">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                        <th>Email</th>
                        <th>Fecha Nacimiento</th>
                        <th>Acciones</th>
                    </tr>
                
                    <%
                    boolean hayResultados = false;
                    while (rs.next()) {
                        hayResultados = true;
                        int idUsuario = rs.getInt("id_usuario");
                        String nombre = rs.getString("nombre");
                        String paterno = rs.getString("paterno");
                        String materno = rs.getString("materno");
                        String email = rs.getString("gmail");
                        String fechaNac = rs.getString("fechaNac");
                        int idCliente = rs.getInt("id_cliente");
                    %>
                    <tr>
                        <td><%= nombre %></td>
                        <td><%= paterno %></td>
                        <td><%= materno %></td>
                        <td><%= email %></td>
                        <td><%= fechaNac %></td>
                        <td>
                            <button type="button" onclick="cargarHistorial(<%= idCliente %>)" class="btn-editar">
                                <i class="fa-solid fa-pen-to-square"></i> Historial
                            </button>
                            
                        </td>
                    </tr>
                    <%
                    }
                    
                    if (!hayResultados) {
                    %>
                    <tr>
                        <td colspan="6" class="mensaje-vacio">
                            No se encontraron pacientes con el criterio de búsqueda: "<%= busqueda %>"
                        </td>
                    </tr>
                    <%
                    }
                    %>
                </thead>
            </table>

            <%
        } catch (SQLException e) {
            out.println("<p style='color:red; text-align:center;'>Error de base de datos: " + e.getMessage() + "</p>");
        } finally {
            // Cerrar recursos
            try {
                if (rs != null) rs.close();
                if (st != null) st.close();
                if (conecta != null) conecta.close();
            } catch (SQLException e) {
                out.println("<p style='color:red; text-align:center;'>Error al cerrar conexión: " + e.getMessage() + "</p>");
            }
        }
    } else if (busqueda != null && busqueda.trim().isEmpty()) {
    %>
    <div class="mensaje-vacio">
        Por favor, ingresa un término de búsqueda.
    </div>
    <%
    } else {
    %>
    <div class="mensaje-vacio">
        Ingresa un nombre o apellido en la barra de búsqueda para encontrar pacientes.
    </div>
    <%
    }
%>
        </section>
       <section id="historialBox">
            <h2>Historial del Paciente</h2>
            <textarea id="areaHistorial"></textarea>
            <button class="botonImportante" id="btnGuardar" onclick="guardarHistorial()">Guardar</button>
        </section>

    </main>

<script>
let clienteActual = null;

function cargarHistorial(idCliente) {
    clienteActual = idCliente;

    fetch("getHistorial.jsp?idCliente=" + idCliente)
        .then(r => r.text())
        .then(t => {
            document.getElementById("areaHistorial").value = t;
            document.getElementById("historialBox").style.display = "block";
        });
}

function guardarHistorial() {
    let texto = document.getElementById("areaHistorial").value;

    fetch("saveHistorial.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "idCliente=" + clienteActual + "&texto=" + encodeURIComponent(texto)
    })
    .then(r => r.text())
    .then(t => {
        if (t.trim() === "OK") {
            mostrarToast("Historial guardado correctamente");
        } else {
            mostrarToast("Error: " + t);
        }
    });
}
function mostrarToast(msg) {
    const toast = document.getElementById("toast");
    toast.innerText = msg;

    toast.classList.add("show");

    setTimeout(() => {
        toast.classList.remove("show");
    }, 3000);
}
</script>
<div id="toast" class="toast">Historial guardado correctamente</div>
</body>
</html> 