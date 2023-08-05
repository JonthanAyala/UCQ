<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Usuarios</title>
  <jsp:include page="./layouts/head.jsp"/>
</head>

<style>

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

</style>



<body style="background-color: white; overflow-x: hidden;">

<div class="grid-container position-absolute">

</div>


<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
  <div class="container d-flex align-content-between">

    <img src="/assets/img/Logo_UCQ.png" alt="Logo" width="100" height="40"
         class="d-inline-block align-text-top me-2">


    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">

      <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
         style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
    </div>

    <div class="dropdown">
      <button class="btn btn-light dropdown-toggle" style="margin-right: 50px;
      background-color: #002F5D; color: white" type="button"
              data-bs-toggle="dropdown" aria-expanded="false">
        Inicio de sesíon
      </button>
      <ul class="dropdown-menu text-center" >
        <li class="list-group-item"><a href="user/view-exam">Examen-Estudiantes</a></li>
        <li class="list-group-item"><a href="user/view-login"> Iniciar sesión </a></li>
      </ul>
    </div>

    <br><br>
  </div>
</nav>

<div class="container p-5">
  <br>
  <br>
  <div class="row d-flex justify-content-center align-items-center">
    <div class="col-md-6">
      <div class="container">
        <h2 class="text-center">Objetivo General</h2>
        <p class="text-left">
          UCQ<br>
          El objetivo de nuestro proyecto es poder crear una aplicación web para la gestión y resolución de exámenes
          evitando el plagio mediante la selección aleatoria de preguntas de un banco preexistente.
        </p>
        <ul class="text-center list-unstyled">
          <li><a href="/user/index-teacher"> menú de maestros</a></li>
          <li><a href="/user/mark-exam"> calificar examen </a></li>
          <li><a href="/user/profile"> perfil maestro </a></li>
        </ul>
      </div>
    </div>
    <div class="col-md-6 text-center">
      <div class="container">
        <img src="/assets/img/examen.jpg" width="525" height="240" alt="Examen"> <!-- Cambiamos el width y height -->
      </div>
    </div>
  </div>
  <div style="text-align: center" class="mt-5">
    <div class="col-12"><h3 class="text-center">¿Estás preparado para tu examen?</h3></div>
  </div>
</div>

<!-- Footer -->
<footer class="bg-dark text-center text-white">
  <!-- Grid container -->
  <div class="container p-3">
    <section class="mb">

      La pagina es muy exitosa. Es de las mejores que hay en la Universidad Tecnologica
      del Emiliano Zapata echo por el equipo: Terreneitor de la carrera de Desarrollo de
      software Multiplataforma del grupo 3°C         </section>
  </div>
  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2023  Ultimate Custom Quiz :
    <a class="text-white" href="https://mdbootstrap.com/">UCQ.com</a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->

<jsp:include page="./layouts/footer.jsp"/>
</body>
</html>