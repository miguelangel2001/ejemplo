<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DatabaseConnection"%>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            Connection conn = DatabaseConnection.getConnection();
            String sql = "SELECT * FROM usuarios WHERE username = ? AND password = MD5(?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                session.setAttribute("admin", username);
                response.sendRedirect("admin.jsp");
            } else {
                out.println("<p>Usuario o contraseña incorrectos</p>");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <h1>Login</h1>
    <form method="post">
        <label for="username">Usuario:</label>
        <input type="text" id="username" name="username" required>
        <br><br>
        <label for="password">Contraseña:</label>
        <input type="password" id="password" name="password" required>
        <br><br>
        <button type="submit">Iniciar Sesión</button>
    </form>
</body>
</html>
