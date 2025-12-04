<%@ page import="java.sql.*" %>

<%
String idCliente = request.getParameter("idCliente");
String texto = request.getParameter("texto");

try{
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost/chambs", "root", "n0m3l0");

    // Verificar si el cliente ya tiene historial
    String sql = "SELECT id_historial FROM infoCliente WHERE id_cliente=?";
    PreparedStatement ps = c.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(idCliente));
    ResultSet rs = ps.executeQuery();

    if(rs.next()){
        // SI EXISTE → actualizar
        int idHist = rs.getInt("id_historial");

        String update = "UPDATE historial SET descripcion=? WHERE id_historial=?";
        PreparedStatement up = c.prepareStatement(update);
        up.setString(1, texto);
        up.setInt(2, idHist);
        up.executeUpdate();
        up.close();

    } else {
        // SI NO EXISTE → crear y vincular
        String insert = "INSERT INTO historial (descripcion) VALUES (?)";
        PreparedStatement ins = c.prepareStatement(insert, Statement.RETURN_GENERATED_KEYS);
        ins.setString(1, texto);
        ins.executeUpdate();

        ResultSet gen = ins.getGeneratedKeys();
        int nuevoHist = 0;
        if(gen.next()) nuevoHist = gen.getInt(1);

        gen.close();
        ins.close();

        // Vincular al cliente
        String vinc = "INSERT INTO infoCliente (id_medico, id_historial, id_cliente) VALUES (NULL, ?, ?)";
        PreparedStatement v = c.prepareStatement(vinc);
        v.setInt(1, nuevoHist);
        v.setInt(2, Integer.parseInt(idCliente));
        v.executeUpdate();
        v.close();
    }

    rs.close();
    ps.close();
    c.close();
}catch(Exception e){
    out.print("Error: " + e.getMessage());
    return;
}

out.print("OK");
%>