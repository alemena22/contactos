<%--
  Created by IntelliJ IDEA.
  User: sheuko
  Date: 11/15/26
  Time: 7:54 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="mx.edu.utez.contactos.model.structures.nodos.NodoTelefono" %>

<div class="detalle-panel">
    <c:choose>
        <c:when test="${not empty contactoDetalle}">
            <!-- Botones superiores Editar / Eliminar -->
            <div class="d-flex justify-content-end gap-3 mb-4 px-4 pt-4">
                <button type="button" id="btnEditarContacto" data-id="${contactoDetalle.idContacto}" class="btn btn-link text-decoration-none text-dark p-0 small fw-medium">
                    <i class="bi bi-pencil me-1 text-success"></i> Editar
                </button>
                <form action="eliminar-contacto" method="POST" class="d-inline m-0">
                    <input type="hidden" name="id" value="${contactoDetalle.idContacto}">
                    <button type="submit" class="btn btn-link text-decoration-none text-danger p-0 small fw-medium border-0 bg-transparent">
                        <i class="bi bi-trash me-1"></i> Eliminar
                    </button>
                </form>
            </div>

            <div class="text-center px-4">
                <div class="avatar-lg mx-auto mb-3" style="background-color: #d1efe6; color: #0d684c;">
                        ${fn:toUpperCase(fn:substring(contactoDetalle.nombre, 0, 1))}${fn:toUpperCase(fn:substring(contactoDetalle.apellidoPaterno, 0, 1))}
                </div>

                <h3 class="fw-normal mb-1 text-dark">
                    <c:out value="${contactoDetalle.nombre} ${contactoDetalle.apellidoPaterno} ${contactoDetalle.apellidoMaterno}" escapeXml="true" />
                </h3>

                <c:if test="${not empty nombreGrupo}">
                    <span class="badge bg-light text-secondary border px-3 py-1 rounded-pill small text-capitalize mb-4">
                        <c:out value="${nombreGrupo}" escapeXml="true" />
                    </span>
                </c:if>

                <div class="d-flex justify-content-center gap-3 mb-4">
                    <a href="tel:${contactoDetalle.telefono}" class="btn-action-card">
                        <i class="bi bi-telephone fs-5 text-success"></i>
                        <span>Llamar</span>
                    </a>
                    <c:if test="${not empty contactoDetalle.correo}">
                        <a href="mailto:${contactoDetalle.correo}" class="btn-action-card">
                            <i class="bi bi-envelope fs-5 text-success"></i>
                            <span>Correo</span>
                        </a>
                    </c:if>
                </div>

                <div class="card border-0 shadow-sm mx-auto text-start mb-3" style="max-width: 500px; border-radius: 12px;">
                    <div class="card-body py-2 px-3">
                        <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                            <div>
                                <span class="d-block text-muted small" style="font-size: 11px;">Principal</span>
                                <span class="text-dark fw-medium"><c:out value="${contactoDetalle.telefono}" escapeXml="true" /></span>
                            </div>
                            <i class="bi bi-telephone text-muted"></i>
                        </div>

                        <%
                            mx.edu.utez.contactos.model.Contacto cDetalle = (mx.edu.utez.contactos.model.Contacto) request.getAttribute("contactoDetalle");
                            if (cDetalle != null && cDetalle.getTelefonosAlternos() != null) {
                                NodoTelefono nodoTel = cDetalle.getTelefonosAlternos().getInicio();
                                while (nodoTel != null) {
                        %>
                        <div class="d-flex justify-content-between align-items-center py-2 border-bottom">
                            <div>
                                <span class="d-block text-muted small" style="font-size: 11px;">Alterno</span>
                                <span class="text-dark fw-medium"><%= nodoTel.dato.getNumero() %></span>
                            </div>
                            <i class="bi bi-telephone text-muted"></i>
                        </div>
                        <%
                                    nodoTel = nodoTel.siguiente;
                                }
                            }
                        %>

                        <c:if test="${not empty contactoDetalle.correo}">
                            <div class="d-flex justify-content-between align-items-center py-2">
                                <div>
                                    <span class="d-block text-muted small" style="font-size: 11px;">Correo</span>
                                    <span class="text-success fw-medium"><c:out value="${contactoDetalle.correo}" escapeXml="true" /></span>
                                </div>
                                <i class="bi bi-envelope text-muted"></i>
                            </div>
                        </c:if>
                    </div>
                </div>

                <c:if test="${not empty contactoDetalle.fechaAlta}">
                    <p class="text-muted small mt-4" style="font-size: 12px;">
                        Agregado el ${fn:substring(contactoDetalle.fechaAlta, 8, 10)}/${fn:substring(contactoDetalle.fechaAlta, 5, 7)}/${fn:substring(contactoDetalle.fechaAlta, 0, 4)}
                    </p>
                </c:if>
            </div>
        </c:when>
        <c:otherwise>
            <div class="text-center text-muted m-auto">
                <i class="bi bi-exclamation-circle empty-icon mb-2 d-block"></i>
                <h5 class="fw-normal empty-text">No se encontró información del contacto</h5>
            </div>
        </c:otherwise>
    </c:choose>
</div>