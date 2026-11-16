<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty error}">
    <div id="alertaFlotante" data-tipo="error" data-mensaje="<c:out value='${error}' escapeXml='true' />"></div>
</c:if>

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
                <button type="button" id="btnCancelar" class="btn-cancelar d-inline-flex align-items-center text-decoration-none border-0">Cancelar</button>
            </div>
        </form>
    </div>
</section>