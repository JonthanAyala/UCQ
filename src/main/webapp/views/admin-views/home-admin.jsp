
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Inicio Admin</title>
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

<br><br>
<div class="container-fluid">
    <div class="row">
        <div class="col">
            <div class="col">
                <form class="d-flex justify-content-center" role="search">
                    <input class="form-control me-2 w-25 p-3  align-content-center " style="background-color: #D9D9D9;" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-5">
        <div class="col-3 col-md-2">
            <div class="card">
                <img src="../../assets/img/teacher.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Crear profesores</h5>
                    <p class="card-text"> </p>
                </div>
            </div>
        </div>
        <div class="col-3 col-md-2">
            <div class="card">
                <img src="../../assets/img/student.png" class="card-img-top" alt="...">
                <div class="card-body">
                    <h5 class="card-title">Crear alumno</h5>
                    <p class="card-text"></p>
                </div>
            </div>
        </div>
    </div>


    <div class="row justify-content-center mt-5">
        <div class="col-10">
            <div class="card">
                <div class="card-header">
                    <div class="row">
                        <div class="col">Listado de usuarios</div>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-stripped">
                        <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Apellidos</th>
                            <th>Matricula</th>
                            <th>Grado</th>
                            <th>Grupo</th>
                            <th>Carrera</th>
                            <th>Rol</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td>
                                <form method="GET" action="...">
                                    <input hidden value="${user.id}" name="id">
                                    <button type="submit" class="btn btn-outline-warning btn-sm">
                                        Agregar
                                    </button>
                                </form>
                                <form method="post" action="...">
                                    <input hidden value="${user.id}" name="id">
                                    <button type="submit" class="btn btn-outline-danger btn-sm">
                                        ELIMINAR
                                    </button>
                                </form>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="8">
                                Sin registros
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    <div class="row justify-content-center mt-5">
        <div class="col-6">
            <form class="d-flex justify-content-center" role="search">
                <button class="btn btn-outline-success" type="submit">Regresar</button>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>



