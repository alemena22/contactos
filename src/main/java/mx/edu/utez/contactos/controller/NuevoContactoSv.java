package mx.edu.utez.contactos.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.contactos.model.Contacto;
import mx.edu.utez.contactos.model.Dao.ContactoDao;
import mx.edu.utez.contactos.model.Dao.GrupoDao;
import mx.edu.utez.contactos.model.structures.ListaDoble;
import mx.edu.utez.contactos.model.structures.NodoDoble;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@WebServlet(name = "NuevoContactoSv", value = "/nuevo-contacto")
public class NuevoContactoSv extends HttpServlet {

    private GrupoDao grupoDao = new GrupoDao();
    private ContactoDao contactoDao = new ContactoDao();

    private void cargarDatosVista(HttpServletRequest req) {
        req.setAttribute("grupos", grupoDao.getAll());

        ListaDoble listaDoble = contactoDao.getAllActivos();
        List<Contacto> contactos = new ArrayList<>();
        NodoDoble actual = listaDoble.getInicio();
        while (actual != null) {
            contactos.add(actual.dato);
            actual = actual.siguiente;
        }

        req.setAttribute("contactos", contactos);
        req.setAttribute("totalEliminados", contactoDao.contarEliminados());
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        cargarDatosVista(req);
        req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String apellidoPaterno = req.getParameter("apellidoPaterno");
        String apellidoMaterno = req.getParameter("apellidoMaterno");
        String nombre = req.getParameter("nombre");
        String telefono = req.getParameter("telefono");
        String correo = req.getParameter("correo");
        String idGrupoStr = req.getParameter("idGrupo");
        String[] telefonosAlternos = req.getParameterValues("telefonoAlterno");

        if (nombre == null || nombre.trim().isEmpty() ||
                apellidoPaterno == null || apellidoPaterno.trim().isEmpty() ||
                telefono == null || telefono.trim().isEmpty() ||
                idGrupoStr == null || idGrupoStr.trim().isEmpty()) {

            req.setAttribute("error", "Faltan campos obligatorios por llenar.");
            cargarDatosVista(req);
            req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
            return;
        }

        String telLimpio = telefono.trim();
        if (telLimpio.length() > 20 || !telLimpio.matches("[0-9+\\-\\s()]+")) {
            req.setAttribute("error", "El formato del telefono no es valido.");
            cargarDatosVista(req);
            req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
            return;
        }

        if (contactoDao.telefonoExistente(telLimpio)) {
            req.setAttribute("error", "Ese telefono ya esta registrado.");
            cargarDatosVista(req);
            req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
            return;
        }

        String correoLimpio = correo != null ? correo.trim() : "";
        if (!correoLimpio.isEmpty()) {
            if (correoLimpio.length() > 120 || !correoLimpio.matches("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$")) {
                req.setAttribute("error", "El correo electronico no es valido.");
                cargarDatosVista(req);
                req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
                return;
            }
            if (contactoDao.correoExistente(correoLimpio)) {
                req.setAttribute("error", "Ese correo ya esta registrado.");
                cargarDatosVista(req);
                req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
                return;
            }
        }

        int idGrupo;
        try {
            idGrupo = Integer.parseInt(idGrupoStr.trim());
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Selecciona un grupo valido.");
            cargarDatosVista(req);
            req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
            return;
        }

        Contacto contacto = new Contacto();
        contacto.setNombre(nombre.trim());
        contacto.setApellidoPaterno(apellidoPaterno.trim());
        contacto.setApellidoMaterno(apellidoMaterno != null ? apellidoMaterno.trim() : "");
        contacto.setTelefono(telLimpio);
        contacto.setCorreo(correoLimpio);
        contacto.setIdGrupo(idGrupo);

        if (telefonosAlternos != null) {
            Set<String> numerosRegistrados = new HashSet<>();
            numerosRegistrados.add(telLimpio);

            for (int i = 0; i < telefonosAlternos.length; i++) {
                if (telefonosAlternos[i] != null && !telefonosAlternos[i].trim().isEmpty()) {
                    String alt = telefonosAlternos[i].trim();
                    if (alt.length() > 20 || !alt.matches("[0-9+\\-\\s()]+")) {
                        req.setAttribute("error", "Uno de los telefonos alternos no es valido.");
                        cargarDatosVista(req);
                        req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
                        return;
                    }
                    if (!numerosRegistrados.add(alt)) {
                        req.setAttribute("error", "No repitas el mismo numero en los telefonos alternos.");
                        cargarDatosVista(req);
                        req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
                        return;
                    }
                    contacto.agregarTelefonoAlterno(alt);
                }
            }
        }

        int id = contactoDao.create(contacto);

        if (id > 0) {
            String msg = URLEncoder.encode("Contacto guardado correctamente.", StandardCharsets.UTF_8);
            resp.sendRedirect("index.jsp?exito=" + msg);
        } else {
            req.setAttribute("error", "No se pudo guardar el contacto.");
            cargarDatosVista(req);
            req.getRequestDispatcher("nuevo-contacto.jsp").forward(req, resp);
        }
    }
}