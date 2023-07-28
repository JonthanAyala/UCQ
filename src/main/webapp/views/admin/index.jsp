<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Inicio Admin</title>
    <jsp:include page="../../layouts/head.jsp"/>
</head>

<style>

    .buttonColor {
        background-color: transparent;
    }

    .buttonColor:hover {
        background-color: #002F5D;
    }

    .buttonColor:active {
        background-color: #002F5D;
    }

    .buttonColor:hover img {
        filter: invert(100%);
    }

    .buttonColor:hover h5 {
        color: #ffffff;
    }

    .navbar.bg-body-tertiary {
        background-color: #002F5D !important; /* Reemplaza "your-color" con el color deseado */
    }

</style>

<body style="background-color: #D8EAE3;">

<nav class="navbar bg-body-tertiary fixed-top mb-5">
    <div class="container d-flex align-content-between">

        <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
            <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
               style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
        </div>

        <div>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas"
                    data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar"
                    aria-label="Toggle navigation" style="border-color: white">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>

        <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel" style="background-color: #002F5D">

            <div class="offcanvas-header">
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel" style="color: white;">ULTIMATE CUSTOME QUIZ</h5>
                <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
            </div>

            <div class="offcanvas-body">
                <ul class="navbar-nav justify-content-end flex-grow-1 pe-3">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#" style="color: white;"> Perfil </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#" style="color: white">Cerrar sesion </a>
                    </li>
                </ul>
            </div>

        </div>
    </div>
    <br>
    <br>
</nav>


