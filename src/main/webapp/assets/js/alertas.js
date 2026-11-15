document.addEventListener("DOMContentLoaded", () => {
    const alerta = document.getElementById("alertaFlotante");
    if (!alerta) return;

    const mensaje = alerta.getAttribute("data-mensaje");
    const tipo = alerta.getAttribute("data-tipo");

    if (!mensaje || mensaje.trim() === "") return;

    mostrarAlertaFlotante(mensaje, tipo);

    if (window.location.search.includes("exito=")) {
        window.history.replaceState({}, document.title, window.location.pathname);
    }
});

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

    requestAnimationFrame(() => {
        contenedor.classList.add("visible");
    });

    setTimeout(() => {
        contenedor.classList.remove("visible");
        setTimeout(() => {
            contenedor.remove();
        }, 300);
    }, 4000);
}