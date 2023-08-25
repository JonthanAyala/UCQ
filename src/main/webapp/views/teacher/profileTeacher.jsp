<%@ page import="mx.edu.utez.ucq.models.user.User" %><%--
  Created by IntelliJ IDEA.
  User: axelj_7
  Date: 19/07/2023
  Time: 07:09 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Perfil maestro</title>

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
      <button type="button" class="btn" style="background-color: transparent; border: transparent" onclick="redirectToTeacherIndex()">
        <img src=" ${pageContext.request.contextPath}/assets/img/back-48.png">
      </button>
    </div>

    <br><br>
  </div>
</nav>


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
      <img src=" ${pageContext.request.contextPath}/layouts/usuario.png">
    </div>

    <div class="container">

      <div class="card mt-3">
        <div class="card-body">
          <div class="container">
          <%User user = (User) request.getAttribute("user");%>

          <form id="user-form" class="needs-validation" novalidate action="${pageContext.request.contextPath}/user/update-Tprofile" method="post">
            <div class="form-group">

              <div class="row"  style="display: none">
                <div class="col">
                  <input type="text" name="id" id="id" value="<%= user.getId() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                </div>
              </div>


              <div class="row" STYLE="display: none">
                <div class="col">
                  <input type="text" name="type_user" id="type_user" value="<%= user.getType_user() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                </div>
              </div>


              <div class="row">
                <div class="col">
                  <label for="name" class="fw-bold">Nombre:</label>
                  <input type="text" name="name" id="name" value="<%= user.getName() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                </div>

                <div class="col">
                  <label for="lastname" class="fw-bold">Apellido Paterno:</label>
                  <input type="text" name="lastname" id="lastname" value="<%= user.getLastname() %> " class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                </div>


                <div class="col">
                  <label for="lastname" class="fw-bold">Apellido Materno:</label>
                  <input type="text" name="surname" id="surname" value="<%= user.getSurname() %> " class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                </div>

                <div class="col">
                  <label for="curp" class="fw-bold">CURP:</label>
                  <input type="text" name="curp" id="curp" value="<%= user.getCurp() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="18"> <!-- Modificado el maxlength a 18 -->
                </div>
              </div>
            </div>

            <div class="form-group">
              <div class="row">
                <div class="col">
                  <label for="mail" class="fw-bold">Correo:</label>
                  <input type="text" name="mail" id="mail" value="<%= user.getMail() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="23">
                </div>

                <div class="col">
                  <label for="password" class="fw-bold">Contraseña:</label>
                  <input type="password" name="password" id="password" value="<%= user.getPassword() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="16">

                  <label id="confPassTxt" for="confirmPassword" class="fw-bold" style="display: none">Confirmar contraseña:</label>
                  <input type="password" name="confimPassword" class="form-control" id="confirmPassword" style="display: none" maxlength="16" required>

                  <button type="submit" class="btn mt-2" id="savePasswordBtn" style="background-color: green; display: none">
                    <a style="color: white">Confirmar cambios</a>
                  </button>

                </div>

                <div class="col align-self-end"> <!-- Agregamos la clase "align-self-end" para alinear el botón al final del contenedor de columna -->
                  <div class="col">
                    <button type="button" class="btn mt-2" onclick="changePassword()" style="background-color: green" id="changePasswordBtn"> <!-- Modificamos la clase "mt-5" por "mt-2" para alinear con los campos -->
                      <a style="color: white">Editar perfil</a>
                    </button>
           <div class="container">

            <%--FALTA TRAER DATOS DE LA BD--%>

                    </div>
                  </div>
                </div>
              </div>

              <div class="container">
                <div id="changePassword-container">
                </div>
              </div>
            </div>
          </form>
          </div>


          </div>

        </div>

      </div>

      <br>
      <br>

    </div>

  </div>

</body>
</html>