<br><br>
<div class="container-fluid">
    <div class="row">
        <div class="col">
            <div class="col">
                <form class="d-flex justify-content-center mt-5" role="search">
                    <input class="form-control me-2 w-25 p-3  align-content-center " style="background-color: #D9D9D9;" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-5">

        <button  type="button" class="btn btn-outline-success btn-sm buttonColor"
                 data-bs-toggle="modal" data-bs-target="#ModalTeacher"
                 style="width: 200px; height: 100px; color: #002F5D" onclick="">
            <img style="height: 100px; width: 100px" src="../../assets/img/icons8-teacher-100.png" class="card-img-top" alt="...">
            <h5>Agregar profesores</h5>
        </button>

        <div class="col-3 col-md-2">
            <button  type="button" class="btn btn-outline-success btn-sm buttonColor"
                     data-bs-toggle="modal" data-bs-target="#ModalStudent"
                     style="width: 200px; height: 100px; color: #002F5D" onclick="">
                <img style="height: 100px; width: 100px" src="../../assets/img/icons8-student-100.png" class="card-img-top" alt="...">
                <h5>Agregar estudiantes</h5>
            </button>
            <br>
            <br>

    </div>


    <div class="row justify-content-center mt-5">
        <div class="col-10">
            <div class="card">
                <div class="card-header" style="background-color: #002F5D; text-align: center">
                    <div class="row">
                        <div class="col" style="color: white">Listado de usuarios</div>
                    </div>
                </div>
                <div class="card-body">
                    <table class="table table-stripped">
                        <thead>
                        <tr>
                            <th>Matricula</th>
                            <th>Nombre</th>
                            <th>CURP</th>
                            <th>status</th>
                            <th>Correo</th>
                            <th>Tipo de usuario</th>
                            <th>Acciones</th>
                        </tr>
                        </thead>
                        <thbody>
                            <c:forEach var="user" items="${users}" varStatus="s">
                                <tr>
                                    <td>
                                        <c:out value="${user.enrollment}"/>
                                    </td>
                                    <td>
                                        <c:out value="${user.name}"/> <br> <c:out value="${user.lastname}"/> <br> <c:out value="${user.surname}"/>
                                    </td>
                                    <td>
                                        <c:out value="${user.curp}"/>
                                    </td>
                                    <td>
                                        <c:out value="${user.status}"/>
                                    </td>
                                    <td>
                                        <c:out value="${user.mail}"/>
                                    </td>
                                    <td>
                                        <c:out value="${user.type_user}"/>
                                    </td>
                                    <td>
                                        <form method="get" action="/user/user-view-update">
                                            <input hidden value="${user.id}" name="id">
                                            <button type="button" class="btn btn-outline-warning btn-sm"
                                                    data-bs-toggle="modal" data-bs-target="#EditUser">
                                                Editar
                                            </button>
                                        </form>
                                        <form method="post" action="/user/delete">
                                            <input hidden value="${user.id}" name="id">
                                            <button type="submit" class="btn btn-outline-danger btn-sm">
                                                Eliminar
                                            </button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <tr>
                                <td colspan="6">
                                    SIn registros
                                </td>
                            </tr>
                        </thbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

        <div class="modal fade" id="ModalTeacher" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel"> Nuevo profesor </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="teacherForm" class="needs-validation" novalidate action="/user/save-teacher" method="post">
                            <div class="row">
                                <div class="col">
                                    <label for="name" class="fw-bold col-form-label">Nombre:</label>
                                    <input type="text" name="name" id="name" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="lastname" class="fw-bold col-form-label">Apellido Paterno:</label>
                                    <input type="text" name="lastname" id="lastname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surname" class="fw-bold col-form-label">Apellido Materno:</label>
                                    <input type="text" name="surname" id="surname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <label for="enrollment" class="fw-bold col-form-label">Matricula:</label>
                                        <input type="text"  name="enrollment" id="enrollment" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="curp" class="fw-bold">Curp:</label>
                                        <input type="text" name="curp" id="curp" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="mail" class="fw-bold">Correo:</label>
                                        <input type="email" name="  mail" id="mail" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <label for="password" class="fw-bold">Contraseña:</label>
                                        <input type="text" name="password" id="password" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar </button>
                        <button type="button" id="SaveTeacher" class="btn btn-primary" onclick="validateForm()">Guardar</button>
                    </div>
                        </form>

                </div>
            </div>
        </div>


        <!-- ---------------------------------------- SECCIÓN DE EDITAR EL USUARIO -------------------------------------------------------- -->

        <div class="modal fade" id="ModalStudent" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel2"> Nuevo estudiante </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form id="studentForm" class="needs-validation" novalidate action="/user/save-student" method="post">
                            <div class="row">

                                <div class="col">
                                    <label for="name" class="fw-bold col-form-label">Nombre:</label>
                                    <input type="text" name="name" id="name" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="lastname" class="fw-bold col-form-label">Apellido Paterno:</label>
                                    <input type="text" name="lastname" id="lastname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surname" class="fw-bold col-form-label">Apellido Materno:</label>
                                    <input type="text" name="surname" id="surname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <label for="enrollment" class="fw-bold col-form-label">Matricula:</label>
                                        <input type="text" name="enrollment" id="enrollment" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="curp" class="fw-bold">Curp:</label>
                                        <input type="text" name="curp" id="curp" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>

                                <div class="col">
                                    <label for="mail" class="fw-bold">Correo :</label>
                                    <input type="email" name="mail" id="mail" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row" >
                                    <div class="col">
                                        <label for="password" class="fw-bold">Contraseña:</label>
                                        <input type="text" name="password" id="password" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                             </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar </button>
                        <button type="submit" id="SaveStudent" class="btn btn-primary" onclick="validateForm2()">Guardar</button>
                    </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="EditUser" tabindex="-1" aria-labelledby="exampleModalLabel3" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel3"> Editar usuario </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form class="needs-validation" novalidate action="/user/save-student" method="post">
                            <div class="row">

                                <div class="col">
                                    <label for="Editname" class="fw-bold col-form-label">Nombre:</label>
                                    <input type="text" name="Editname" id="Editname" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="Editlastname" class="fw-bold col-form-label">Apellido Paterno:</label>
                                    <input type="text" name="Editlastname" id="Editlastname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="Editsurname" class="fw-bold col-form-label">Apellido Materno:</label>
                                    <input type="text" name="Editsurname" id="Editsurname" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <label for="Editenrollment" class="fw-bold col-form-label">Matricula:</label>
                                        <input type="text" name="Editenrollment" id="Editenrollment" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="Editcurp" class="fw-bold">Curp:</label>
                                        <input type="text" name="Editcurp" id="Editcurp" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>

                                    <div class="col">
                                        <label for="EditMail" class="fw-bold">Correo :</label>
                                        <input type="email" name="EditMail" id="EditMail" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row" >
                                    <div class="col">
                                        <label for="Editpassword" class="fw-bold">Contraseña:</label>
                                        <input type="text" name="Editpassword" id="Editpassword" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="EditConfirmPassword" class="fw-bold">Confirmar contraseña:</label>
                                        <input type="text" name="EditConfirmPassword" id="EditConfirmPassword" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar </button>
                        <button type="submit" id="SaveEdit" class="btn btn-primary" onclick="validateFormEdit()">Guardar</button>
                    </div>
                    </form>

                </div>
            </div>
        </div>



    <jsp:include page="../../layouts/footer.jsp"/>
