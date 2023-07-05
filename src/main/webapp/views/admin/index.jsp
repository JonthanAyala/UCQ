<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 18/06/2023
  Time: 07:10 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Inicio Admin</title>
    <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3;">
<nav class="navbar navbar-expand-lg bg-body-tertiary"   >
    <div class="container-fluid h-20 d-inline-block" style="width: 120px;" >
        <a class="navbar-brand position-absolute top-50 start-50 translate-middle"><h3 class="text-center"  >Ultimate Custom Quiz</h3></a>
        <a class="navbar-brand position-absolute top-0 end-0">
            <img src="/docs/5.3/assets/brand/bootstrap-logo.svg" alt="Bootstrap" width="30" height="24">
        </a>
        <br><br>
    </div>
</nav>
<br><br>
<div class="input-group">

        <input class="form-control me-2 w-25 p-3 position-absolute top-40 start-50 translate-middle-x " style="background-color: #D9D9D9;" type="search" placeholder="Buscar usuario" aria-label="Search">
        <button class="btn btn-outline-success me-2 " type="submit">Search</button>

</div>

<br><br>
<div>
    <div class="row">
        <div class="col">
            <div class="row row-cols-1 row-cols-md-2 g-4 w-25 p-3 position-absolute top-25 start-50 translate-middle-x">
                <div class="col">
                    <div class="card">
                        <img src="..." class="card-img-top" alt="...">
                        <div class="card-body ">
                            <h5 class="card-title">Crear profesores</h5>
                            <p class="card-text"> </p>
                        </div>
                    </div>
                </div>
                <div class="col">
                    <div class="card">
                        <img src="..." class="card-img-top" alt="...">
                        <div class="card-body">
                            <h5 class="card-title">Crear alumno</h5>
                            <p class="card-text"></p>
                        </div>
        </div>
    </div>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
</body>
</html>
