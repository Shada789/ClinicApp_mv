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
            
            #formCita{
                display: flex;
                flex-direction: column;
                width: 400px;
                gap: 10px;
            }
            
            #formCita label,
            #formCita input,
            #formCita select,
            #formCita textarea{
                
                border: none;
                color: black;
                font-size: 16px;
                background-color: transparent;
                
            }
            
            #formCita textarea{
                border: 1px solid #ccc;
                padding: 10px;
                resize: none;
                height: 100px;
            }
            
            #formCita button{
                
                padding: 10px 20px;
                font-size: 18px;
                
            }
            
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
                <article>
                    <form id="formCita" action="addAppt.jsp" method="post">

                        <label for="paciente">Paciente:</label>
                        <select id="paciente" name="paciente" required>
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
                        </select><br>

                        <label for="fecha">Fecha de la cita:</label>
                        <input type="date" id="fecha" name="fecha" required><br>

                        <label for="hora"> Hora de la cita que desee:</label>
                        <input type="time" id="hora" name="hora" required><br>

                        <label for="tipo">Tipo de cita:</label>
                        <select id="tipo" name="tipo" required>
                            <option value="">Selecciona tipo</option>
                            <option value="consulta">Consulta</option>
                            <option value="control">Control</option>
                            <option value="urgencia">Urgencia</option>
                        </select><br>

                        <label for="descripcion">Descripción:</label>
                        <textarea
                        id="descripcion"
                        name="descripcion"
                        placeholder="Escribe aquí la descripción"
                        required></textarea>

                        <button type="submit" class="botonImportante">
                            Agregar Cita
                        </button>
                    </form><br>
                    <button
                    type="button"
                    onclick="location.href='docAppts.jsp'"
                    class="boton">

                    Regresar
                </button>
            </article>
        </section>
        <footer>
            <p>&copy; 2025 ClinicApp | Todos los derechos</p>
        </footer>
    </main>
</body>
</html>