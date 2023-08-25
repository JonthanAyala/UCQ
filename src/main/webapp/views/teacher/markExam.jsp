<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Calificar Examen</title>
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

    <div class="d-flex">
        <div class="container col-xl-4 vh-100" style="text-align: right; background-color: #00AA83">
            <div class="card" style="background-color: #00AA83; border-color: #00AA83">
                <div class="card-header">
                    <h5 class="text-center" style="color: white"> ESTUDIANTE </h5>
                </div>
                <div class="card-body">
                    <table class="table table-stripped">
                        <tbody>
                        <td>

                        </td>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="container mt-5 bg-light p-4 rounded shadow">
                <h1 class="text-center mb-4">${exam.name_exam}</h1>
            </div>
        </div>
                <div id="questions-container">
                    <c:set var="position" value="0" scope="request" />
                    <c:forEach var="question" items="${questions}" varStatus="s">
                        <div class="" id="question-container">
                            <div class="col-md-6">
                                <div class="container mt-5 bg-light p-4 rounded shadow">
                                    <div class="pregunta p-4 border rounded">
                                        <h2><c:out value="${question.description}" /></h2>
                                        <form>
                                            <c:choose>
                                                <c:when test="${question.type_question == 2}">
                                                    <c:forEach var="answer" items="${question.answer}" varStatus="as">
                                                        <div class="form-check">
                                                            <input class="form-check-input custom-radio"  type="radio" name="pregunta${s.index}" id="radio${s.index}-${as.index}" value="${as.index + 1}"
                                                                   onchange="answerClose(${answer.id_answer},${question.id_question},${id_Student_Exam},${position})">
                                                            <label class="form-check-label" for="radio${s.index}-${as.index}">
                                                                <c:out value="${answer.answer}" />
                                                            </label>
                                                        </div>

                                                    </c:forEach>
                                                </c:when>
                                                <c:when test="${question.type_question == 1}">
                                                    <textarea class="form-control" name="pregunta${s.index}" id="textarea${position}" rows="4" onfocusout="answerOpen(${question.id_question},${id_Student_Exam},${position})"></textarea>
                                                </c:when>
                                            </c:choose>
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
                            </div>
                        </div>
                        <c:set var="position" value="${position + 1}" scope="request" />
                    </c:forEach>

                </div>
            </div>
        </div>


    </div>

<jsp:include page="../../layouts/footer.jsp"/>

<script>
    function redirectToTeacherIndex() {
        window.location.href = "${pageContext.request.contextPath}/user/index-teacher";
    }
</script>
</body>
</html>
