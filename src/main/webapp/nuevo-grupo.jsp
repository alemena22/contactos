<%--
  Created by IntelliJ IDEA.
  User: sheuko
  Date: 11/15/26
  Time: 8:28 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty error}">
    <div id="alertaFlotante" data-tipo="error" data-mensaje="<c:out value='${error}' escapeXml='true' />"></div>
</c:if>

<section class="form-panel">
    <div class="form-wrapper">
        <div class="d-flex align-items-center mb-4">
            <button type="button" id="btnCancelarGrupo" class="btn btn-link text-dark p-0 me-3 text-decoration-none fs-5">
                <i class="bi bi-arrow-left"></i>
            </button>
            <h1 class="form-title mb-0">Nuevo Grupo</h1>
        </div>

        <form action="nuevo-grupo" method="POST" id="formGrupo" autocomplete="off">
            <div class="mb-4">
                <label for="nombreGrupo" class="form-label-custom">Nombre del Grupo</label>
                <input type="text" id="nombreGrupo" name="nombreGrupo" class="input-custom" maxlength="50" required autofocus>
            </div>

            <div class="d-flex align-items-center gap-3 mt-4">
                <button type="submit" class="btn-guardar">Guardar</button>
                <button type="button" id="btnCancelar" class="btn-cancelar d-inline-flex align-items-center text-decoration-none border-0">Cancelar</button>
            </div>
        </form>
    </div>
</section>
