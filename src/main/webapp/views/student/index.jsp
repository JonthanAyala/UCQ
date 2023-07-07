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



<div class="container-fluid w-25 p-3  ">
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
