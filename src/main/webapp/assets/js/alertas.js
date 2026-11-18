let temporizadorOcultar = null;

document.addEventListener("DOMContentLoaded", () => {
    const alerta = document.getElementById("alertaFlotante");
    if (alerta) {
        const mensaje = alerta.getAttribute("data-mensaje");
        const tipo = alerta.getAttribute("data-tipo");
        if (mensaje && mensaje.trim() !== "") {
            mostrarAlertaFlotante(mensaje, tipo);
            if (window.location.search.includes("exito=")) {
                window.history.replaceState({}, document.title, window.location.pathname);
            }
        }
    }
});

// Envía el formulario por fetch (urlencoded, NO multipart) y muestra el resultado
async function enviarFormularioAjax(form) {
    mostrarIndicadorEstado("cargando", "Procesando información...");

    try {
        const body = new URLSearchParams(new FormData(form));
        const response = await fetch(form.action, {
            method: "POST",
            headers: { "Content-Type": "application/x-www-form-urlencoded;charset=UTF-8" },
            body: body
        });

        // Éxito: el servlet hizo sendRedirect a index.jsp?exito=...
        const urlFinal = new URL(response.url);
        if (response.redirected && urlFinal.searchParams.has("exito")) {
            const msg = urlFinal.searchParams.get("exito");
            mostrarIndicadorEstado("exito", msg);
            setTimeout(() => {
                window.location.href = "index.jsp?exito=" + encodeURIComponent(msg);
            }, 800);
            return;
        }

        // Error de validación: el servlet devolvió el JSP con <div id="alertaFlotante">
        const html = await response.text();
        const doc = new DOMParser().parseFromString(html, "text/html");
        const alerta = doc.getElementById("alertaFlotante");
        const msg = alerta ? alerta.getAttribute("data-mensaje") : "El servidor rechazó la operación";

        mostrarIndicadorEstado("error", msg);
        mostrarAlertaFlotante(msg, "error");
    } catch (error) {
        mostrarIndicadorEstado("error", "Error de conexión");
        mostrarAlertaFlotante("Error de conexión con el servidor", "error");
    }
}

function mostrarAlertaFlotante(mensaje, tipo) {
    const contenedor = document.createElement("div");
    contenedor.className = "toast-flotante " + (tipo === "exito" ? "toast-exito" : "toast-error");

    const icono = document.createElement("i");
    icono.className = tipo === "exito" ? "bi bi-check-circle-fill" : "bi bi-exclamation-circle-fill";

    const texto = document.createElement("span");
    texto.textContent = mensaje;

    contenedor.appendChild(icono);
    contenedor.appendChild(texto);
    document.body.appendChild(contenedor);

    requestAnimationFrame(() => contenedor.classList.add("visible"));

    setTimeout(() => {
        contenedor.classList.remove("visible");
        setTimeout(() => contenedor.remove(), 300);
    }, 4000);
}

function mostrarIndicadorEstado(estado, mensaje) {
    let contenedor = document.getElementById("statusIndicatorContainer");

    if (temporizadorOcultar) {
        clearTimeout(temporizadorOcultar);
        temporizadorOcultar = null;
    }

    if (!contenedor) {
        contenedor = document.createElement("div");
        contenedor.id = "statusIndicatorContainer";
        document.body.appendChild(contenedor);
    }

    contenedor.innerHTML = `
        <div id="statusContent"></div>
        <div id="statusTooltip"></div>
        <button type="button" id="statusCloseBtn" title="Cerrar">&times;</button>
    `;
    document.getElementById("statusTooltip").textContent = mensaje; // textContent: evita inyección HTML

    const contentDiv = document.getElementById("statusContent");
    document.getElementById("statusCloseBtn").addEventListener("click", (e) => {
        e.stopPropagation();
        ocultarIndicadorEstado();
    });

    contenedor.style.display = "flex";

    if (estado === "cargando") {
        contentDiv.innerHTML = `<div class="status-spinner"></div>`;
    } else {
        contentDiv.innerHTML = estado === "exito"
            ? `<div class="status-icon success"><i class="bi bi-check-lg"></i></div>`
            : `<div class="status-icon error"><i class="bi bi-x-lg"></i></div>`;
        temporizadorOcultar = setTimeout(ocultarIndicadorEstado, 5000);
    }
}

function ocultarIndicadorEstado() {
    const contenedor = document.getElementById("statusIndicatorContainer");
    if (contenedor) contenedor.style.display = "none";
    if (temporizadorOcultar) {
        clearTimeout(temporizadorOcultar);
        temporizadorOcultar = null;
    }
}