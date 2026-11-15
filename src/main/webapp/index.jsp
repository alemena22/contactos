<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="mx.edu.utez.contactos.model.Dao.GrupoDao" %>
<%@ page import="mx.edu.utez.contactos.model.Dao.ContactoDao" %>
<%@ page import="mx.edu.utez.contactos.model.Contacto" %>
<%@ page import="mx.edu.utez.contactos.model.structures.ListaDoble" %>
<%@ page import="mx.edu.utez.contactos.model.structures.NodoDoble" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    GrupoDao grupoDao = new GrupoDao();
    ContactoDao contactoDao = new ContactoDao();

    ListaDoble listaDoble = contactoDao.getAllActivos();
    List<Contacto> contactos = new ArrayList<>();
    NodoDoble actual = listaDoble.getInicio();
    while (actual != null) {
        contactos.add(actual.dato);
        actual = actual.siguiente;
    }

    request.setAttribute("grupos", grupoDao.getAll());
    request.setAttribute("contactos", contactos);
    request.setAttribute("totalEliminados", contactoDao.contarEliminados());
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contactos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
</head>
<body>

<c:if test="${not empty param.exito}">
    <div id="alertaFlotante" data-tipo="exito" data-mensaje="<c:out value='${param.exito}' escapeXml='true' />"></div>
</c:if>

<div class="app-container">

    <aside class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=C&background=333&color=fff&rounded=true" alt="Logo" class="logo-img">
            <h4 class="logo-text">Contactos</h4>
        </div>

        <a href="nuevo-contacto" class="btn-nuevo-contacto text-decoration-none">
            <i class="bi bi-plus-lg"></i> Nuevo Contacto
        </a>

        <ul class="nav-list mt-3">
            <li class="nav-item active">
                <a href="index.jsp" class="d-flex justify-content-between align-items-center w-100 text-decoration-none text-reset">
                    <div class="nav-item-content">
                        <i class="bi bi-people fw-bold fs-5 me-3"></i>
                        <span class="fs-5">Todos</span>
                    </div>
                    <span class="count" id="countTodos">${fn:length(contactos)}</span>
                </a>
            </li>
            <li class="nav-item">
                <div class="nav-item-content">
                    <i class="bi bi-trash3 fs-5 me-3"></i>
                    <span class="fs-5">Eliminados</span>
                </div>
                <span class="count" id="countEliminados">${totalEliminados}</span>
            </li>
        </ul>

        <div class="grupos-section mt-4">
            <div class="grupos-header">
                <span class="grupos-title">Grupo</span>
                <i class="bi bi-plus text-muted fs-5" id="btnNuevoGrupo"></i>
            </div>
            <ul class="nav-list sub-list" id="listaGrupos">
                <c:forEach var="g" items="${grupos}">
                    <li class="nav-item">
                        <span><c:out value="${g.nombre}" escapeXml="true" /></span>
                        <span class="count text-muted">${g.totalContactos}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </aside>

    <main class="contacts-list-panel border-end border-start">
        <div class="p-4 pb-2">
            <h2 class="fw-normal mb-0" id="tituloLista">Todos los contactos</h2>
            <p class="text-muted small mb-3" id="subtituloLista">${fn:length(contactos)} contactos</p>

            <div class="search-bar mb-3">
                <i class="bi bi-search ms-3 text-muted"></i>
                <input type="text" id="buscar" maxlength="100" placeholder="Busca por nombre, teléfono o correo">
            </div>

            <div class="d-flex gap-2 mb-4">
                <button type="button" class="btn-filter outline">A-Z</button>
                <button type="button" class="btn-filter filled">Recientes</button>
            </div>
        </div>

        <div class="contacts-scroll px-4" id="listaContactos">
            <c:forEach var="c" items="${contactos}">
                <div class="contact-item">
                    <div class="avatar" style="background-color: #0d684c;">
                            ${fn:toUpperCase(fn:substring(c.nombre, 0, 1))}
                    </div>
                    <div class="contact-info">
                        <p class="name">
                            <c:out value="${c.nombre} ${c.apellidoPaterno} ${c.apellidoMaterno}" escapeXml="true" />
                        </p>
                        <p class="phone"><c:out value="${c.telefono}" escapeXml="true" /></p>
                    </div>
                </div>
            </c:forEach>
        </div>
    </main>

    <section class="empty-state-panel">
        <div class="text-center text-muted">
            <i class="bi bi-person empty-icon mb-2 d-block"></i>
            <h5 class="fw-normal empty-text">Seleccione un contacto para ver su información</h5>
        </div>
    </section>

</div>

<script src="${pageContext.request.contextPath}/assets/js/alertas.js"></script>
</body>
</html>