<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<html>
<head>
    <title>logIn</title>
    <jsp:include page="../../layouts/head.jsp"/>

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


<div class="centrado mt-5">

    <div class="row align-items-stretch">

        <h2>
            <span style="color: #00AA83;">ULTIMATE CUSTOM</span> <span style="color: #002F5D;"> QUIZ</span>
        </h2>

    </div>
</div>

<div class="position-relative">
    <div class="position-absolute top-0 start-0 translate-middle">

        <div class="container">
            <div class="circulo">

            </div>
        </div>

    </div>
</div>


<div class="container  mt-5 centrado align-items-stretch">
    <div class="col-4">
        <div class="card" style="border-color: #002F5D ">
            <div class="card-header" style=" background-color:  #002F5D; text-align: center">
                <h5 style="color: white"> Inicio de sesión </h5>
            </div>
            <div class="card-body">

                <form  class="needs-validation" id="loginForm" action="/user/login" novalidate method="post">

                    <tr style="background-color: white;">
                        <th style="border: 2px solid #374b43;">
                            <div class="form-outline ">
                                <input  id="loginCredential" name="loginCredential" type="text" class="form-control" style="background-color: #D9D9D9;" required>
                                <label class="form-label" for="loginCredential"> Usuario </label>
                                <div class="invalid-feedback text-start">
                                    Campo obligatorio
                                </div>
                            </div>

                            <div class="form-outline">
                                <input id="password" name="password"  maxlength="8" type="password" class="form-control" style="background-color: #D9D9D9;" required>
                                <label class="form-label" for="password"> Contraseña </label>
                                <div class="invalid-feedback text-start">
                                    Campo obligatorio
                                </div>
                            </div>

                        </th>

                    </tr>

                    <h6 style="color: #002F5D" href=""> ¿olvidaste tu contraseña? </h6>
                    <div class="card-footer">
                        <div class="d-grid ">
                            <button id="login" type="submit" class="btn btn-primary btn-block " value="login" style="background-color: #00AA83 !important;">
                                <i data-feather="log-in"></i> Iniciar sesion
                            </button>


                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
</div>


<div class="position-relative">
    <div class="container">
        <div class="position-absolute top-100 start-100 translate-middle"
        style="bottom: 90%">
            <div class="circulo"></div>
        </div>
    </div>
</div>



<jsp:include page="../../layouts/footer.jsp"/>

<script>
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
        if (!${param['result'] != null ? param['result']: true}) {
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
