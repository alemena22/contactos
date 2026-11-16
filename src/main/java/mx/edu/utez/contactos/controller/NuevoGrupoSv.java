package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Dao.GrupoDao;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet(name = "NuevoGrupoSv", value = "/nuevo-grupo")
public class NuevoGrupoSv extends HttpServlet {

    private GrupoDao grupoDao = new GrupoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("nuevo-grupo.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String nombre = req.getParameter("nombreGrupo");

        if (nombre == null || nombre.trim().isEmpty()) {
            req.setAttribute("error", "El nombre del grupo no puede estar vacío.");
            req.getRequestDispatcher("nuevo-grupo.jsp").forward(req, resp);
            return;
        }

        String nombreLimpio = nombre.trim();
        if (nombreLimpio.length() > 50) {
            req.setAttribute("error", "El nombre del grupo es demasiado largo (máximo 50 caracteres).");
            req.getRequestDispatcher("nuevo-grupo.jsp").forward(req, resp);
            return;
        }

        if (grupoDao.existeNombre(nombreLimpio)) {
            req.setAttribute("error", "Ya existe un grupo con ese nombre.");
            req.getRequestDispatcher("nuevo-grupo.jsp").forward(req, resp);
            return;
        }

        boolean creado = grupoDao.create(nombreLimpio);
        if (creado) {
            String msg = URLEncoder.encode("Grupo creado correctamente.", StandardCharsets.UTF_8);
            resp.sendRedirect("index.jsp?exito=" + msg);
        } else {
            req.setAttribute("error", "No se pudo crear el grupo.");
            req.getRequestDispatcher("nuevo-grupo.jsp").forward(req, resp);
        }
    }
}