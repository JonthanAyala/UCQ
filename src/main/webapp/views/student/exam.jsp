<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
<c:forEach var="question" items="${questions}" varStatus="s">
    <div class="row justify-content-center" id="question-container">
        <div class="col-md-6">
            <div class="container mt-5 bg-light p-4 rounded shadow">
                <div class="pregunta p-4 border rounded">
                    <h2><c:out value="${question.description}" /></h2>
                    <form>
                        <c:choose>
                            <c:when test="${question.type_question == 2}">
                                <c:forEach var="answer" items="${question.answer}" varStatus="as">
                                    <div class="form-check">
                                        <input class="form-check-input custom-radio" type="radio" name="pregunta${s.index}" id="radio${s.index}-${as.index}" value="${as.index + 1}">
                                        <label class="form-check-label" for="radio${s.index}-${as.index}">
                                            <c:out value="${answer.answer}" />
                                        </label>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:when test="${question.type_question == 1}">
                                <textarea class="form-control" name="pregunta${s.index}" rows="4"></textarea>
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
</c:forEach>

<form action="/exam/enviar">
<div class="d-flex justify-content-center mt-3">
    <button type="submit" class="btn btn-success">
        ENVIAR
    </button>
</div>
</form>


<jsp:include page="../../layouts/footer.jsp"/>

<script>

    function redirectToStudentsIndex() {
        window.location.href ="${pageContext.request.contextPath}/user/student";
    }


</script>
</body>
</html>
