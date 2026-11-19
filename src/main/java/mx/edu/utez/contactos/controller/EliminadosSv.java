package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Dao.ContactoDao;
import mx.edu.utez.contactos.model.structures.PilaEliminar;

import java.io.IOException;

@WebServlet(name = "EliminadosSv", value = "/eliminados")
public class EliminadosSv extends HttpServlet {
    private final ContactoDao contactoDao = new ContactoDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        PilaEliminar pilaEliminados = contactoDao.getEliminadosPila();
        req.setAttribute("pilaEliminados", pilaEliminados);
        req.getRequestDispatcher("eliminados.jsp").forward(req, resp);
    }
}