<script>

    function validateForm() {
        // Obtener los elementos del formulario mediante su ID
        var form = document.getElementById("teacherForm");
        var passwordInput = document.getElementById("password");
        var confirmPasswordInput = document.getElementById("ConfirmPassword");

        // Validar el formulario antes de enviarlo
        if (form.checkValidity() && passwordInput.value === confirmPasswordInput.value) {
            // Si el formulario es válido y las contraseñas coinciden, enviarlo al servidor
            form.submit();
        } else if (passwordInput.value !== confirmPasswordInput.value) {
            // Si las contraseñas no coinciden, mostrar un mensaje de error con SweetAlert2
            Swal.fire({
                icon: 'error',
                title: 'LAS CONTRASEÑAS NO COINCIDEN',
                text: 'Verifica que las contraseñas sean iguales.',
                timer: 2000
            });
            return false;
        } else {
            // Si el formulario no es válido, mostrar un mensaje de error con SweetAlert2
            Swal.fire({
                icon: 'error',
                title: 'COMPLETA TODOS LOS CAMPOS',
                text: 'Por favor, completa todos los campos requeridos.',
                timer: 2000
            });
            return false;
        }

        return true;
    }

    function validateFormStudent() {
        // Obtener los elementos del formulario mediante su ID
        var form = document.getElementById("ModalStudent");
        var passwordInput = document.getElementById("password2");
        var confirmPasswordInput = document.getElementById("ConfirmPassword2");

        // Validar el formulario antes de enviarlo
        if (form.checkValidity() && passwordInput.value === confirmPasswordInput.value) {
            // Si el formulario es válido y las contraseñas coinciden, enviarlo al servidor
            form.submit();
        } else if (passwordInput.value !== confirmPasswordInput.value) {
            // Si las contraseñas no coinciden, mostrar un mensaje de error con SweetAlert2
            Swal.fire({
                icon: 'error',
                title: 'LAS CONTRASEÑAS NO COINCIDEN',
                text: 'Verifica que las contraseñas sean iguales.',
                timer: 2000
            });
            return false;
        } else {
            // Si el formulario no es válido, mostrar un mensaje de error con SweetAlert2
            Swal.fire({
                icon: 'error',
                title: 'COMPLETA TODOS LOS CAMPOS',
                text: 'Por favor, completa todos los campos requeridos.',
                timer: 2000
            });
            return false;
        }

        return true;
    }
    function validateForm2() {
        // Obtener el formulario mediante su ID
        var form = document.getElementById("studentForm");
        // Validar el formulario antes de enviarlo
        if (form.checkValidity()) {
            // Si el formulario es válido, enviarlo al servidor
            form.submit();
        } else {
            // Si el formulario no es válido, mostrar un mensaje de error y evitar el envío
            alert("Por favor, completa todos los campos requeridos correctamente.");
        }
    }
    function changeButtonColorOnClick() {
        this.style.backgroundColor = '#002F5D';
    }

    // Función para cambiar la imagen a blanco cuando el puntero pasa sobre el botón
    function changeImageColor() {
        const image = this.querySelector('img');
        image.style.filter = 'invert(100%)';
    }

    // Función para restaurar el color original de la imagen cuando el puntero deja el botón
    function restoreImageColor() {
        const image = this.querySelector('img');
        image.style.filter = 'none';
    }

    // Agregar eventos para manejar los cambios de color a todos los botones con clase "buttonColor"
    const btns = document.querySelectorAll('.buttonColor');
    btns.forEach(btn => {
        btn.addEventListener('mouseover', changeImageColor);
        btn.addEventListener('mouseout', restoreImageColor);
    });

    // Función para restaurar el color de fondo original del botón cuando finaliza el clic
    function restoreButtonColor() {
        this.style.backgroundColor = 'transparent';
    }

    // Agregar eventos para manejar los cambios de color al hacer clic
    btns.forEach(btn => {
        btn.addEventListener('mousedown', changeButtonColorOnClick);
        btn.addEventListener('mouseup', restoreButtonColor);
        btn.addEventListener('mouseout', restoreImageColor); // Para restaurar el color de la imagen si el puntero sale del botón sin hacer clic
    });

</script>
</body>
</html>
