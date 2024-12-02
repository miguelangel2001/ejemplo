<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="com.google.zxing.BarcodeFormat"%>
<%@page import="com.google.zxing.qrcode.QRCodeWriter"%>
<%@page import="com.google.zxing.common.BitMatrix"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>

<%
    // URL o datos que quieres codificar
    String data = "http://localhost:8080/miProyecto/registro.jsp";

    // Tama�o del c�digo QR
    int size = 250;

    // Ruta para guardar el QR temporalmente
    String qrPath = application.getRealPath("/") + "qrCode.png";

    try {
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(data, BarcodeFormat.QR_CODE, size, size);

        // Crear imagen en memoria
        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < size; x++) {
            for (int y = 0; y < size; y++) {
                image.setRGB(x, y, (bitMatrix.get(x, y) ? 0x000000 : 0xFFFFFF));
            }
        }

        // Guardar la imagen como un archivo temporal
        File qrFile = new File(qrPath);
        ImageIO.write(image, "png", qrFile);

        // Mostrar la imagen en la p�gina
        out.println("<h1>C�digo QR Generado</h1>");
        out.println("<p>Escanea este c�digo con tu dispositivo m�vil:</p>");
        out.println("<img src='qrCode.png' alt='C�digo QR' />");
    } catch (Exception e) {
        out.println("<p>Error al generar el c�digo QR: " + e.getMessage() + "</p>");
        e.printStackTrace();
    }
%>
