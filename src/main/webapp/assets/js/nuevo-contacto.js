const btnAgregarTel = document.getElementById("btnAgregarTel");
const extraTelefonos = document.getElementById("extraTelefonos");

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