<jsp:include page="../../layouts/footer.jsp"/>
<script>
  function changePassword() {
    // Habilitar todos los inputs de contraseña para escritura
    document.getElementById('name').readOnly = false;
    document.getElementById('name').style.backgroundColor = 'white';
    document.getElementById('lastname').readOnly = false;
    document.getElementById('lastname').style.backgroundColor = 'white';
    document.getElementById('surname').readOnly = false;
    document.getElementById('surname').style.backgroundColor = 'white';
    document.getElementById('curp').readOnly = false;
    document.getElementById('curp').style.backgroundColor = 'white';
    document.getElementById('mail').readOnly = false;
    document.getElementById('mail').style.backgroundColor = 'white';
    document.getElementById('password').readOnly = false;
    document.getElementById('password').style.backgroundColor = 'white';

    // Mostrar los elementos del cambio de contraseña
    document.getElementById('savePasswordBtn').style.display = 'block';
    document.getElementById('confPassTxt').style.display = 'block';
    document.getElementById('confirmPassword').style.display = 'block';

    // Ocultar el botón "Cambiar contraseña"
    document.getElementById('changePasswordBtn').style.display = 'none';
  }
  function redirectToTeacherIndex() {

    window.location.href = "${pageContext.request.contextPath}/user/index-teacher?id_user=" + <%= user.getId() %>;
  }

  (() => {
    'use strict';

    // Fetch all the forms we want to apply custom Bootstrap validation styles to
    const forms = document.querySelectorAll('.needs-validation');

    var passwordInput = document.getElementById("password");
    var confirmPasswordInput = document.getElementById("confirmPassword");

    // Loop over them and prevent submission
    Array.from(forms).forEach(form => {
      form.addEventListener('submit', event => {
        if (!form.checkValidity() || passwordInput.value !== confirmPasswordInput.value || passwordInput.equals() === confirmPasswordInput.equals()) {
          event.preventDefault();
          event.stopPropagation();
        }

        // Validar el formulario adicionalmente con la función personalizada
        if (!savePassword()) {
          event.preventDefault();
          event.stopPropagation();
        }
        // Agregar la clase 'was-validated' al formulario para mantener los estilos de validación de Bootstrap
        form.classList.add('was-validated');
      }, false);
    });
  })();

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
    // Obtener el valor de las contraseñas
    var form = document.getElementById("user-form");
    var passwordInput = document.getElementById("password");
    var confirmPasswordInput = document.getElementById("confirmPassword");

    // Validar el formulario antes de enviarlo
    if (form.checkValidity() && passwordInput.value === confirmPasswordInput.value && passwordInput.equals() === confirmPasswordInput.equals()) {
      // Si el formulario es válido y las contraseñas coinciden, enviarlo al servidor
      form.submit();
    } else if (passwordInput.value !== confirmPasswordInput.value || passwordInput.equals() === confirmPasswordInput.equals()) {
      // Si las contraseñas no coinciden, mostrar un mensaje de error con SweetAlert2
      Swal.fire({
        icon: 'error',
        title: 'LAS CONTRASEÑAS NO COINCIDEN',
        text: 'Verifica que las contraseñas sean iguales.',
        timer: 2000
      });
      return false; // Evitar el envío del formulario si las contraseñas no coinciden
    } else {
      // Si el formulario no es válido, mostrar un mensaje de error con SweetAlert2
      Swal.fire({
        icon: 'error',
        title: 'COMPLETA TODOS LOS CAMPOS',
        text: 'Por favor, completa todos los campos requeridos.',
        timer: 2000
      });
      // Agregar la clase 'was-validated' al formulario para mantener los estilos de validación de Bootstrap
      form.classList.add('was-validated');
      return false;
    }

    return true; // Si las contraseñas coinciden y el formulario es válido

    // Aquí puedes realizar alguna acción con la nueva contraseña, como enviarla al servidor.
    // Por ejemplo: enviarNewPasswordAlServidor(newPassword);

    // Bloquear el input de contraseña nuevamente
    document.getElementById('name').readOnly = true;
    document.getElementById('name').style.backgroundColor = ' #D9D9D9';
    document.getElementById('surnames').readOnly = true;
    document.getElementById('surnames').style.backgroundColor = ' #D9D9D9';
    document.getElementById('curp').readOnly = true;
    document.getElementById('curp').style.backgroundColor = ' #D9D9D9';
    document.getElementById('tuition').readOnly = true;
    document.getElementById('tuition').style.backgroundColor = ' #D9D9D9';
    document.getElementById('password').readOnly = true;
    document.getElementById('password').style.backgroundColor = ' #D9D9D9';

    // Ocultar el botón "Guardar Contraseña"
    document.getElementById('savePasswordBtn').style.display = 'none';
    document.getElementById('confPassTxt').style.display = 'none';
    document.getElementById('confirmPassword').style.display = 'none';

    // Mostrar el botón "CAMBIAR CONTRASEÑA"
    document.querySelector('.btn.mt-5').style.display = 'block';
  }

  // Agregar el evento de clic al botón "Guardar Contraseña"
  document.getElementById('savePasswordBtn').addEventListener('click', savePassword);
</script>

</body>
</html>
