@ -9,14 +9,159 @@
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<html>
<head>
  <title>Inicio Profesores</title>
  <jsp:include page="../../layouts/head.jsp"/>
</head>

<style>

  .navbar.bg-body-tertiary {
    background-color: #002F5D !important; /* Reemplaza "your-color" con el color deseado */
  }

  /* Restyle the navbar toggler button lines to white */
  .navbar-toggler.btn-white .navbar-toggler-icon {
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 30 30'%3E%3Cpath stroke='rgba(255, 255, 255, 1)' stroke-width='2' stroke-linecap='round' stroke-miterlimit='10' d='M4 7h22M4 15h22M4 23h22'/%3E%3C/svg%3E");
  }

</style>

<body style="background-color: #D8EAE3;">

<nav class="navbar bg-body-tertiary fixed-top mb-5">
  <div class="container d-flex align-content-between">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
         style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
    </div>
    <div>
      <button class="navbar-toggler btn-white" type="button" data-bs-toggle="offcanvas"
              data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar"
              aria-label="Toggle navigation" style="background-color: #152D45">
        <span class="navbar-toggler-icon"></span>
      </button>
    </div>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel"
         style="background-color: #00AA83">
      <div class="offcanvas-header" style="background-color: #002F5D">
        <h5 class="offcanvas-title" id="offcanvasNavbarLabel" style="color: white;">ULTIMATE CUSTOME QUIZ</h5>
        <button type="button" class="btn btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
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


<div class="container-fluid w-25 p-3 mt-5" style="border-color: #3ECEAC!important;">
  <div class="row">
    <div class="col">
      <div class="card mt-5 ">
        <div class="car-header" style="background-color: #00AA83; color: white"
        ><h4 class="text-center">crear examen</h4></div>
        <div class="card-body" >
          <form>
            <div class="form-group mb-3 ">
              <div class="d-grid">
                <button type="button" class="btn btn-outline-success btn-sm"  onclick="location.href='/teacher/view'">
                    crear nuevo examen
                </button>
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  </div>
</div>



<div class="container-fluid p-3 ">
  <div class="row">
    <div class="col">
      <div class="card mt-5 ">
        <div class="car-header ">
          <h3 class="text-center">Examenes creados </h3>
        </div>
        <div class="card-body ">
          <div class="card-body">
            <table class="table table-striped">
              <thead>
              <th>#</th>
              <th>Nombre examen</th>
              <th>Fecha inicio</th>
              <th>Fecha finalizacion</th>
              <th>Calificar</th>

              </thead>
              <tbody>
              <tr>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
                <td></td>
              </tr>
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