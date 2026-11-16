package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.Dao.ContactoDao;
import mx.edu.utez.contactos.model.Dao.GrupoDao;
import mx.edu.utez.contactos.model.Grupo;

import java.io.IOException;

@WebServlet(name = "DetalleContactoSv", value = "/detalle-contacto")
public class DetalleContactoSv extends HttpServlet {

    private ContactoDao contactoDao = new ContactoDao();
    private GrupoDao grupoDao = new GrupoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                int id = Integer.parseInt(idStr);
                Contacto contacto = contactoDao.getById(id);
                if (contacto != null) {
                    req.setAttribute("contactoDetalle", contacto);

                    // Buscar el nombre del grupo correspondiente
                    for (Grupo g : grupoDao.getAll()) {
                        if (g.getIdGrupo() == contacto.getIdGrupo()) {
                            req.setAttribute("nombreGrupo", g.getNombre());
                            break;
                        }
                    }
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
            }
        }
        req.getRequestDispatcher("detalle-contacto.jsp").forward(req, resp);
    }
}