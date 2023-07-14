<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 17/06/2023
  Time: 09:56 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Inicio Alumnos</title>
  <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3;">

<style>

  .navbar.bg-body-tertiary{
    background-color: #002F5D !important;


  }
</style>

<nav class="navbar bg-body-tertiary fixed-top mb-5">
  <div class="container d-flex align-content-between">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
         style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
    </div>
    <div>
      <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas"
              data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar"
              aria-label="Toggle navigation" style="border-color: white">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel" style="background-color: #002F5D">
      <div class="offcanvas-header">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel" style="color: white;">ULTIMATE CUSTOME QUIZ</h5>
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
      </div>
      <div class="offcanvas-body">
        <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
          <li class="nav-item">
            <a class="nav-link active" aria-current="page" href="#" style="color: white;"> Perfil </a>
          </li>
          <li class="nav-item">
            <a class="nav-link" href="#" style="color: white">Cerrar sesion </a>
          </li>
        </ul>
      </div>
    </div>
  </div>
  <br>
  <br>
</nav>


<div class="container-fluid w-25 p-3 mt-5">
  <div class="row">
    <div class="col">
      <div class="card mt-5 ">
        <div class="car-header"><h4 class="text-center">Ingresa el codigo de aceeso</h4></div>
        <div class="card-body "><br> <br> <br>
          <form>
            <div class="form-group mb-3 position-absolute top-50 start-50 translate-middle">
              <div class="row">
                <div class="col text-center">
                  <label for="codigo" class="fw-bold ">Codigo acceso</label>
                  <input  type="text" name="codigo" id="codigo" class="form-control" required style="background-color: #D9D9D9;">
                  <button type="submit" class="btn btn-outline-success btn-sm">
                    ACEPTAR
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


<div class="container-fluid w-75 p-3  ">
  <div class="row">
    <div class="col">
      <div class="card mt-5 ">

        <div class="car-header ">
          <h3 class="text-center">Examenes pendientes</h3>
        </div>

        <div class="card-body ">
          <div class="card-body">
            <table class="table table-striped">
              <thead>
              <th>#</th>
              <th>Nombre examen</th>
              <th>Fecha inicio</th>
              <th>Fecha finalizacion</th>
              <th>Maestro</th>

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
  </div>
</div>
<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
