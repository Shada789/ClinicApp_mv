<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>

<html lang="es">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="clinic.css" type="text/css">
    <title>Busqueda de Insumos</title>
	<script src="https://kit.fontawesome.com/f8d03bf483.js" crossorigin="anonymous"></script>
</head>

<body id="bodDoc">
    <%@ include file="navDoctor.jsp" %>
	
	<header class="nave">
        <img class="logo" src="imgs/image.png" alt="Logo">
        <h1>Lista de Insumos</h1>
    </header>
	
    <main id="genDoc2">
	
        <section id="buscarTratamiento">
            <article>
                <h2>Buscar Insumo</h2>
                    <form action="insumosSearch2.jsp" method="post">
                        <input type="text" id="nombre" name="nombre" placeholder="Nombre de Insumo...">
                        <button type="submit" id="code">
							<i class="fa-solid fa-magnifying-glass"></i>
						</button>
                    </form>
            </article>
			<br>
            
			
            <table style="width: 100%;" id="tablasNoche">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Cantidad</th>
                    </tr>
					
					<%
					
					Connection conecta;
					PreparedStatement st;
					Class.forName("com.mysql.cj.jdbc.Driver");
					conecta= DriverManager.getConnection("jdbc:mysql://localhost:3306/chambs","root","n0m3l0");
					st = conecta.prepareStatement("SELECT * FROM insumo");
					
					ResultSet rs = st.executeQuery();
					while(rs.next()){
					int code = rs.getInt("id_insumo");
					%>	
					
					<tr>
						<td style="width: 70%;"><%=rs.getString("nombre")%></td>
						<td style="width: 30%;"><%=rs.getString("cantidad_actual")%></td>
						<td style="border:none;"></td>
					</tr>
					<%
					}
					%>
                </thead>
            </table>
		<br>
		<button type="button" onclick="location.href='insumos.jsp'" class="boton">Regresar</button>
        </section>
    </main>
</body>
</html>