<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinictyle.css" type="text/css">
    <title>Mi Historial</title>
</head>

<body id="bodDoc">

       <%@ include file="navDoctor.jsp" %>

<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">

        <h1>ClinicApp</h1>
    </header>
    <main id="genDoc2">
       
        <%
    Integer usuarioID = (Integer) session.getAttribute("usuario");

    String historialTexto = "Tu médico aún no agrega tu historial.";

    if (usuarioID != null) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/chambs",
                "root",
                "n0m3l0"
            );

            // Obtener el id_cliente del usuario
            PreparedStatement ps1 = con.prepareStatement(
                "SELECT id_cliente FROM cliente WHERE id_usuario = ?"
            );
            ps1.setInt(1, usuarioID);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                int idCliente = rs1.getInt("id_cliente");

                // Obtener el historial asociado
                PreparedStatement ps2 = con.prepareStatement(
                    "SELECT h.descripcion " +
                    "FROM historial h " +
                    "INNER JOIN infoCliente ic ON h.id_historial = ic.id_historial " +
                    "WHERE ic.id_cliente = ? LIMIT 1"
                );
                ps2.setInt(1, idCliente);
                ResultSet rs2 = ps2.executeQuery();

                if (rs2.next()) {
                    String desc = rs2.getString("descripcion");
                    if (desc != null && !desc.trim().isEmpty()) {
                        historialTexto = desc.replace("\n", "<br>");
                    }
                }

                rs2.close();
                ps2.close();
            }

            rs1.close();
            ps1.close();
            con.close();

        } catch (Exception e) {
            historialTexto = "Error al cargar historial: " + e.getMessage();
        }
    }
%>

<section>
    <h1>Mi Historial</h1>
    <article id="historialPaciente" style="
        background:white;
        padding:20px;
        border-radius:14px;
        box-shadow:0 0 10px rgba(0,0,0,0.1);
        font-size:18px;
        line-height:1.5;
    ">
        <%= historialTexto %>
    </article>
</section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos reservados</p>
        </footer>
    </main>


</body>

</html>