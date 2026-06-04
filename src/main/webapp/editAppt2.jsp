<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
    String id = request.getParameter("id_cita");
    String paciente = "";
    String fecha = "";
    String hora = "";
    String descripcion = "";
    String tipo = "";
    Connection con = null;
    PreparedStatement st = null;
    ResultSet rs = null;
    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/chambs?useSSL=false&serverTimezone=UTC",
            "root",
            "n0m3l0"
        );
        st = con.prepareStatement(
            "SELECT c.id_cita, u.nombre AS paciente, " +
            "c.fecha_hora, c.notas, c.tipo " +
            "FROM cita c " +
            "JOIN paciente p ON c.id_paciente = p.id_paciente " +
            "JOIN usuario u ON p.id_usuario = u.id_usuario " +
            "WHERE c.id_cita = ?"
        );
        st.setInt(1, Integer.parseInt(id));
        rs = st.executeQuery();
        if(rs.next()){
            paciente = rs.getString("paciente");
            descripcion = rs.getString("notas");
            tipo = rs.getString("tipo");

            String fechaHora = rs.getString("fecha_hora");

            fecha = fechaHora.substring(0,10);
            hora = fechaHora.substring(11,16);
        }
    }catch(Exception e){
        out.println("Error: " + e.getMessage());
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>Modificar Cita</title>
        <link rel="stylesheet" href="clinictyle.css">
    </head>
    <body id="bodDoc">
    <%@ include file="navDoctor.jsp" %>
        <header class="nave">
            <img class="logo" src="imgs/image.png" alt="Logo">
            <h1>Modificar Cita</h1>
        </header>
        <main id="genDoc2">
            <section>
                <form action="editAppt3.jsp" method="post" id="formCita">

                    <input type="hidden" name="id_cita" value="<%= id %>">

                    <label>ID:</label>
                    <input type="text" value="<%= id %>" readonly>

                    <label>Paciente:</label>
                    <input type="text" value="<%= paciente %>" readonly>

                    <label>Fecha:</label>
                    <input type="date" name="fecha" value="<%= fecha %>" required>

                    <label>Hora:</label>
                    <input type="time"name="hora" value="<%= hora %>" required>

                    <label>Tipo:</label>
                    <select name="tipo" required>
                        <option value="consulta"
                        <%= "consulta".equals(tipo) ? "selected" : "" %>>
                            Consulta
                        </option>
                        <option value="control"
                        <%= "control".equals(tipo) ? "selected" : "" %>>
                            Control
                        </option>
                        <option value="urgencia"
                        <%= "urgencia".equals(tipo) ? "selected" : "" %>>
                            Urgencia
                        </option>
                    </select>

                    <label>Descripción:</label>
                    <textarea name="descripcion" rows="5" cols="40"><%= descripcion %></textarea>
                    <br>

                    <button type="submit" class="botonImportante">
                        Guardar Cambios
                    </button>

                </form> <br>

            <button type="button" class="boton" onclick="location.href='editAppt.jsp'"> Regresar </button>
            </section>
        </main>
    </body>
</html>

<%
if(rs != null) rs.close();
if(st != null) st.close();
if(con != null) con.close();
%>