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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/nuevo-contacto.css">
</head>
<body>

<!-- Mensaje de éxito que llega por ?exito=... tras guardar/actualizar -->
<c:if test="${not empty param.exito}">
    <div id="alertaFlotante" data-tipo="exito" data-mensaje="<c:out value='${param.exito}' escapeXml='true' />"></div>
</c:if>

<div class="app-container">

    <!-- BARRA LATERAL FIJA -->
    <aside class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=C&background=333&color=fff&rounded=true" alt="Logo" class="logo-img">
            <h4 class="logo-text">Contactos</h4>
        </div>

        <a href="#" id="btnAbrirNuevo" class="btn-nuevo-contacto text-decoration-none">
            <i class="bi bi-plus-lg"></i> Nuevo Contacto
        </a>

        <ul class="nav-list mt-3">
            <li class="nav-item active" id="navTodos">
                <a href="#" class="d-flex justify-content-between align-items-center w-100 text-decoration-none text-reset">
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
                <i class="bi bi-plus text-muted fs-5" id="btnNuevoGrupo" title="Nuevo Grupo"></i>
            </div>
            <ul class="nav-list sub-list" id="listaGrupos">
                <c:forEach var="g" items="${grupos}">
                    <li class="nav-item grupo-item" data-id-grupo="${g.idGrupo}" data-nombre-grupo="${fn:escapeXml(g.nombre)}">
                        <span><c:out value="${g.nombre}" escapeXml="true" /></span>
                        <span class="count text-muted">${g.totalContactos}</span>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </aside>

    <!-- PANEL CENTRAL DE LISTA DE CONTACTOS -->
    <main class="contacts-list-panel border-end border-start">
        <div class="p-4 pb-2">
            <h2 class="fw-normal mb-0" id="tituloLista">Todos los contactos</h2>
            <p class="text-muted small mb-3" id="subtituloLista">${fn:length(contactos)} contactos</p>

            <div class="search-bar mb-3">
                <i class="bi bi-search ms-3 text-muted"></i>
                <input type="text" id="buscar" maxlength="100" placeholder="Busca por nombre, teléfono o correo">
            </div>

            <!-- Botones de filtro A-Z y Recientes -->
            <div class="d-flex gap-2 mb-4">
                <button type="button" id="btnFiltroAZ" class="btn-filter filled">A-Z</button>
                <button type="button" id="btnFiltroRecientes" class="btn-filter outline">Recientes</button>
            </div>
        </div>

        <!-- Contenedor con scroll y barra lateral A-Z integrada -->
        <div class="contacts-list-container-wrapper">
            <div class="contacts-scroll px-4 pb-4" id="listaContactos">
                <!-- Renderizado inicial seguro mediante JSTL con atributos de datos -->
                <c:forEach var="c" items="${contactos}">
                    <div class="contact-item"
                         data-id="${c.idContacto}"
                         data-nombre="<c:out value='${c.nombre}' escapeXml='true' />"
                         data-apellido-paterno="<c:out value='${c.apellidoPaterno}' escapeXml='true' />"
                         data-apellido-materno="<c:out value='${c.apellidoMaterno}' escapeXml='true' />"
                         data-telefono="<c:out value='${c.telefono}' escapeXml='true' />"
                         data-id-grupo="${c.idGrupo}"
                         data-fecha-alta="${c.fechaAlta}">
                        <div class="avatar" style="background-color: #0d684c; font-size: 13px;">
                                ${fn:toUpperCase(fn:substring(c.nombre, 0, 1))}${fn:toUpperCase(fn:substring(c.apellidoPaterno, 0, 1))}
                        </div>
                        <div class="contact-info">
                            <p class="name"><c:out value="${c.nombre} ${c.apellidoPaterno} ${c.apellidoMaterno}" escapeXml="true" /></p>
                            <p class="phone"><c:out value="${c.telefono}" escapeXml="true" /></p>
                        </div>
                    </div>
                </c:forEach>
            </div>

            <!-- Barra lateral alfabética -->
            <div class="alphabet-sidebar" id="alphabetSidebar">
                <!-- Se genera dinámicamente con JS -->
            </div>
        </div>
    </main>

    <!-- PANEL DERECHO DINÁMICO -->
    <section id="panelContenido" class="empty-state-panel">
        <div class="text-center text-muted">
            <i class="bi bi-person empty-icon mb-2 d-block"></i>
            <h5 class="fw-normal empty-text">Seleccione un contacto para ver su información</h5>
        </div>
    </section>

