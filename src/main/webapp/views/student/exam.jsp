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

<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
    <div class="container d-flex align-content-between">

        <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
            <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
               style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
        </div>

        <div>
            <button type="button" class="btn" style="background-color: transparent; border: transparent" onclick="redirectToStudentsIndex()">
                <img src=" ${pageContext.request.contextPath}/assets/img/back-48.png">
            </button>
        </div>

        <br><br>
    </div>
</nav>

<div class="row justify-content-center">
    <div class="col-md-6">
        <div class="container mt-5 bg-light p-4 rounded shadow">
            <h1 class="text-center mb-4">${exam.name_exam}</h1>
        </div>
    </div>
</div>

<div class="row justify-content-center" id="question-container">
    <!-- Aquí se insertarán las cards de preguntas -->
</div>

<form action="/exam/enviar">
<div class="d-flex justify-content-center mt-3">
    <button type="submit" class="btn btn-success">
        ENVIAR
    </button>
</div>
</form>


<jsp:include page="../../layouts/footer.jsp"/>

<script>

    var id_student_exam = null;

    var IDsQ = [];

    $.ajax({
        type: "POST",
        url: "/exam/IdsQ",
        data: {
            "idExam": ${exam.id_exam}
        },
        success: function (response) {
            if (response !== null && Array.isArray(response)) {
                IDsQ = response.map(Number);
                console.log("IDs de preguntas en arreglo IDQ:", IDsQ);

                // Aquí puedes hacer lo que necesites con el arreglo IDQ
            } else {
                console.log("La respuesta JSON es inválida.");
            }
        },
        error: function (xhr, status, error) {
            console.log("Error en la solicitud AJAX:", error);
        },
    });


    $.ajax({
        type: "POST",
        url: "/exam/create-studen-exam",
        data: {
            "idExaID": ${exam.id_exam},
            "fk_user": ${sessionScope.user.id}
        },
        success: function (response) {
            id_student_exam = response
            console.log("i.s.t :"+id_student_exam)
        },
        error: function (xhr, status, error) {
            console.log("Error en la solicitud AJAX:", error);
        },
    });


    $.ajax({
        type: "POST",
        url: "/exam/contrucQuestions",
        data: {
            "IDs": IDsQ
        },
        success: function (response) {
            x
        },
        error: function (xhr, status, error) {
            console.log("Error en la solicitud AJAX:", error);
        },
    });

    // Supongamos que 'questions' es el objeto obtenido a través de AJAX
    var questions = [
        {
            question: "Pregunta 1:",
            description: "Descripcion-1",
            options: ["1", "2", "Pez", "Todas las anteriores"]
        },
        // ... otras preguntas
    ];

    var questionContainer = document.getElementById("question-container");

    // Iterar a través de las preguntas y construir las cards
    questions.forEach(function(questionObj, index) {
        var card = document.createElement("div");
        card.className = "col-md-6";

        var cardContent = `
            <div class="container mt-5 bg-light p-4 rounded shadow">
                <div class="pregunta p-4 border rounded">
                    <h2>${questionObj.question}</h2>
                    <p>${questionObj.description}</p>
                    <form>
        `;

        questionObj.options.forEach(function(option, optionIndex) {
            cardContent += `
                <div class="form-check">
                    <input class="form-check-input custom-radio" type="radio" name="pregunta${index}" id="radio${index}-${optionIndex}" value="${optionIndex + 1}">
                    <label class="form-check-label" for="radio${index}-${optionIndex}">${option}</label>
                </div>
            `;
        });

        cardContent += `
                    <style>
                        /* Estilo personalizado para los círculos de selección */
                        .custom-radio {
                            width: 1.2rem;
                            height: 1.2rem;
                            background-color: transparent;
                            border-radius: 50%;
                        }

                        /* Estilo personalizado para el círculo cuando está seleccionado */
                        .custom-radio:checked {
                            background-color: #28a745;
                        }
                    </style>
                    </form>
                </div>
            </div>
        `;

        card.innerHTML = cardContent;
        questionContainer.appendChild(card);
    });




    function redirectToStudentsIndex() {
        window.location.href ="${pageContext.request.contextPath}/user/student";
    }
</script>
</body>
</html>
