<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="mx.edu.utez.ucq.models.user.User" %><%--
  Created by IntelliJ IDEA.
  User: axelj_7
  Date: 19/07/2023
  Time: 07:09 p. m.
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
      <button type="button" class="btn" style="background-color: transparent; border: transparent" onclick="redirectToAdminIndex()">
        <img src="../../assets/img/back-48.png">
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
      <img src="../../assets/img/usuario.png">
    </div>

    <div class="container">

      <div class="card mt-3">
        <div class="card-body">

          <div class="container">

            <%--FALTA TRAER DATOS DE LA BD--%>
              <%User userA = (User) request.getAttribute("user");%>
            <form id="user-form" class="needs-validation" novalidate action="/user/update" method="post">
              <div class="form-group">
                <div class="row">

                  <div class="col">
                    <label for="name" class="fw-bold">Nombre:</label>
                    <input type="text" name="name" id="name" value="<%= userA.getName() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25" >
                  </div>

                  <div class="col">
                    <label for="surnames" class="fw-bold">Apellidos:</label>
                    <input type="text" name="surnames" id="surnames" value="<%= userA.getLastname() %> <%= userA.getSurname() %>"class="form-control" style="background-color: #D9D9D9" required readonly maxlength="25">
                  </div>

                  <div class="col">
                    <label for="curp" class="fw-bold">CURP:</label>
                    <input type="text" name="curp" id="curp" value="<%= userA.getCurp() %>" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="18"> <!-- Modificado el maxlength a 18 -->
                  </div>
                </div>
              </div>

              <div class="form-group">
                <div class="row">
                  <div class="col">
                    <label for="tuition" class="fw-bold">Correo:</label>
                    <input type="text" name="tuition" id="tuition" class="form-control" value="<%= userA.getMail() %>" style="background-color: #D9D9D9" required readonly maxlength="23">
                  </div>
                  <div class="col">
                    <label for="password" class="fw-bold">Contraseña:</label>
                    <input type="password" name="password" value="<%= userA.getPassword() %>" id="password" class="form-control" style="background-color: #D9D9D9" required readonly maxlength="16">

                    <label id="confPassTxt" for="confirmPassword" class="fw-bold" style="display: none">Confirmar contraseña:</label>
                    <input type="password" name="confimPassword" class="form-control" id="confirmPassword" style="display: none" maxlength="16">

                    <button type="submit" class="btn mt-2" id="savePasswordBtn" style="background-color: green; display: none">
                      <a style="color: white">Confirmar cambios</a>
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


          </div>

        </div>

      </div>

      <br>
      <br>

    </div>

  </div>

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
      document.getElementById('surnames').readOnly = false;
      document.getElementById('surnames').style.backgroundColor = 'white';
      document.getElementById('curp').readOnly = false;
      document.getElementById('curp').style.backgroundColor = 'white';
      document.getElementById('tuition').readOnly = false;
      document.getElementById('tuition').style.backgroundColor = 'white';
      document.getElementById('password').readOnly = false;
      document.getElementById('password').style.backgroundColor = 'white';

      // Mostrar los elementos del cambio de contraseña
      document.getElementById('savePasswordBtn').style.display = 'block';
      document.getElementById('confPassTxt').style.display = 'block';
      document.getElementById('confirmPassword').style.display = 'block';

      // Ocultar el botón "Cambiar contraseña"
      document.getElementById('changePasswordBtn').style.display = 'none';
    }
    function redirectToAdminIndex() {
      window.location.href = "/user/admin";
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

