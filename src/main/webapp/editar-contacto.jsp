<%--
  Created by IntelliJ IDEA.
  User: sheuko
  Date: 11/15/26
  Time: 8:22 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="mx.edu.utez.contactos.model.structures.nodos.NodoTelefono" %>

<c:if test="${not empty error}">
    <div id="alertaFlotante" data-tipo="error" data-mensaje="<c:out value='${error}' escapeXml='true' />"></div>
</c:if>

<section class="form-panel">
    <div class="form-wrapper">
        <div class="d-flex align-items-center mb-4">
            <button type="button" id="btnCancelarEdit" class="btn btn-link text-dark p-0 me-3 text-decoration-none fs-5">
                <i class="bi bi-arrow-left"></i>
            </button>
            <h1 class="form-title mb-0">Editar contacto</h1>
        </div>

        <form action="editar-contacto" method="POST" id="formContacto" autocomplete="off">
            <input type="hidden" name="idContacto" value="${contactoEdit.idContacto}">

            <div class="row g-3 mb-3">
                <div class="col-md-6">
                    <label for="apellidoPaterno" class="form-label-custom">Apellido Paterno</label>
                    <input type="text" id="apellidoPaterno" name="apellidoPaterno" class="input-custom" maxlength="30" value="<c:out value='${contactoEdit.apellidoPaterno}' escapeXml='true' />" required autofocus>
                </div>
                <div class="col-md-6">
                    <label for="apellidoMaterno" class="form-label-custom">Apellido Materno</label>
                    <input type="text" id="apellidoMaterno" name="apellidoMaterno" class="input-custom" maxlength="30" value="<c:out value='${contactoEdit.apellidoMaterno}' escapeXml='true' />">
                </div>
            </div>

            <div class="mb-3">
                <label for="nombre" class="form-label-custom">Nombre(s)</label>
                <input type="text" id="nombre" name="nombre" class="input-custom" maxlength="60" value="<c:out value='${contactoEdit.nombre}' escapeXml='true' />" required>
            </div>

            <div class="mb-2">
                <label for="telefono" class="form-label-custom">Teléfono</label>
                <input type="tel" id="telefono" name="telefono" class="input-custom" maxlength="20" pattern="[0-9+\-\s()]+" value="<c:out value='${contactoEdit.telefono}' escapeXml='true' />" required>
            </div>

            <div id="extraTelefonos">
                <%
                    mx.edu.utez.contactos.model.Contacto cEdit = (mx.edu.utez.contactos.model.Contacto) request.getAttribute("contactoEdit");
                    if (cEdit != null && cEdit.getTelefonosAlternos() != null) {
                        NodoTelefono nodo = cEdit.getTelefonosAlternos().getInicio();
                        while (nodo != null) {
                %>
                <div class="d-flex align-items-center gap-2 mb-2">
                    <input type="tel" name="telefonoAlterno" class="input-custom" placeholder="Teléfono alterno" maxlength="20" pattern="[0-9+\-\s()]+" value="<%= nodo.dato.getNumero() %>">
                    <button type="button" class="btn btn-sm btn-outline-danger rounded-circle" onclick="this.parentElement.remove()">×</button>
                </div>
                <%
                            nodo = nodo.siguiente;
                        }
                    }
                %>
            </div>

            <div class="mb-3">
                <button type="button" id="btnAgregarTel" class="btn-add-phone">
                    <i class="bi bi-plus"></i> Agregar otro numero
                </button>
            </div>

            <div class="mb-3">
                <label for="correo" class="form-label-custom">Correo Electrónico</label>
                <input type="email" id="correo" name="correo" class="input-custom" maxlength="120" value="<c:out value='${contactoEdit.correo}' escapeXml='true' />">
            </div>

            <div class="mb-4">
                <label for="grupo" class="form-label-custom">Grupo</label>
                <select id="grupo" name="idGrupo" class="input-custom select-custom text-capitalize" required>
                    <option value="" disabled>Selecciona un grupo</option>
                    <c:forEach var="g" items="${grupos}">
                        <option value="${g.idGrupo}" <c:if test="${g.idGrupo == contactoEdit.idGrupo}">selected</c:if>>
                            <c:out value="${g.nombre}" escapeXml="true" />
                        </option>
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
