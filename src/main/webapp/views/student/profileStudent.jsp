 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ page import="mx.edu.utez.ucq.models.user.User" %>
<%--
  Created by IntelliJ IDEA.
  User: axelj_7
  Date: 19/07/2023
  Time: 07:09 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Perfil estudiante</title>

  <jsp:include page="../../layouts/head.jsp"/>
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
<body style="background-color: white;">

<div class="grid-container position-absolute">

</div>
<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
  <div class="container d-flex align-content-between">

    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
         style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
    </div>

    <div>
      <button type="button" class="btn" style="background-color: transparent; border: transparent" onclick="redirectToStudentsIndex()">
        <img src="../../assets/img/back-48.png">
      </button>
    </div>

    <br><br>
  </div>
</nav>


<%--
<nav class="navbar navbar-expand-lg" style="background-color: #00AA83;">
  <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
    <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
      <h4 class="text-center"> Perfil </h4>
    </a>
    <a class="navbar-brand position-absolute top-0 end-0">
    </a>
    <br><br>
  </div>
</nav>
--%>

<div class="container mt-5" style="background-color: white">

  <nav class="navbar navbar-expand-lg  " style= "background-color:  #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
        <h6 style="color: white"> Información personal </h6>
      </a>
      <a class="navbar-brand position-absolute top-0 end-0">
      </a>
      <br><br>
    </div>
  </nav>

  <div class="d-flex">

    <div>
      <img src="../../assets/img/usuario.png">
    </div>

    <div class="container">

      <div class="card mt-3">
        <div class="card-body">

          <div class="container">

            <%--FALTA TRAER DATOS DE LA BD--%>
              <%User user1 = (User) request.getAttribute("user");%>
            <tbody>
            <form id="user-form" class="needs-validation" novalidate action="/user/save" method="post">

              <div class="form-group">
                <div class="row">
                  <div class="col">
                    <label for="name" class="fw-bold">Nombre:</label>
                    <input type="text" name="name" id="name" value="<%= user1.getName() %>" class="form-control" style="background-color: #D9D9D9" required readonly>
                  </div>

                  <div class="col">
                    <label for="surnames" class="fw-bold">Apellidos:</label>
                    <input type="text" name="surnames" id="surnames" value="<%= user1.getLastname() %> <%= user1.getSurname() %>" class="form-control" style="background-color: #D9D9D9" required readonly>
                  </div>
                </div>
              </div>

              <div class="form-group">
                <div class="row">
                  <div class="col">
                    <label for="enrollment" class="fw-bold">Matrícula:</label> <!-- Corregido con tilde en "Matrícula" -->
                    <input type="text" name="enrollments" id="enrollment" value="<%= user1.getEnrollment() %>" class="form-control" style="background-color: #D9D9D9" required readonly>
                  </div>

                  <div class="col">
                    <label for="password" class="fw-bold">Contraseña:</label>
                    <input type="password" name="password" id="password" value="<%= user1.getPassword() %>" class="form-control" style="background-color: #D9D9D9" required readonly>

                    <label id="confPassTxt" for="confirmPassword" class="fw-bold" style="display: none">Confirmar contraseña:</label>
                    <input type="password" name="confimPassword" class="form-control" id="confirmPassword" style="display: none">

                    <button type="button" class="btn mt-2" id="savePasswordBtn" style="background-color: green; display: none">
                      <a style="color: white">Guardar cambios</a>
                    </button>
                  </div>

                  <div class="col align-self-end"> <!-- Agregamos la clase "align-self-end" para alinear el botón al final del contenedor de columna -->
                    <div class="col">
                      <button type="button" class="btn mt-2" onclick="changePassword()" style="background-color: green" id="changePasswordBtn"> <!-- Modificamos la clase "mt-5" por "mt-2" para alinear con los campos -->
                        <a style="color: white">Editar perfil</a>
                      </button>
                    </div>
                  </div>
                </div>
              </div>

              <div class="container">
                <div id="changePassword-container">
                </div>
              </div>

            </form>
            </tbody>

          </div>

        </div>

      </div>

      <br>
      <br>

    </div>

  </div>

</div>

</div>


<jsp:include page="../../layouts/footer.jsp"/>
<script>
  function changePassword() {
    // Habilitar todos los inputs de contraseña para escritura
    document.getElementById('name').readOnly = false;
    document.getElementById('name').style.backgroundColor = 'white';
    document.getElementById('surnames').readOnly = false;
    document.getElementById('surnames').style.backgroundColor = 'white';
    document.getElementById('enrollment').readOnly = false;
    document.getElementById('enrollment').style.backgroundColor = 'white';
    document.getElementById('password').readOnly = false;
    document.getElementById('password').style.backgroundColor = 'white';

    // Mostrar los elementos del cambio de contraseña
    document.getElementById('savePasswordBtn').style.display = 'block';
    document.getElementById('confPassTxt').style.display = 'block';
    document.getElementById('confirmPassword').style.display = 'block';

    // Ocultar el botón "Cambiar contraseña"
    document.getElementById('changePasswordBtn').style.display = 'none';
  }


  function confirmPassword() {
    // Obtener el valor de las contraseñas
    const newPassword = document.getElementById('password').value;
    const confirmNewPassword = document.getElementById('confirmPassword').value;

    // Comparar las contraseñas
    if (newPassword !== confirmNewPassword) {
      Swal.fire(
              'LAS CONTRASEÑAS NO COINCIDEN',
              'verifica',
              'warning'
      )
      return false;
    }

    return true;
  }

  function savePassword() {
    // Llamar a confirmPassword() para verificar las contraseñas antes de guardar
    if (!confirmPassword()) {
      return;
    }

    // Aquí puedes realizar alguna acción con la nueva contraseña, como enviarla al servidor.
    // Por ejemplo: enviarNewPasswordAlServidor(newPassword);

    // Bloquear el input de contraseña nuevamente
    document.getElementById('name').readOnly = true;
    document.getElementById('name').style.backgroundColor = ' #D9D9D9';
    document.getElementById('surnames').readOnly = true;
    document.getElementById('surnames').style.backgroundColor = ' #D9D9D9';
    document.getElementById('enrollment').readOnly = true;
    document.getElementById('enrollment').style.backgroundColor = ' #D9D9D9';
    document.getElementById('password').readOnly = true;
    document.getElementById('password').style.backgroundColor = ' #D9D9D9';


    // Ocultar el botón "Guardar Contraseña"
    document.getElementById('savePasswordBtn').style.display = 'none';
    document.getElementById('confPassTxt').style.display = 'none';
    document.getElementById('confirmPassword').style.display = 'none';

    // Mostrar el botón "CAMBIAR CONTRASEÑA"
    document.querySelector('.btn.mt-5').style.display = 'block';
  }
  function redirectToStudentsIndex() {
    window.location.href = "/user/student";
  }

  // Agregar el evento de clic al botón "Guardar Contraseña"
  document.getElementById('savePasswordBtn').addEventListener('click', savePassword);
</script>

</body>
</html>