</div>

<script src="${pageContext.request.contextPath}/assets/js/alertas.js"></script>
<script>
    let listaContactosOriginales = [];
    let modoOrden = "AZ"; // 'AZ' por defecto o 'Recientes'
    let filtroGrupoActual = null; // null = Todos, o ID de grupo

    document.addEventListener("DOMContentLoaded", () => {
        // Capturar los elementos renderizados por JSTL en un array de objetos JavaScript de forma segura
        const elementosDOM = document.querySelectorAll("#listaContactos .contact-item");
        elementosDOM.forEach(el => {
            listaContactosOriginales.push({
                idContacto: el.getAttribute("data-id"),
                nombre: el.getAttribute("data-nombre"),
                apellidoPaterno: el.getAttribute("data-apellido-paterno"),
                apellidoMaterno: el.getAttribute("data-apellido-materno"),
                telefono: el.getAttribute("data-telefono"),
                idGrupo: parseInt(el.getAttribute("data-id-grupo")),
                fechaAlta: el.getAttribute("data-fecha-alta")
            });
        });

        renderizarContactos();

        // Eventos de filtros A-Z y Recientes
        document.getElementById("btnFiltroAZ").addEventListener("click", async () => {
            if (modoOrden === "AZ") return;
            modoOrden = "AZ";
            document.getElementById("btnFiltroAZ").className = "btn-filter filled";
            document.getElementById("btnFiltroRecientes").className = "btn-filter outline";
            await renderizarContactos();
        });

        document.getElementById("btnFiltroRecientes").addEventListener("click", async () => {
            if (modoOrden === "Recientes") return;
            modoOrden = "Recientes";
            document.getElementById("btnFiltroRecientes").className = "btn-filter filled";
            document.getElementById("btnFiltroAZ").className = "btn-filter outline";
            await renderizarContactos();
        });

        // Evento para "Todos" en el sidebar
        document.getElementById("navTodos").addEventListener("click", async (e) => {
            e.preventDefault();
            filtroGrupoActual = null;
            actualizarClaseActivaSidebar("todos");
            document.getElementById("tituloLista").textContent = "Todos los contactos";
            document.querySelectorAll(".contact-item").forEach(ci => ci.classList.remove("bg-light"));
            cambiarPanelDerecho(null, true);
            await renderizarContactos();
        });

        // Evento global para el botón de agregar grupo (+) en el sidebar
        const btnNuevoGrupo = document.getElementById("btnNuevoGrupo");
        if (btnNuevoGrupo) {
            btnNuevoGrupo.addEventListener("click", function(e) {
                e.stopPropagation();
                actualizarClaseActivaSidebar("nuevo-grupo");
                cambiarPanelDerecho("nuevo-grupo");
            });
        }

        // Eventos para cada botón de grupo en el sidebar
        document.querySelectorAll(".grupo-item").forEach(item => {
            item.addEventListener("click", async function() {
                const idGrupo = parseInt(this.getAttribute("data-id-grupo"));
                const nombreGrupo = this.getAttribute("data-nombre-grupo");

                filtroGrupoActual = idGrupo;
                actualizarClaseActivaSidebar(this);

                document.getElementById("tituloLista").textContent = nombreGrupo;
                document.querySelectorAll(".contact-item").forEach(ci => ci.classList.remove("bg-light"));
                cambiarPanelDerecho(null, true);

                await renderizarContactos();
            });
        });
    });

    // Función asíncrona para renderizar y ordenar con animaciones fluidas
    async function renderizarContactos() {
        const contenedor = document.getElementById("listaContactos");
        const sidebar = document.getElementById("alphabetSidebar");

        contenedor.classList.add("fade-out");
        contenedor.classList.remove("fade-in");
        await new Promise(resolve => setTimeout(resolve, 200));

        contenedor.innerHTML = "";
        sidebar.innerHTML = "";

        // Filtrar por grupo si está seleccionado
        let contactosFiltrados = listaContactosOriginales;
        if (filtroGrupoActual !== null) {
            contactosFiltrados = listaContactosOriginales.filter(c => c.idGrupo === filtroGrupoActual);
        }

        document.getElementById("subtituloLista").textContent = contactosFiltrados.length + " contactos";

        let contactosOrdenados = [...contactosFiltrados];

        if (modoOrden === "AZ") {
            contactosOrdenados.sort((a, b) => {
                let apA = (a.apellidoPaterno || "").toLowerCase();
                let apB = (b.apellidoPaterno || "").toLowerCase();
                if (apA !== apB) return apA.localeCompare(apB);
                return (a.nombre || "").toLowerCase().localeCompare((b.nombre || "").toLowerCase());
            });

            let letraActual = "";
            let letrasDisponibles = new Set();

            contactosOrdenados.forEach(c => {
                let ap = (c.apellidoPaterno || "").trim();
                let inicial = ap.length > 0 ? ap.charAt(0).toUpperCase() : "#";
                if (!/[A-Z]/.test(inicial)) inicial = "#";

                letrasDisponibles.add(inicial);

                if (inicial !== letraActual) {
                    letraActual = inicial;
                    const headerDiv = document.createElement("div");
                    headerDiv.className = "section-letter-header";
                    headerDiv.id = "seccion-" + inicial;
                    headerDiv.textContent = inicial;
                    contenedor.appendChild(headerDiv);
                }

                contenedor.appendChild(crearElementoContacto(c));
            });

            // Construir barra lateral A-Z
            const alfabeto = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split("");
            alfabeto.forEach(letra => {
                const a = document.createElement("a");
                a.className = "alphabet-letter";
                a.textContent = letra;
                if (letrasDisponibles.has(letra)) {
                    a.classList.add("active");
                    a.href = "#seccion-" + letra;
                    a.addEventListener("click", (e) => {
                        e.preventDefault();
                        const target = document.getElementById("seccion-" + letra);
                        if (target) {
                            target.scrollIntoView({ behavior: "smooth", block: "start" });
                        }
                    });
                }
                sidebar.appendChild(a);
            });

        } else {
            contactosOrdenados.sort((a, b) => new Date(b.fechaAlta) - new Date(a.fechaAlta));
            contactosOrdenados.forEach(c => {
                contenedor.appendChild(crearElementoContacto(c));
            });
        }

        // Reasignar eventos de clic para ver el detalle de cada contacto
        document.querySelectorAll(".contact-item").forEach(item => {
            item.addEventListener("click", function() {
                document.querySelectorAll(".contact-item").forEach(ci => ci.classList.remove("bg-light"));
                this.classList.add("bg-light");
                const idContacto = this.getAttribute("data-id");
                cambiarPanelDerecho("detalle-contacto?id=" + idContacto);
            });
        });

        requestAnimationFrame(() => {
            contenedor.classList.remove("fade-out");
            contenedor.classList.add("fade-in");
        });
    }

    function crearElementoContacto(c) {
        const div = document.createElement("div");
        div.className = "contact-item";
        div.setAttribute("data-id", c.idContacto);

        let iniciales = ((c.nombre ? c.nombre.charAt(0) : "") + (c.apellidoPaterno ? c.apellidoPaterno.charAt(0) : "")).toUpperCase();
        if (!iniciales) iniciales = "C";

        div.innerHTML = `
            <div class="avatar" style="background-color: #0d684c; font-size: 13px;">
                \${iniciales}
            </div>
            <div class="contact-info">
                <p class="name">\${c.nombre} \${c.apellidoPaterno} \${c.apellidoMaterno || ''}</p>
                <p class="phone">\${c.telefono}</p>
            </div>
        `;
        return div;
    }

    async function cambiarPanelDerecho(url, esEstadoVacio = false) {
        const panelContenido = document.getElementById("panelContenido");
        panelContenido.classList.add("fade-out");
        panelContenido.classList.remove("fade-in");
        await new Promise(resolve => setTimeout(resolve, 200));

        if (esEstadoVacio) {
            panelContenido.className = "empty-state-panel fade-out";
            panelContenido.innerHTML = `
                <div class="text-center text-muted">
                    <i class="bi bi-person empty-icon mb-2 d-block"></i>
                    <h5 class="fw-normal empty-text">Seleccione un contacto para ver su información</h5>
                </div>
            `;
        } else {
            try {
                const response = await fetch(url);
                const html = await response.text();
                const parser = new DOMParser();
                const doc = parser.parseFromString(html, "text/html");
                const contenidoNuevo = doc.querySelector(".form-panel") || doc.querySelector(".detalle-panel");

                if (contenidoNuevo) {
                    panelContenido.className = contenidoNuevo.className + " fade-out";
                    panelContenido.innerHTML = contenidoNuevo.innerHTML;

                    if (document.getElementById("btnAgregarTel")) {
                        inicializarFormularioDinamico();
                    }

                    // Interceptar el formulario inyectado: un solo listener, envío urlencoded
                    const formDinamico = panelContenido.querySelector("form");
                    if (formDinamico) {
                        formDinamico.addEventListener("submit", (e) => {
                            e.preventDefault();
                            enviarFormularioAjax(formDinamico);
                        });
                    }

                    const btnCancelarGrupo = document.getElementById("btnCancelarGrupo");
                    if (btnCancelarGrupo) {
                        btnCancelarGrupo.addEventListener("click", () => cambiarPanelDerecho(null, true));
                    }

                    // Cancelar: en edición vuelve al detalle, en nuevo contacto/grupo al estado vacío
                    const btnCancelarForm = document.getElementById("btnCancelar");
                    if (btnCancelarForm) {
                        btnCancelarForm.addEventListener("click", () => {
                            const inputId = document.querySelector("input[name='idContacto']");
                            if (inputId) {
                                cambiarPanelDerecho("detalle-contacto?id=" + inputId.value);
                            } else {
                                cambiarPanelDerecho(null, true);
                            }
                        });
                    }

                    const btnEditar = document.getElementById("btnEditarContacto");
                    if (btnEditar) {
                        btnEditar.addEventListener("click", function() {
                            const id = this.getAttribute("data-id");
                            cambiarPanelDerecho("editar-contacto?id=" + id);
                        });
                    }

                    const btnCancelarEdit = document.getElementById("btnCancelarEdit");
                    if (btnCancelarEdit) {
                        btnCancelarEdit.addEventListener("click", function() {
                            const inputId = document.querySelector("input[name='idContacto']");
                            if (inputId) {
                                cambiarPanelDerecho("detalle-contacto?id=" + inputId.value);
                            } else {
                                cambiarPanelDerecho(null, true);
                            }
                        });
                    }
                }
            } catch (error) {
                console.error("Error al cargar la vista:", error);
            }
        }

        requestAnimationFrame(() => {
            panelContenido.classList.remove("fade-out");
            panelContenido.classList.add("fade-in");
        });
    }

    function actualizarClaseActivaSidebar(elementoOSeccion) {
        document.querySelectorAll(".sidebar .nav-item").forEach(item => item.classList.remove("active"));
        if (elementoOSeccion === "todos") {
            document.getElementById("navTodos").classList.add("active");
        } else if (typeof elementoOSeccion === "object" && elementoOSeccion !== null) {
            elementoOSeccion.classList.add("active");
        }
    }

    document.getElementById("btnAbrirNuevo").addEventListener("click", function(e) {
        e.preventDefault();
        document.querySelectorAll(".sidebar .nav-item").forEach(item => item.classList.remove("active"));
        cambiarPanelDerecho("nuevo-contacto");
    });

    function inicializarFormularioDinamico() {
        const btnAgregarTel = document.getElementById("btnAgregarTel");
        const extraTelefonos = document.getElementById("extraTelefonos");

        if (btnAgregarTel && extraTelefonos) {
            btnAgregarTel.addEventListener("click", () => {
                const fila = document.createElement("div");
                fila.className = "d-flex align-items-center gap-2 mb-2";

                const input = document.createElement("input");
                input.type = "tel";
                input.name = "telefonoAlterno";
                input.className = "input-custom";
                input.placeholder = "Teléfono alterno";
                input.maxLength = 20;
                input.pattern = "[0-9+\\-\\s()]+";

                const btnQuitar = document.createElement("button");
                btnQuitar.type = "button";
                btnQuitar.className = "btn btn-sm btn-outline-danger rounded-circle";
                btnQuitar.textContent = "×";
                btnQuitar.addEventListener("click", () => fila.remove());

                fila.appendChild(input);
                fila.appendChild(btnQuitar);
                extraTelefonos.appendChild(fila);
                input.focus();
            });
        }
    }
</script>
</body>
</html>
