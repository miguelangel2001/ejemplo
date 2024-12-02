<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DatabaseConnection"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Administración de Asistencias</title>
</head>
<body>
    <h1>Administración de Asistencias</h1>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Unidad</th>
            <th>Hora</th>
        </tr>
        <%
            try {
                Connection conn = DatabaseConnection.getConnection();
                String sql = "SELECT * FROM asistencia";
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery();

                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("nombre") %></td>
            <td><%= rs.getString("apellido") %></td>
            <td><%= rs.getString("unidad") %></td>
            <td><%= rs.getTimestamp("hora") %></td>
        </tr>
        <%
                }
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>
</body>
</html>
