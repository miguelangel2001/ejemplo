<!DOCTYPE html>
<html>
<head>
    <title>Registro de Trabajador</title>
</head>
<body>
    <h1>Registro de Trabajador</h1>
    <form action="guardarDatos.jsp" method="post">
        <label for="nombre">Nombre:</label>
        <input type="text" id="nombre" name="nombre" required>
        <br><br>
        <label for="apellido">Apellido:</label>
        <input type="text" id="apellido" name="apellido" required>
        <br><br>
        <label for="unidad">Unidad:</label>
        <input type="text" id="unidad" name="unidad" required>
        <br><br>
        <button type="submit">Guardar</button>
    </form>
</body>
</html>
