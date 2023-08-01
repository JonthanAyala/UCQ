<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 20/07/2023
  Time: 08:21 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Exam</title>
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
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
        <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
            <h3 class="text-center">Ultimate Custom Quiz</h3>
        </a>
        <a class="navbar-brand position-absolute top-0 end-0">
            <img src="../../assets/img/icons8-volver-48.png"  width="50" height="50">
        </a>
        <br><br>
    </div>
</nav>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="container mt-5 bg-light p-4 rounded shadow">
            <h1 class="text-center mb-4">Examen Recupera</h1>
        </div>
    </div>
</div>


<div class="row row justify-content-center">
    <div class="col-md-6">
        <div class="container mt-5 bg-light p-4 rounded shadow">
            <div class="pregunta p-4 border rounded">
                <h2>Pregunta 1:</h2>
                <p>¿Cuánto es 2 + 2?</p>

                <form>
                    <div class="form-check">
                        <input class="form-check-input custom-radio" type="radio" name="pregunta1" id="radio1" value="1">
                        <label class="form-check-label" for="radio1">1</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input custom-radio" type="radio" name="pregunta1" id="radio2" value="2">
                        <label class="form-check-label" for="radio2">2</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input custom-radio" type="radio" name="pregunta1" id="radio3" value="3">
                        <label class="form-check-label" for="radio3">Pez</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input custom-radio" type="radio" name="pregunta1" id="radio4" value="4">
                        <label class="form-check-label" for="radio4">Todas las anteriores</label>
                    </div>

                <style>
                        /* Estilo personalizado para los círculos de selección */
                        .custom-radio {
                            width: 1.2rem; /* Ajusta el tamaño del círculo según sea necesario */
                            height: 1.2rem; /* Ajusta el tamaño del círculo según sea necesario */
                            background-color: transparent; /* Quita el fondo por defecto del círculo */
                            border-radius: 50%; /* Hace que el círculo tenga forma redondeada */
                        }

                        /* Estilo personalizado para el círculo cuando está seleccionado */
                        .custom-radio:checked {
                            background-color: #28a745; /* Cambia el color de fondo a verde cuando está seleccionado */
                        }

                    </style>

                        </form>
            </div>
        </div>
    </div>
</div>
<div class="d-flex justify-content-center mt-3">
    <button type="submit" class="btn btn-success">
        ENVIAR
    </button>
</div>

</body>

<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
