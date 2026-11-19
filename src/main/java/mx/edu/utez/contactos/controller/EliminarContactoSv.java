package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.Dao.ContactoDao;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "EliminarContactoSv", value = "/eliminar-contacto")
public class EliminarContactoSv extends HttpServlet {
    private ContactoDao contactoDao = new ContactoDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Contacto c = contactoDao.getById(id);
                boolean eliminado = contactoDao.eliminar(id);
                if (eliminado && c != null) {
                    String nombreCompleto = c.getNombre() + " " + c.getApellidoPaterno();
                    String msg = URLEncoder.encode("Se eliminó a " + nombreCompleto, StandardCharsets.UTF_8);
                    resp.sendRedirect("index.jsp?eliminadoId=" + id + "&exito=" + msg);
                    return;
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        resp.sendRedirect("index.jsp");
    }
}