<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 29/06/2023
  Time: 08:40 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Actualizar Profesor</title>
    <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3;">
<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
        <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
            <h3 class="text-center">Ultimate Custom Quiz</h3>
        </a>
        <a class="navbar-brand position-absolute top-0 end-0">
            <img src="/docs/5.3/assets/brand/bootstrap-logo.svg" alt="Bootstrap" width="30" height="24">
        </a>
        <br><br>
    </div>
</nav>

<div class="container-fluid ">
    <div class="row justify-content-center mt-5">
        <div class="col-12 col-md-6 w-100 p-3">
            <div class="card ">
                <div class="card-header">Registro de Alumnos</div>
                <div class="card-body">
                    <form id="user-form" class="needs-validation" novalidate action="/user/save" method="post">
                        <div class="form-group mb-3">
                            <div class="row">
                                <div class="col">
                                    <label for="name" class="fw-bold">Nombre:</label>
                                    <input type="text" name="name" id="name" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surnames" class="fw-bold">Apellidos:</label>
                                    <input type="text" name="surnames" id="surnames" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="tuition" class="fw-bold">Matricula:</label>
                                    <input type="text" name="tuition" id="tuition" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                            </div>
                        </div>

                        <div class="form-group mb-3">

                            <div class="row">
                                <div class="col">
                                    <label for="curp" class="fw-bold">Curp:</label>
                                    <input type="text" name="surname" id="curp" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="grade" class="fw-bold">Grado:</label>
                                    <div class="dropdown">
                                        <button class="btn btn-success btn-white dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Seleccionar
                                        </button>
                                        <ul class="dropdown-menu" >
                                            <li><a class="dropdown-item" href="#">1</a></li>
                                            <li><a class="dropdown-item" href="#">4</a></li>
                                            <li><a class="dropdown-item" href="#">8</a></li>
                                        </ul>
                                    </div>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                                <div class="col">
                                    <label for="group" class="fw-bold">Grupo:</label>
                                    <div class="dropdown">
                                        <button class="btn btn-success btn-white dropdown-toggle w-100" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                            Seleccionar
                                        </button>
                                        <ul class="dropdown-menu" >
                                            <li><a class="dropdown-item" href="#">A</a></li>
                                            <li><a class="dropdown-item" href="#">B</a></li>
                                            <li><a class="dropdown-item" href="#">C</a></li>
                                            <li><a class="dropdown-item" href="#">D</a></li>
                                        </ul>
                                    </div>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                            <div class="col">
                                <label for="status" class="fw-bold">Status:</label>
                                <div class="dropdown">
                                    <button class="btn btn-success btn-white dropdown-toggle w-25" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        Seleccionar
                                    </button>
                                    <ul class="dropdown-menu" >
                                        <li><a class="dropdown-item" href="#">Activo</a></li>
                                        <li><a class="dropdown-item" href="#">Inactivo</a></li>
                                    </ul>
                                </div>
                                <div class="invalid-feedback">Campo obligatorio</div>
                            </div>
                            </div>
                            </div>
                        </div>
                        <div class="form-group mb-3">
                            <div class="row justify-content-end">
                                <div class="col-auto">
                                    <a href="/user/users" class="btn btn-outline-danger btn-sm">CANCELAR</a>
                                    <button type="submit" class="btn btn-outline-success btn-sm">ACEPTAR</button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>

