<%--
  Created by IntelliJ IDEA.
  User: axelj_7
  Date: 11/07/2023
  Time: 10:12 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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


        <div class="container p-3">
            <div class="container mt-5 w-75 p-3" style="background-color: white">

                <div id="questions-container">

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
