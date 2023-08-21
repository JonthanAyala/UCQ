<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
  <title>logIn</title>
  <jsp:include page="/layouts/head.jsp"/>

</head>

<style>
  .centrado{
    display: grid;
    place-items: center;
  }

  .circulo {

    position:relative;
    width: 500px;
    height: 500px;
    -moz-border-radius: 50%;
    -webkit-border-radius: 50%;
    border-radius: 50%;
    background:  #002F5D;
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


</style>

<body style="background-color: white;overflow: hidden">


<div class="grid-container position-absolute">

</div>



<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
  <div class="container d-flex align-content-between">

    <img src="/assets/img/ico_UCQ.png" alt="Logo" width="100" height="40"
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
      <ul class="dropdown-menu text-center" style="background-color: #00AA83;">
        <li class="list-group-item" style="background-color: #00AA83; border-bottom: 1px solid #002F5D; margin: 0; padding: 0;"
            onmouseover="this.style.backgroundColor='#002F5D'; this.style.border='none'; this.style.color='#002F5D';"
            onmouseout="this.style.backgroundColor='#00AA83'; this.style.borderBottom='transparent';"
            onclick="window.location.href='user/view-exam';">
          <div style="cursor: pointer; padding: 8px;">
            <p style="margin: 0; color: white;">Estudiantes-Examen</p>
          </div>
        </li>
        <li class="list-group-item" style="background-color: #00AA83; color: white; margin: 0; padding: 0;"
            onmouseover="this.style.backgroundColor='#002F5D';"
            onmouseout="this.style.backgroundColor='#00AA83'; this.style.borderBottom='transparent';"
            onclick="window.location.href='/user/view-login';">
          <div style="cursor: pointer; padding: 8px;">
            <p style="margin: 0;">Iniciar sesion</p>
          </div>
        </li>
      </ul>
    </div>

    <br><br>
  </div>
</nav>

<br>
<br>
<br>

<div class=" container  mt-5 centrado align-items-stretch">
  <div class="col-4">
    <div class="card" style="border-color: #002F5D ">
      <div class="card-header" style=" background-color:  #002F5D; text-align: center">
        <h5 style="color: white"> Restablecimiento de contraseña </h5>
      </div>
      <div class="card-body">

        <form class="needs-validation" id="loginForm" action="/user/login" novalidate method="post">
          <tr style="background-color: white;">
            <th style="border: 2px solid #374b43;">
              <div class="form-outline">
                <label class="form-label" for="Email">Ingrese usuario o dirección de correo electrónico: </label>
                <input id="Email" name="Email" type="email" class="form-control" style="background-color: #D9D9D9;" required maxlength="22">
                <div class="invalid-feedback">
                  Campo obligatorio
                </div>
              </div>
            </th>
          </tr>
          <br>
          <div class="card-footer">
            <div class="d-grid">
              <button id="login" type="submit" class="btn btn-primary btn-block" value="login" style="background-color: #FAC138 !important;
                            border-color: #FAC138;">
                <i data-feather="log-in"></i> Entregar
              </button>
            </div>
          </div>
        </form>

      </div>
    </div>
  </div>
</div>
</div>

<footer class="w-100 bg-dark text-center text-white position-absolute bottom-0 start-50 translate-middle-x">
  <!-- Grid container -->
  <div class="container p-3">
    <section class="mb">

      La pagina es muy exitosa. Es de las mejores que hay en la Universidad Tecnologica
      del Emiliano Zapata echo por el equipo: Terreneitor de la carrera de Desarrollo de
      software Multiplataforma del grupo 3°C         </section>
  </div>
  <div class="container-fluid text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2023  Ultimate Custom Quiz :
    <a class="text-white" href="https://mdbootstrap.com/">UCQ.com</a>
  </div>
  <!-- Copyright -->
</footer>
<!-- Footer -->


<jsp:include page="/layouts/footer.jsp"/>

<script>
  document.getElementById('login').addEventListener('click', function(event) {
    var form = document.getElementById('loginForm');
    if (!form.checkValidity()) {
      event.preventDefault();
      event.stopPropagation();
      form.classList.add('was-validated');
    } else {
      var loginCredential = document.getElementById('loginCredential').value;
      var password = document.getElementById('password').value;

      // validación con el servidor
      var validUser = mail;
      var validPassword = password;

      if (loginCredential !== validUser || password !== validPassword) {
        event.preventDefault();
        form.classList.add('was-validated');
        document.getElementById('loginCredential').classList.add('is-invalid');
        document.getElementById('password').classList.add('is-invalid');
      }
    }
  });
  window.addEventListener("DOMContentLoaded", () => {
    feather.replace();
    const form = document.getElementById("loginForm");
    const btn = document.getElementById("login");
    form.addEventListener('submit', event => {
      btn.innerHTML = `<div class="d-flex justify-content-center">
                                <div class="spinner-border" role="status">
                                    <span class="visually-hidden">Loading...</span>
                                </div>
                            </div>`;
      btn.classList.add("disabled");
      if (!form.checkValidity()) {
        event.preventDefault();
        event.stopPropagation();
        btn.classList.remove("disabled");
        btn.innerHTML = `<i data-feather="log-in"></i> Iniciar sesion`;
      }
      form.classList.add('was-validated');
    }, false);
    if (!${param['result'] != null ? param['result'] : true}) {
      Swal.fire({
        title: 'Acceso denegado',
        text: '${param['message']}',
        icon: 'error',
        confirmButtonText: 'Aceptar'
      });
    }
  }, false);
</script>

</body>
</html>