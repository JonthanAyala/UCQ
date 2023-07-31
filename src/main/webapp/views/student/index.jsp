<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 17/06/2023
  Time: 09:56 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Inicio Alumnos</title>
    <jsp:include page="../../layouts/head.jsp"/>
</head>



<style>

    .navbar.bg-body-tertiary{
        background-color: #002F5D !important;

    }

    body {
        margin: 0;
        padding: 0;
        background-color: white; /* Color de fondo */
        background-image:
                linear-gradient(to right, rgba(216, 234, 227, 0.5) 1px, transparent 1px),
                linear-gradient(to bottom, rgba(216, 234, 227, 0.5) 1px, transparent 1px);
        background-size: 5px 5px; /* Tamaño de las celdas del cuadriculado */
    }

    .grid-container {
        /* Centra el contenido en la página */
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
    }

    /* Restyle the navbar toggler button lines to white */
    .navbar-toggler.btn-white .navbar-toggler-icon {
        background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3E%3Cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
    }

</style>



<body style="background-color: white;">

<div class="grid-container position-absolute">

</div>

<nav class="navbar navbar-expand-lg" style="background-color: #002F5D;">
    <div class="container d-flex align-content-between">
        <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
            <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
                <h3>Ultimate Custom Quiz</h3>
            </a>
        </div>
        <div class="dropdown">
            <button class="btn btn-light dropdown-toggle" style="margin-right: 50px; background-color: #002F5D; color: white" type="button"
                    data-bs-toggle="dropdown" aria-expanded="false">
                Más opciones
            </button>
            <ul class="dropdown-menu" style="background-color: #00AA83; border-bottom-color: #002F5D; margin: 0; padding: 0;">
                <li class="list-group-item" style="background-color: #00AA83; border-bottom: 1px solid #002F5D; margin: 0; padding: 0;"
                    onmouseover="this.style.backgroundColor='#002F5D'; this.style.border='none';
                    this.style.color='#002F5D';"
                    onmouseout="this.style.backgroundColor='#00AA83'; this.style.borderBottom='1px solid #002F5D';
                    this.style.color='white';"
                    onclick="window.location.href='user/view-exam';">
                    <div style="cursor: pointer; padding: 8px;">
                        <h6 style="color: white; margin: 0;">perfil</h6>
                    </div>
                </li>
                <li class="list-group-item" style="background-color: #00AA83; color: white; margin: 0; padding: 0;"
                    onmouseover="this.style.backgroundColor='#002F5D'; this.style.border='1px solid #002F5D';"
                    onmouseout="this.style.backgroundColor='#00AA83'; this.style.borderBottom='transparent';"
                    onclick="window.location.href='user/view-login';">
                    <div style="cursor: pointer; padding: 8px;">
                        <h6 style="margin: 0;">cerrar sesión</h6>
                    </div>
                </li>
            </ul>
        </div>
        <br><br>
    </div>
</nav>


<div class="container-fluid w-25 p-3 mt-5" style="border-color: #3ECEAC!important;">
    <div class="row">
        <div class="col" >
            <div class="card mt-5">
                <div class="car-header" style="background-color: #00AA83; color: white"
                ><h4 class="text-center">Codigo de acceso</h4></div>
                <div class="card-body" ><br> <br> <br>
                    <form>
                        <div class="form-group mt-2 position-absolute top-50 start-50 translate-middle">
                            <div class="row">
                                <div class="col text-center d-grid mt-2">
                                    <input  type="text" name="codigo" id="codigo" class="form-control
                   mt-4" required style="background-color: #D9D9D9;">
                                    <button type="submit" class="btn btn-outline-success btn-sm mt-3">
                                        aceptar
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>


<div class="container-fluid w-100 p-3 ">
    <div class="row">
        <div class="col" style="background-color: transparent;">
            <div class="card" style="border-color: #002F5D">
                <div class="car-header" style="background-color: #00AA83; color: white;">
                    <h3 class="text-center mt-3">Examenes pendientes</h3>
                </div>

                <table class="table table-striped">
                    <thead style="background-color: #002F5D">
                    <th style="color: white">#</th>
                    <th style="color: white">Nombre examen</th>
                    <th style="color: white">Fecha inicio</th>
                    <th style="color: white">Fecha finalizacion</th>
                    <th style="color: white">Profesor</th>
                    </thead>
                    <tbody>
                    <tr>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6" class="text-center">
                            Sin registros
                        </td>
                    </tr>
                    </tbody>
                </table>

            </div>
        </div>
    </div>
</div>
<jsp:include page="../../layouts/footer.jsp"/>



</body>
</html>