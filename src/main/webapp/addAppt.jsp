<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>


<%
String idPaciente = request.getParameter("paciente");
String fecha = request.getParameter("fecha");
String hora = request.getParameter("hora");
String descripcion = request.getParameter("descripcion");
String tipo = request.getParameter("tipo");
Integer id_medico = (Integer) session.getAttribute("id_medico");
if (id_medico == null) {
    response.sendRedirect("login.jsp");
    return;
}
int id_medico = id_medico;

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
        "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
        "root",
        "n0m3l0"
    );

    // Validar si ya existe cita en esa fecha/hora para ese médico
    stCheck = conecta.prepareStatement(
        "SELECT COUNT(*) FROM cita WHERE id_medico = ? AND fecha_hora = ?"
        );
        stCheck.setInt(1, id_medico);
        stCheck.setString(2, fecha_hora);

    rsCheck = stCheck.executeQuery();
    boolean existe = false;
    if (rsCheck.next()) {
        existe = rsCheck.getInt(1) > 0;
    }
    

    if (existe) {
        mensaje = "Ya existe una cita en esa fecha y hora.";
        claseMensaje = "mensajeError";
    } else {

        stInsert = conecta.prepareStatement(
    "INSERT INTO cita (id_medico, id_paciente, fecha_hora, notas, tipo) VALUES (?,?,?,?,?)"
        );
        stInsert.setInt(1, id_medico);
        stInsert.setInt(2, Integer.parseInt(idPaciente));
        stInsert.setString(3, fecha_hora);
        stInsert.setString(4, descripcion);
        stInsert.setString(5, tipo);
        stInsert.executeUpdate();

        mensaje = "Cita agregada correctamente.";
        claseMensaje = "mensajeExito";
    }

    stSelect = conecta.prepareStatement(
    "SELECT c.id_cita, u.nombre AS paciente, c.fecha_hora, c.notas, c.tipo " +
    "FROM cita c " +
    "JOIN paciente p ON c.id_paciente = p.id_paciente " +
    "JOIN usuario u ON p.id_usuario = u.id_usuario " +
    "WHERE c.id_medico = ? " +
    "ORDER BY c.fecha_hora"
);
stSelect.setInt(1, id_medico);
rs = stSelect.executeQuery();

} catch (Exception e) {
    mensaje = "Error: " + e.getMessage();
    claseMensaje = "mensajeError";
}
%>


<p class="<%= claseMensaje %>"><%= mensaje %></p>

<table id="tablasDia">
    <thead>
        <tr>
            <th>ID</th>
            <th>Paciente</th>
            <th>Fecha</th>
            <th>Descripción</th>
            <th>Tipo</th>
        </tr>
    </thead>
    <tbody>
        <%
        if (rs != null) {
            while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id_cita") %></td>
            <td><%= rs.getString("paciente") %></td>
            <td><%= rs.getString("fecha_hora") %></td>
            <td><%= rs.getString("notas") %></td>
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
            onclick="location.href='addAppt.html'"
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
