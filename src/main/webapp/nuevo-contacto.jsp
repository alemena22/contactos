<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nuevo Contacto</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/index.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nuevo-contacto.css">
</head>
<body>

<c:if test="${not empty error}">
    <div id="alertaFlotante" data-tipo="error" data-mensaje="<c:out value='${error}' escapeXml='true' />"></div>
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
            <li class="nav-item">
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

    <section class="form-panel">
        <div class="form-wrapper">
            <h1 class="form-title">Nuevo Contacto</h1>

            <form action="nuevo-contacto" method="POST" id="formContacto" autocomplete="off">
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label for="apellidoPaterno" class="form-label-custom">Apellido Paterno</label>
                        <input type="text" id="apellidoPaterno" name="apellidoPaterno" class="input-custom" maxlength="30" required autofocus>
                    </div>
                    <div class="col-md-6">
                        <label for="apellidoMaterno" class="form-label-custom">Apellido Materno</label>
                        <input type="text" id="apellidoMaterno" name="apellidoMaterno" class="input-custom" maxlength="30">
                    </div>
                </div>

                <div class="mb-3">
                    <label for="nombre" class="form-label-custom">Nombre(s)</label>
                    <input type="text" id="nombre" name="nombre" class="input-custom" maxlength="60" required>
                </div>

                <div class="mb-2">
                    <label for="telefono" class="form-label-custom">Teléfono</label>
                    <input type="tel" id="telefono" name="telefono" class="input-custom" maxlength="20" pattern="[0-9+\-\s()]+" required>
                </div>

                <div id="extraTelefonos"></div>

                <div class="mb-3">
                    <button type="button" id="btnAgregarTel" class="btn-add-phone">
                        <i class="bi bi-plus"></i> Agregar otro numero
                    </button>
                </div>

                <div class="mb-3">
                    <label for="correo" class="form-label-custom">Correo Electrónico</label>
                    <input type="email" id="correo" name="correo" class="input-custom" maxlength="120">
                </div>

                <div class="mb-4">
                    <label for="grupo" class="form-label-custom">Grupo</label>
                    <select id="grupo" name="idGrupo" class="input-custom select-custom text-capitalize" required>
                        <option value="" selected disabled>Selecciona un grupo</option>
                        <c:forEach var="g" items="${grupos}">
                            <option value="${g.idGrupo}"><c:out value="${g.nombre}" escapeXml="true" /></option>
                        </c:forEach>
                    </select>
                </div>

                <div class="d-flex align-items-center gap-3 mt-4">
                    <button type="submit" class="btn-guardar">Guardar</button>
                    <a href="index.jsp" class="btn-cancelar d-inline-flex align-items-center text-decoration-none">Cancelar</a>
                </div>
            </form>
        </div>
    </section>

</div>

<script src="${pageContext.request.contextPath}/assets/js/alertas.js"></script>
<script src="${pageContext.request.contextPath}/assets/js/nuevo-contacto.js"></script>
</body>
</html>