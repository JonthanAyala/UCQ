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
  <title>perfil estudiante</title>

  <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3; ">

<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
  <div class="container d-flex align-content-between">

    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
         style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
    </div>

    <div>
      <button type="button" class="btn" style="background-color: transparent; border: transparent">
        <img src="../../assets/img/icons8-volver-48.png">
      </button>
    </div>

    <br><br>
  </div>
</nav>

<nav class="navbar navbar-expand-lg  " style= "background-color:  #00AA83;">
  <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
    <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
      <h4 class="text-center"> Perfil </h4>
    </a>
    <a class="navbar-brand position-absolute top-0 end-0">
    </a>
    <br><br>
  </div>
</nav>

<div class="container mt-5" style="background-color: white">

  <nav class="navbar navbar-expand-lg  " style= "background-color:  #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
        <h6 style="color: white"> información personal </h6>
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

            <form id="user-form" class="needs-validation" novalidate action="/user/save" method="post">

              <div class="form-group">

                <div class="row">
                  <div class="col">
                    <label for="name" class="fw-bold">Nombre:</label>
                    <input type="text" name="name" id="name" class="form-control" style="background-color: #D9D9D9" required readonly>
                  </div>

                  <div class="col">
                    <label for="surnames" class="fw-bold">Apellidos:</label>
                    <input type="text" name="surnames" id="surnames" class="form-control" style="background-color:  #D9D9D9" required readonly>
                  </div>


                </div>
              </div>

              <div class="form-group">

                <div class="row">

                  <div class="col">
                    <label for="enrollment" class="fw-bold">Matricula:</label>
                    <input type="text" name="enrollments" id="enrollment" class="form-control"  style="background-color:  #D9D9D9"  required readonly>
                  </div>

                  <div class="col">

                    <label for="password" class="fw-bold">Contraseña:</label>
                    <input type="password" name="password" id="password" class="form-control" style="background-color:  #D9D9D9" required readonly>

                    <label id="confPassTxt" for="confirmPassword" class="fw-bold" style="display: none">Confirmar contraseña:</label>
                    <input type="password" name="confimPassword" class="mt-2 fw-bold" id="confirmPassword" style="display: none">

                    <button type="button" class="btn mt-2" id="savePasswordBtn"
                            style="background-color: green; display: none">
                      <a style="color: white"> GUARDAR CONTRASEÑA </a>
                    </button>

                  </div>

                  <div class="col">
                    <button type="button" class="btn mt-5"  onclick="changePassword()" style="background-color: green">
                      <a style="color: white">CAMBIAR CONTRASEÑA</a>
                    </button>
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

<jsp:include page="../../layouts/footer.jsp"/>
<script>
  function changePassword() {
    // Habilitar el input de contraseña para escritura
    document.getElementById('password').readOnly = false;
    document.getElementById('password').style.backgroundColor = 'white';

    // Mostrar el botón de "Guardar Contraseña"
    document.getElementById('savePasswordBtn').style.display = 'block';
    document.getElementById('confPassTxt').style.display = 'block';
    document.getElementById('confirmPassword').style.display = 'block';

    // Ocultar el botón "CAMBIAR CONTRASEÑA"
    document.querySelector('.btn.mt-5').style.display = 'none';
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

