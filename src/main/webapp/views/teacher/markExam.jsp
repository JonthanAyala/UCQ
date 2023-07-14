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

    .navbar.bg-body-tertiary {
        background-color: #002F5D !important; /* Reemplaza "your-color" con el color deseado */
    }

</style>

<body style="background-color: #D8EAE3">

<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
        <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
            <h3 class="text-center">Ultimate Custom Quiz</h3>
        </a>
        <a class="navbar-brand position-absolute top-0 end-0">
            <img src="/docs/5.3/assets/brand/bootstrap-logo.svg" alt="Bootstrap" width="30" height="24">
        </a>
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
</body>
</html>
