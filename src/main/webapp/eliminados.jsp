<%--
  Created by IntelliJ IDEA.
  User: sheuko
  Date: 11/18/26
  Time: 11:31 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="mx.edu.utez.contactos.model.structures.PilaEliminar" %>
<%@ page import="mx.edu.utez.contactos.model.structures.nodos.NodoPila" %>
<%@ page import="mx.edu.utez.contactos.model.Contacto" %>
<%@ page import="mx.edu.utez.contactos.model.structures.nodos.NodoPila" %>
<%@ page import="mx.edu.utez.contactos.model.structures.PilaEliminar" %>

<div class="detalle-panel p-4">
    <div class="mb-4">
        <h3 class="fw-normal text-dark mb-1">Eliminados recientemente</h3>
        <p class="text-muted small">Se restauran del más reciente al más antiguo</p>
    </div>

    <%
        PilaEliminar pila = (PilaEliminar) request.getAttribute("pilaEliminados");
        if (pila != null && !pila.isEmpty()) {
            Contacto ultimoEliminado = pila.peek();
    %>
    <div class="card border rounded-4 p-3 mb-4 shadow-sm bg-white" style="border-color: #e0e0e0 !important;">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <span class="d-block text-muted small mb-1">Puedes recuperar el último que eliminaste:</span>
                <span class="text-dark fw-bold fs-6"><%= ultimoEliminado.getNombre() %> <%= ultimoEliminado.getApellidoPaterno() %></span>
            </div>
            <form action="restaurar-contacto" method="POST" class="m-0">
                <input type="hidden" name="id" value="<%= ultimoEliminado.getIdContacto() %>">
                <button type="submit" class="btn btn-outline-secondary rounded-pill px-3 py-1 small d-flex align-items-center gap-2">
                    <i class="bi bi-arrow-counterclockwise"></i> Restaurar
                </button>
            </form>
        </div>
    </div>

    <!-- Lista de eliminados -->
    <div class="d-flex flex-column gap-2">
        <%
            NodoPila actual = pila.getCima();
            boolean esPrimero = true;
            while (actual != null) {
                Contacto c = actual.dato;
                String iniciales = ((c.getNombre() != null && !c.getNombre().isEmpty()) ? c.getNombre().substring(0,1) : "") +
                        ((c.getApellidoPaterno() != null && !c.getApellidoPaterno().isEmpty()) ? c.getApellidoPaterno().substring(0,1) : "");
                iniciales = iniciales.toUpperCase();
                if (iniciales.isEmpty()) iniciales = "C";
        %>
        <div class="d-flex align-items-center justify-content-between p-2 rounded-3">
            <div class="d-flex align-items-center gap-3">
                <div class="avatar" style="background-color: #d1efe6; color: #0d684c; width: 38px; height: 38px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 500; font-size: 13px;">
                    <%= iniciales %>
                </div>
                <div>
                    <span class="d-block text-dark fw-medium" style="font-size: 14px;"><%= c.getNombre() %> <%= c.getApellidoPaterno() %> <%= c.getApellidoMaterno() != null ? c.getApellidoMaterno() : "" %></span>
                </div>
            </div>
            <% if (esPrimero) { %>
            <span class="text-muted small" style="font-size: 12px;">Más reciente</span>
            <% } %>
        </div>
        <%
                esPrimero = false;
                actual = actual.siguiente;
            }
        %>
    </div>
    <% } else { %>
    <div class="text-center text-muted m-auto py-5">
        <i class="bi bi-trash3 empty-icon mb-2 d-block" style="font-size: 50px;"></i>
        <h5 class="fw-normal empty-text">No hay contactos eliminados</h5>
    </div>
    <% } %>
</div>