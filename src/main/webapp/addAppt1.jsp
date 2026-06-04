<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<%
    Integer idMedico = (Integer) session.getAttribute("id_medico");
    if (idMedico == null) {
        response.sendRedirect("index.html");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<html lang="es">

    <head>

        <meta charset="UTF-8">
        <title>Agendar Cita</title>

        <link rel="stylesheet" href="clinictyle.css">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">
<script>
    window.onpageshow = function(e) {
        if (e.persisted) window.location.reload();
    };
</script>
        <style>
           
            
        </style>

    </head>

    <body id="bodDoc">
        <%@ include file="navDoctor.jsp" %>

        <header class="nave">
            <img class="logo" src="imgs/image.png" alt="Logo">
            <h1>Agendar Cita</h1>
        </header>

        <main id="genDoc2">
            <section>
                    <form id="formCita" action="addAppt.jsp" method="post">

                        <label>Paciente:</label>
                        <select  name="paciente" required>
                            <option value="">Seleccione un paciente</option>
                            <%
                                Connection con = null;
                                PreparedStatement psPac = null;
                                ResultSet rsPac = null;
                                
                                try{
                                    Class.forName("com.mysql.cj.jdbc.Driver");
                                    con = DriverManager.getConnection(
                                    "jdbc:mysql://127.0.0.1:3306/chambs?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true",
                                    "root", "n0m3l0"
                                    );
                                    
                                    psPac = con.prepareStatement(
                                    "SELECT p.id_paciente, u.nombre, u.paterno, u.materno " +
                                    "FROM paciente p " +
                                    "JOIN usuario u ON p.id_usuario = u.id_usuario " +
                                    "WHERE p.id_medico = ?"
                                    );
                                    psPac.setInt(1, idMedico);
                                    rsPac = psPac.executeQuery();
                                    while(rsPac.next()){
                                    %>
                                    <option value="<%= rsPac.getInt("id_paciente") %>">
                                        <%= rsPac.getString("nombre") %>
                                        <%= rsPac.getString("paterno") %>
                                        <%= rsPac.getString("materno") %>
                                    </option>

                                    <%
                                    }
                                }catch(Exception e){
                                    out.println("Error: " + e.getMessage());
                                }finally{
                                if(rsPac != null) rsPac.close();
                                if(psPac != null) psPac.close();
                            if(con != null) con.close();} %>
                        </select>

                        <label for="fecha">Fecha:</label>
                        <input type="date" name="fecha" required>

                        <label for="hora"> Hora:</label>
                        <input type="time"  name="hora" required>

                        <label for="tipo">Tipo:</label>
                        <select name="tipo" required>
                            <option value="">Selecciona tipo</option>
                            <option value="consulta">Consulta</option>
                            <option value="control">Control</option>
                            <option value="urgencia">Urgencia</option>
                        </select>


                        <textarea name="descripcion" rows="5" cols="40" placeholder="Escribe aquí la descripción"></textarea><br>
                        <br><button type="submit" class="botonImportante">
                            Agregar Cita
                        </button>
                    </form>
                    <button
                    type="button"
                    onclick="location.href='docAppts.jsp'"
                    class="boton">

                    Regresar
                </button>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos</p>
        </footer>
    </main>
</body>
</html>