<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Contactos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="assets/css/index.css">
</head>
<body>
<div class="app-container">

    <aside class="sidebar">
        <div class="sidebar-header">
            <img src="https://ui-avatars.com/api/?name=C&background=333&color=fff&rounded=true" alt="Logo" class="logo-img">
            <h4 class="logo-text">Contactos</h4>
        </div>

        <button class="btn-nuevo-contacto">
            <i class="bi bi-plus-lg"></i> Nuevo Contacto
        </button>

        <ul class="nav-list mt-3">
            <li class="nav-item active">
                <div class="nav-item-content">
                    <i class="bi bi-people fw-bold fs-5 me-3"></i>
                    <span class="fs-5">Todos</span>
                </div>
                <span class="count">0</span>
            </li>
            <li class="nav-item">
                <div class="nav-item-content">
                    <i class="bi bi-trash3 fs-5 me-3"></i>
                    <span class="fs-5">Eliminados</span>
                </div>
                <span class="count">0</span>
            </li>
        </ul>

        <div class="grupos-section mt-4">
            <div class="d-flex justify-content-between align-items-center pe-3 mb-2">
                <span class="grupos-title">Grupo</span>
                <i class="bi bi-plus text-muted fs-5"></i>
            </div>
            <ul class="nav-list sub-list">
                <li class="nav-item">
                    <span>familia</span>
                    <span class="count text-muted">0</span>
                </li>
                <li class="nav-item">
                    <span>trabajo</span>
                    <span class="count text-muted">0</span>
                </li>
                <li class="nav-item">
                    <span>amigos</span>
                    <span class="count text-muted">0</span>
                </li>
            </ul>
        </div>
    </aside>

    <main class="contacts-list-panel border-end border-start">
        <div class="p-4 pb-2">
            <h2 class="fw-normal mb-0">Todos los contactos</h2>
            <p class="text-muted small mb-3">0 contactos</p>

            <div class="search-bar mb-3">
                <i class="bi bi-search ms-3 text-muted"></i>
                <input type="text" placeholder="Busca por nombre, teléfono o correo">
            </div>

            <div class="d-flex gap-2 mb-4">
                <button class="btn-filter outline">A-Z</button>
                <button class="btn-filter filled">Recientes</button>
            </div>
        </div>

        <div class="contacts-scroll px-4">

        </div>
    </main>

    <section class="empty-state-panel">
        <div class="text-center text-muted">
            <i class="bi bi-person empty-icon mb-2 d-block"></i>
            <h5 class="fw-normal empty-text">Seleccione un numero para ver su informacion</h5>
        </div>
    </section>

</div>
</body>
</html>