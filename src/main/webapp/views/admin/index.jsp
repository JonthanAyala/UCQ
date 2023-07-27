<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>Inicio Admin</title>
    <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3;">
<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
        <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
            <h3 class="text-center">Ultimate Custom Quiz</h3>
        </a>
        <br><br>
    </div>
</nav>

<br><br>
<div class="container-fluid">
    <div class="row">
        <div class="col">
            <div class="col">
                <form class="d-flex justify-content-center" role="search">
                    <input class="form-control me-2 w-25 p-3  align-content-center " style="background-color: #D9D9D9;" type="search" placeholder="Search" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Search</button>
                </form>
            </div>
        </div>
    </div>

    <div class="row justify-content-center mt-5">

        <button  type="button" class="btn btn-outline-success btn-sm"
                 data-bs-toggle="modal" data-bs-target="#ModalTeacher"
                 style="width: 200px; height: 100px" onclick="">
            <img style="height: 100px; width: 100px" src="../../assets/img/icons8-teacher-100.png" class="card-img-top" alt="...">
            <h5>Agregar profesores</h5>
        </button>

        <div class="col-3 col-md-2">
            <button  type="button" class="btn btn-outline-success btn-sm"
                     data-bs-toggle="modal" data-bs-target="#ModalStudent"
                     style="width: 200px; height: 100px" onclick="">
                <img style="height: 100px; width: 100px" src="../../assets/img/icons8-student-100.png" class="card-img-top" alt="...">
                <h5>Agregar estudiantes</h5>
            </button>
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
                                        <c:out value="${user.name}"/> <br> <c:out value="${user.surname}"/>
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
                                            <button type="submit" class="btn btn-outline-warning btn-sm">
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
                        <form>
                            <div class="row">
                                <div class="col">
                                    <label for="name" class="fw-bold col-form-label">Nombre:</label>
                                    <input type="text" name="name" id="name" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surnameP" class="fw-bold col-form-label">Apellido Paterno:</label>
                                    <input type="text" name="surnameP" id="surnameP" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surnameM" class="fw-bold col-form-label">Apellido Materno:</label>
                                    <input type="text" name="surnameM" id="surnameM" class="form-control" required>
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
                                        <input type="text" name="surname" id="curp" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="email" class="fw-bold">Correo:</label>
                                        <input type="email" name="email" id="email" class="form-control" required>
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

                                    <div class="col">
                                        <label for="ConfirmPassword" class="fw-bold">Confirmar contraseña:</label>
                                        <input type="text" name="ConfirmPassword" id="ConfirmPassword" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                            </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar </button>
                        <button type="button" id="SaveTeacher" class="btn btn-primary" onclick="savePasswordTeacher()">Guardar</button>
                    </div>
                </div>
            </div>
        </div>



        <div class="modal fade" id="ModalStudent" tabindex="-1" aria-labelledby="exampleModalLabel2" aria-hidden="true">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalLabel2"> Nuevo estudiante </h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form>
                            <div class="row">

                                <div class="col">
                                    <label for="name2" class="fw-bold col-form-label">Nombre:</label>
                                    <input type="text" name="name2" id="name2" class="form-control" required/>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surnameP2" class="fw-bold col-form-label">Apellido Paterno:</label>
                                    <input type="text" name="surnameP2" id="surnameP2" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                <div class="col">
                                    <label for="surnameM2" class="fw-bold col-form-label">Apellido Materno:</label>
                                    <input type="text" name="surnameM2" id="surnameM2" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>

                            </div>

                            <div class="form-group mb-3">
                                <div class="row">
                                    <div class="col">
                                        <label for="enrollment" class="fw-bold col-form-label">Matricula:</label>
                                        <input type="text" name="enrollment" id="enrollment2" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="curp" class="fw-bold">Curp:</label>
                                        <input type="text" name="surname" id="curp2" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>

                                <div class="col">
                                    <label for="email2" class="fw-bold">Correo :</label>
                                    <input type="email" name="email2" id="email2" class="form-control" required>
                                    <div class="invalid-feedback">Campo obligatorio</div>
                                </div>
                                </div>
                            </div>

                            <div class="form-group mb-3">
                                <div class="row" >
                                    <div class="col">
                                        <label for="password" class="fw-bold">Contraseña:</label>
                                        <input type="text" name="password" id="password2" class="form-control" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                    <div class="col">
                                        <label for="ConfirmPassword2" class="fw-bold">Confirmar contraseña:</label>
                                        <input type="text" name="ConfirmPassword2" id="ConfirmPassword2" class="form-control col-form-label" required>
                                        <div class="invalid-feedback">Campo obligatorio</div>
                                    </div>
                                </div>
                             </div>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Cancelar </button>
                        <button type="button" id="SaveStudent" class="btn btn-primary" onclick="savePasswordStudent()">Guardar</button>
                    </div>
                </div>
            </div>
        </div>


<jsp:include page="../../layouts/footer.jsp"/>
<script>

    const exampleModal = document.getElementById('ModalTeacher')
    if (exampleModal) {
        exampleModal.addEventListener('show.bs.modal', event => {
            // Button that triggered the modal
            const button = event.relatedTarget
            // Extract info from data-bs-* attributes
            const recipient = button.getAttribute('data-bs-whatever')
            // If necessary, you could initiate an Ajax request here
            // and then do the updating in a callback.

            // Update the modal's content.
            const modalTitle = exampleModal.querySelector('.modal-title')
            const modalBodyInput = exampleModal.querySelector('.modal-body input')

            modalTitle.textContent = `New message to ${recipient}`
            modalBodyInput.value = recipient
        })
    }

    function confirmPasswordTeacher() {
        // Obtener el valor de las contraseñas
        const newPassword = document.getElementById('password').value;
        const confirmNewPassword = document.getElementById('ConfirmPassword').value;

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

    function confirmPasswordStudent() {
        // Obtener el valor de las contraseñas
        const newPassword = document.getElementById('password2').value;
        const confirmNewPassword = document.getElementById('ConfirmPassword2').value;

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

    function savePasswordTeacher() {
        // Llamar a confirmPassword() para verificar las contraseñas antes de guardar
        if (!confirmPasswordTeacher()) {
            return;
        }
    }
    // Agregar el evento de clic al botón "Guardar Contraseña"
    document.getElementById('SaveTeacher').addEventListener('click', savePasswordTeacher);

    function savePasswordStudent() {
        // Llamar a confirmPassword() para verificar las contraseñas antes de guardar
        if (!confirmPasswordStudent()) {
            return;
        }
    }
    // Agregar el evento de clic al botón "Guardar Contraseña"
    document.getElementById('SaveStudent').addEventListener('click', savePasswordStudent);

</script>
</body>
</html>
