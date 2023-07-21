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
    <title>perfil maestro</title>

    <jsp:include page="../../layouts/head.jsp"/>
</head>

<body style="background-color: #D8EAE3; ">

  <nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
      <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
        <h3 class="text-center">Ultimate Custom Quiz</h3>
      </a>
      <a class="navbar-brand position-absolute top-0 end-0">
      </a>
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

          <div class="card">
            <div class="card-body">

              <div class="container">

                <%--FALTA TRAER DATOS DE LA BD--%>

                <form id="user-form" class="needs-validation" novalidate action="/user/save" method="post">

                  <div class="form-group mb-3">

                    <div class="row">
                      <div class="col">
                        <label for="name" class="fw-bold">Nombre:</label>
                        <input type="text" name="name" id="name" class="form-control" style="background-color: #D9D9D9" required readonly>
                      </div>

                      <div class="col">
                        <label for="surnames" class="fw-bold">Apellidos:</label>
                        <input type="text" name="surnames" id="surnames" class="form-control" style="background-color:  #D9D9D9" required readonly>
                      </div>

                      <div class="col">
                        <label for="tuition" class="fw-bold">Matricula:</label>
                        <input type="text" name="tuition" id="matricula" class="form-control"  style="background-color:  #D9D9D9"  required readonly>
                      </div>

                    </div>
                  </div>

                  <div class="form-group">

                    <div class="row">

                      <div class="col">
                        <label for="tuition" class="fw-bold">Correo:</label>
                        <input type="text" name="tuition" id="tuition" class="form-control" style="background-color: #D9D9D9" required readonly>
                      </div>

                      <div class="col">
                        <label for="password" class="fw-bold">Contraseña:</label>
                        <input type="text" name="password" id="password" class="form-control" style="background-color:  #D9D9D9" required readonly>
                      </div>

                      <div class="col">
                        <button type="button" class="btn mt-5"  onclick="changePassword()" style="background-color: green">
                          <a style="color: white">CAMBIAR CONTRASEÑA</a>
                        </button>
                      </div>

                    </div>
                  </div>

                  <div class="container mb-3">
                    <div id="changePassword-container">

                    </div>
                  </div>

                  <div class="form-group mb-3">
                    <div class="row">
                      <div class="col-2">

                        <label for="password" class="fw-bold">status:</label>
                        <input type="text" name="password" id="status" class="form-control"  style="background-color:  #D9D9D9" required readonly>
                        <div class="invalid-feedback">Campo obligatorio</div>

                      </div>
                    </div>
                  </div>

                </form>

              </div>

            </div>

          </div>
        </div>


      </div>

    </div>

  </div>

<jsp:include page="../../layouts/footer.jsp"/>
<script>

  function changePassword() {
    var changePassContainer = document.getElementById("changePassword-container");

    // Crea un div para contener el campo de cambio de contraseña
    var passwordDiv = document.createElement("div");
    passwordDiv.className = "form-group mb-3";

    // Crea el input para la nueva contraseña
    var newPasswordInput = document.createElement("input");
    newPasswordInput.className = "form-control";
    newPasswordInput.type = "password"; // Cambia a type="password" para ocultar la contraseña
    newPasswordInput.name = "newPassword";
    newPasswordInput.placeholder = "Nueva contraseña"; // Agrega un placeholder para indicar qué se debe ingresar

    // Agrega el input al div
    passwordDiv.appendChild(newPasswordInput);

    // Agrega el div con el input al contenedor de cambio de contraseña
    changePassContainer.appendChild(passwordDiv);

    // Hace que el div con el input sea visible
    passwordDiv.style.display = "block";

    // Hace que el input recién creado esté enfocado para que el usuario pueda escribir directamente
    newPasswordInput.focus();
  }


</script>

</body>
</html>

