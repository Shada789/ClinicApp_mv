<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
    <title>Buscar Paciente</title>
    <script>
function confirmarEliminacion(id, nombre) {
    if (confirm('¿Estás seguro de que quieres eliminar al paciente: ' + nombre + '?\nEsta acción no se puede deshacer.')) {
        window.location.href = 'eliminarPaciente.jsp?id=' + id;
    }
}
</script>
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
    
    <main id="genDoc2">
        <header id="headerMain">
            <a href="logotipo.png" id="logo"></a>
            <h1>ClinicApp</h1>
        </header>
        
        <section id="busc">
            <h1>Buscar Paciente</h1>
            
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
                    String sql = "SELECT u.id_usuario, u.nombre, u.paterno, u.materno, u.gmail, u.fechaNac, " +
                                 "c.id_cliente " +
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
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Apellido Paterno</th>
                                <th>Apellido Materno</th>
                                <th>Email</th>
                                <th>Fecha Nacimiento</th>
                                <th>Acciones</th>
                            </tr>
                    </thead>
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
                                <td><%= idUsuario %></td>
                                <td><%= nombre %></td>
                                <td><%= paterno %></td>
                                <td><%= materno %></td>
                                <td><%= email %></td>
                                <td><%= fechaNac %></td>
                                <td>
                                    <a href="editarPaciente.jsp?id=<%= idUsuario %>" class="btn-editar">
                                    <i class="fa-solid fa-pen-to-square"></i> Editar
                                    </a><br><br>
                                    <a href="eliminarPaciente.jsp?id=<%= idUsuario %>" class="btn-editar" 
                                    onclick="return confirm('¿Estás seguro de que quieres eliminar este paciente?')">
                                    <i class="fa-solid fa-trash"></i> Eliminar
                                    </a>
                                </td>
                            </tr>
                            <%
                            }
                            
                            if (!hayResultados) {
                            %>
                            <tr>
                                <td colspan="7" class="mensaje-vacio">
                                    No se encontraron pacientes con el criterio de búsqueda: "<%= busqueda %>"
                                </td>
                            </tr>
                            <%
                            }
                            %>
                       
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
        
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>
</body>
</html>