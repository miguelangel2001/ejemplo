<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="db.DatabaseConnection"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Registro y Asistencias</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }
        table, th, td {
            border: 1px solid black;
        }
        th, td {
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h1>Registro de Asistencia</h1>

    <!-- Formulario para registrar datos -->
    <form method="POST" action="registro.jsp">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <br><br>
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required>
        <br><br>
        <label for="unidad">Unidad:</label>
        <input type="text" id="unidad" name="unidad" required>
        <br><br>
        <button type="submit">Registrar</button>
    </form>

    <hr>

    <!-- Código para registrar en la base de datos -->
    <%
        // Obtener los datos enviados desde el formulario
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String unidad = request.getParameter("unidad");

        if (nombre != null && apellido != null && unidad != null) {
            try {
                // Conexión a la base de datos
                Connection conn = DatabaseConnection.getConnection();

                // Consulta SQL para insertar los datos
                String sql = "INSERT INTO asistencia (nombre, apellido, unidad) VALUES (?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, nombre);
                stmt.setString(2, apellido);
                stmt.setString(3, unidad);

                // Ejecutar la consulta
                stmt.executeUpdate();
                conn.close();

                out.println("<p style='color: green;'>Registro guardado correctamente.</p>");
            } catch (Exception e) {
                out.println("<p style='color: red;'>Error al guardar los datos: " + e.getMessage() + "</p>");
                e.printStackTrace();
            }
        }
    %>

    <!-- Mostrar tabla con los registros -->
    <h2>Registros de Asistencia</h2>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>Nombre</th>
                <th>Apellido</th>
                <th>Unidad</th>
                <th>Hora</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    // Conexión a la base de datos
                    Connection conn = DatabaseConnection.getConnection();

                    // Consulta SQL para obtener todos los registros
                    String sql = "SELECT * FROM asistencia ORDER BY hora DESC";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    ResultSet rs = stmt.executeQuery();

                    // Mostrar cada registro en una fila
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
                    out.println("<p style='color: red;'>Error al cargar los registros: " + e.getMessage() + "</p>");
                    e.printStackTrace();
                }
            %>
        </tbody>
    </table>
</body>
</html>
