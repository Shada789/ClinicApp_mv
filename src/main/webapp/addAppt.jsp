<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>

<%
Integer idMedicoObj = (Integer) session.getAttribute("id_medico");
if (idMedicoObj == null) { response.sendRedirect("index.html"); return; }
int idMedico = idMedicoObj;

String idPaciente = request.getParameter("paciente");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String descripcion = request.getParameter("descripcion");
String tipo = request.getParameter("tipo");
String fecha_hora = fecha + " " + hora;

Connection conecta = null;
PreparedStatement stCheck = null;
PreparedStatement stInsert = null;
PreparedStatement stSelect = null;
ResultSet rsCheck = null;
ResultSet rs = null;
String mensaje = "";
String claseMensaje = "";

try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    conecta = DriverManager.getConnection(
        "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
        "root", "n0m3l0"
    );

    stCheck = conecta.prepareStatement(
        "SELECT COUNT(*) FROM cita WHERE id_medico = ? AND estado != 'cancelada' " +
        "AND fecha_hora < TIMESTAMPADD(MINUTE, 60, ?) AND TIMESTAMPADD(MINUTE, 60, fecha_hora) > ?"
    );
    stCheck.setInt(1, idMedico);
    stCheck.setString(2, fecha_hora);
    stCheck.setString(3, fecha_hora);
    rsCheck = stCheck.executeQuery();
    boolean existe = false;
    if (rsCheck.next()) existe = rsCheck.getInt(1) > 0;

    if (existe) {
        mensaje = "Ya existe una cita en esa fecha y hora.";
        claseMensaje = "mensajeError";
    } else {
        stInsert = conecta.prepareStatement(
            "INSERT INTO cita (id_medico, id_paciente, fecha_hora, notas, tipo) VALUES (?,?,?,?,?)",
            Statement.RETURN_GENERATED_KEYS
        );
        stInsert.setInt(1, idMedico);
        stInsert.setInt(2, Integer.parseInt(idPaciente));
        stInsert.setString(3, fecha_hora);
        stInsert.setString(4, descripcion);
        stInsert.setString(5, tipo);
        stInsert.executeUpdate();

        ResultSet rsKeys = stInsert.getGeneratedKeys();
        if (rsKeys.next()) {
            int idCita = rsKeys.getInt(1);
            PreparedStatement stHist = conecta.prepareStatement(
                "INSERT INTO historial (id_paciente, id_medico, id_cita, notas_medico) VALUES (?, ?, ?, 'Cita agendada.')"
            );
            stHist.setInt(1, Integer.parseInt(idPaciente));
            stHist.setInt(2, idMedico);
            stHist.setInt(3, idCita);
            stHist.executeUpdate();
            stHist.close();
        }
        rsKeys.close();

        mensaje = "Cita agregada correctamente.";
        claseMensaje = "mensajeExito";
    }

    stSelect = conecta.prepareStatement(
        "SELECT c.id_cita, u.nombre AS paciente, c.fecha_hora, c.notas, c.tipo " +
        "FROM cita c JOIN paciente p ON c.id_paciente = p.id_paciente " +
        "JOIN usuario u ON p.id_usuario = u.id_usuario WHERE c.id_medico = ? ORDER BY c.fecha_hora"
    );
    stSelect.setInt(1, idMedico);
    rs = stSelect.executeQuery();

} catch (Exception e) {
    mensaje = "Error: " + e.getMessage();
    claseMensaje = "mensajeError";
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" content="text/css">
    <title>Agregar Cita</title>
    <meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<script>
    window.onpageshow = function(e) {
        if (e.persisted) window.location.reload();
    };
</script>
    <style>
        #formCita label,
        #formCita input,
        #formCita select {
            border: none;
            color: black;
            font-size: 16px;
            background-color: transparent;
        }

        #formCita button {
            grid-column: 1 / -1;
            justify-self: center;
            padding: 10px 20px;
            font-size: 18px;
        }

        #tablasDia {
            width: 100% !important;
            border-collapse: collapse !important;
            display: table !important;
            float: none !important;
        }

        #tablasDia th,
        #tablasDia td {
            border: 1px solid #ccc !important;
            padding: 10px !important;
            text-align: left !important;
        }

        #tablasDia th {
            background: linear-gradient(90deg, #8b0b44, #1c3a7e) !important;
            color: white !important;
        }

        #tablasDia th:nth-child(1),
        #tablasDia td:nth-child(1) {
            width: 20%;
        }

        #tablasDia th:nth-child(2),
        #tablasDia td:nth-child(2) {
            width: 30%;
        }

        #tablasDia th:nth-child(3),
        #tablasDia td:nth-child(3) {
            width: 25%;
        }

        #tablasDia th:nth-child(4),
        #tablasDia td:nth-child(4) {
            width: 25%;
        }

        .mensajeError {
            color: red;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        .mensajeExito {
            color: purple;
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 15px;
        }
    </style>
</head>
<body id="bodDoc">
<%@ include file="navDoctor.jsp" %>

<header class="nave">
    <img class="logo" src="imgs/image.png" alt="Logo">
    <h1>ClinicApp</h1>
</header>

<main id="genDoc2">

    <section>


        <p class="<%= claseMensaje %>">
            <%= mensaje %>
        </p>


        <table id="tablasDia">

            <thead>
                <tr>
                    <th>ID</th>
                    <th>Paciente</th>
                    <th>Fecha</th>
                    <th>Tipo</th>
                </tr>
            </thead>

            <tbody>

            <%
            if (rs != null) {

                while (rs.next()) {
            %>

                <tr>
                    <td><%= rs.getString("id_cita") %></td>
                    <td><%= rs.getString("paciente") %></td>
                    <td><%= rs.getString("fecha_hora") %></td>
                    <td><%= rs.getString("tipo") %></td>
                </tr>

            <%
                }
            }
            %>

            </tbody>

        </table>

        <br>

        <button
            type="button"
            onclick="location.href='docAppts.jsp'"
            class="boton"
            id="Regreso">

            Regresar

        </button>

    </section>

    <footer>
        <p>&copy; 2025 ClinicApp | Todos los derechos</p>
    </footer>

</main>

<%


    if (rs != null) rs.close();
    if (rsCheck != null) rsCheck.close();

    if (stInsert != null) stInsert.close();
    if (stSelect != null) stSelect.close();
    if (stCheck != null) stCheck.close();

    if (conecta != null) conecta.close();
%>

</body>
</html>
