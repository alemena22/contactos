package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Dao.ContactoDao;
import mx.edu.utez.contactos.model.structures.PilaEliminar;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "RestaurarContactoSv", value = "/restaurar-contacto")
public class RestaurarContactoSv extends HttpServlet {
    private final ContactoDao contactoDao = new ContactoDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        int idRestaurar = -1;

        if (idStr != null && !idStr.isEmpty()) {
            try {
                idRestaurar = Integer.parseInt(idStr);
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        } else {
            PilaEliminar pilaEliminados = contactoDao.getEliminadosPila();
            if (!pilaEliminados.isEmpty()) {
                idRestaurar = pilaEliminados.peek().getIdContacto();
            }
        }

        if (idRestaurar > 0) {
            boolean restaurado = contactoDao.restaurar(idRestaurar);
            if (restaurado) {
                String msg = URLEncoder.encode("Contacto restaurado correctamente.", StandardCharsets.UTF_8);
                resp.sendRedirect("index.jsp?exito=" + msg);
                return;
            }
        }
        resp.sendRedirect("index.jsp");
    }
}