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
        <img src="" alt="Bootstrap" width="30" height="24">
      </a>
      <br><br>
    </div>
</nav>

  <div class="container mt-5 p-5" style="background-color: white">

    <div class="container" style="text-align: center">
      <h1> PERFIL </h1>
    </div>

    <div class="container">
      <div class="card">

        <div class="card-header" style="background-color: #002F5D; text-align: center">
          <h6 style="color: white"> información personal </h6>
        </div>

        <div class="card-body">

          <div class="container">

            <%--FALTA TRAER DATOS DE LA BD--%>

              <form id="user-form" class="needs-validation" novalidate action="/user/save" method="post">
                <div class="form-group mb-3">

                  <div class="row">
                    <div class="col">
                      <label for="name" class="fw-bold">Nombre:</label>
                      <input type="text" name="name" id="name" class="form-control" style="background-color: #374b43" required readonly>
                      <div class="invalid-feedback">Campo obligatorio</div>
                    </div>

                    <div class="col">
                      <label for="surnames" class="fw-bold">Apellidos:</label>
                      <input type="text" name="surnames" id="surnames" class="form-control" style="background-color: #374b43" required readonly>
                      <div class="invalid-feedback">Campo obligatorio</div>
                    </div>

                    <div class="col">
                      <label for="tuition" class="fw-bold">Matricula:</label>
                      <input type="text" name="tuition" id="tuition" class="form-control" style="background-color: #374b43" required readonly>
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

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
