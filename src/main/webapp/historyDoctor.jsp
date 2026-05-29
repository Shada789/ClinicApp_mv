<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }
    
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    
    String busqueda = request.getParameter("busqueda");
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="clinictyle.css" type="text/css">
        <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
        <title>Historial Pacientes</title>
        <style>
            tr { background: white; }
            #tablasDia {
                width: 20%;
                border-collapse: collapse;
                display: table !important;
                float: none !important;
            }
            #tablasDia thead, #tablasDia tbody {
                display: table-row-group !important;
            }
            #tablasDia th, #tablasDia td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            #tablasDia th {
                background: linear-gradient(90deg, #8b0b44, #1c3a7e);
                color: white;
            }
            #historialBox { display: none; }
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
            <h1>Historial Pacientes</h1>
        </header>

        <main id="genDoc2">

            <section id="busc">
                <div class="container">
                    <form class="form-busqueda" method="post">
                        <input type="text" name="busqueda" placeholder="Buscar paciente"
                        value="<%= busqueda != null ? busqueda : "" %>"
                        class="input-busqueda">
                        <button type="submit" class="btn-busqueda">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </button>
                    </form>
                </div>
            </section>

            <section id="tablaPacientesSection">
                <%
                    if (busqueda != null && !busqueda.trim().isEmpty()) {
                        Connection con = null;
                        PreparedStatement st = null;
                        ResultSet rs = null;
                        
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            con = DriverManager.getConnection(
                            "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                            "root", "n0m3l0"
                            );
                            
                            st = con.prepareStatement(
                            "SELECT u.nombre, u.paterno, u.materno, u.email, u.fecha_nac, p.id_paciente " +
                            "FROM usuario u " +
                            "JOIN paciente p ON u.id_usuario = p.id_usuario " +
                            "WHERE p.id_medico = ? " +
                            "AND (u.nombre LIKE ? OR u.paterno LIKE ? OR u.materno LIKE ? OR u.email LIKE ?) " +
                            "ORDER BY u.paterno, u.materno, u.nombre"
                            );
                            String param = "%" + busqueda.trim() + "%";
                            st.setInt(1, idMedico);
                            st.setString(2, param);
                            st.setString(3, param);
                            st.setString(4, param);
                            st.setString(5, param);
                            
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
                            </thead>
                            <tbody>
                                <%
                                    boolean hayResultados = false;
                                    while (rs.next()) {
                                        hayResultados = true;
                                        int idPaciente   = rs.getInt("id_paciente");
                                        String nombre    = rs.getString("nombre");
                                        String paterno   = rs.getString("paterno");
                                        String materno   = rs.getString("materno");
                                        String email     = rs.getString("email");
                                        String fechaNac  = rs.getString("fecha_nac");
                                    %>
                                    <tr>
                                        <td><%= nombre %></td>
                                        <td><%= paterno %></td>
                                        <td><%= materno %></td>
                                        <td><%= email %></td>
                                        <td><%= fechaNac %></td>
                                        <td>
                                            <button type="button"
                                            onclick="cargarHistorial(<%= idPaciente %>)"
                                            class="btn-editar">
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
                                        No se encontraron pacientes con: "<%= busqueda %>"
                                    </td>
                                </tr>
                                <%
                                }
                            %>
                        </tbody>
                    </table>
                    <%
                    } catch (SQLException e) {
                        out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
                    } finally {
                    if (rs  != null) try { rs.close();  } catch (Exception ignored) {}
                    if (st  != null) try { st.close();  } catch (Exception ignored) {}
                    if (con != null) try { con.close(); } catch (Exception ignored) {}
                }
                
            } else if (busqueda != null && busqueda.trim().isEmpty()) {
            %>
            <div class="mensaje-vacio">Por favor ingresa un término de búsqueda.</div>
            <%
            } else {
            %>
            <div class="mensaje-vacio">Ingresa un nombre o apellido para buscar pacientes.</div>
            <%
            }
        %>
    </section>

   <section id="historialBox">
    <h2>Historial del Paciente</h2>

    <div id="infoPaciente" style="
        background: #f9f9f9;
        border-radius: 10px;
        padding: 15px;
        margin-bottom: 15px;
        font-size: 15px;
        line-height: 1.6;
    "></div>

    <h3>Notas del médico</h3>
    <textarea id="areaHistorial" readonly style="
        background: #f5f5f5;
        color: #333;
        cursor: default;
    "></textarea>

    <h3>Agregar nota</h3>
    <textarea id="nuevaNota" placeholder="Escribe aquí una nota nueva..."></textarea>
    <button class="botonImportante" id="btnGuardar" onclick="guardarHistorial()">Guardar nota</button>
</section>

</main>

<div id="toast" class="toast"></div>

<script>
    let pacienteActual = null;
    
    function cargarHistorial(idPaciente) {
    pacienteActual = idPaciente;

    fetch("getInfoPaciente.jsp?idPaciente=" + idPaciente)
        .then(r => r.text())
        .then(t => {
            document.getElementById("infoPaciente").innerHTML = t;
        });

    fetch("getHistorial.jsp?idPaciente=" + idPaciente)
        .then(r => r.text())
        .then(t => {
            document.getElementById("areaHistorial").value = t;
            document.getElementById("nuevaNota").value = "";
            document.getElementById("historialBox").style.display = "block";
        });
}

function guardarHistorial() {
    let texto = document.getElementById("nuevaNota").value.trim();
    if (!texto) {
        mostrarToast("Escribe una nota antes de guardar.");
        return;
    }

    fetch("saveHistorial.jsp", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "idPaciente=" + pacienteActual + "&texto=" + encodeURIComponent(texto)
    })
    .then(r => r.text())
    .then(t => {
        if (t.trim() === "OK") {
            mostrarToast("Nota guardada correctamente.");
            document.getElementById("nuevaNota").value = "";
            fetch("getHistorial.jsp?idPaciente=" + pacienteActual)
                .then(r => r.text())
                .then(t => {
                    document.getElementById("areaHistorial").value = t;
                });
        } else {
            mostrarToast("Error: " + t);
        }
    });

}
    
    function mostrarToast(msg) {
        const toast = document.getElementById("toast");
        toast.innerText = msg;
        toast.classList.add("show");
        setTimeout(() => toast.classList.remove("show"), 3000);
    }
</script>

</body>
</html>