<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>logIn</title>
    <jsp:include page="../../layouts/head.jsp"/>

</head>
<body style="accent-color: #D9D9D9;">

<form>

    <div class="form-outline mb-4">
        <input type="text" class="form-control"/> <%--falta el id para la conexión con matricula y email--%>
        <label class="form-label"> Usuario </label> <%-- alta el atributo for para almacenar el usuario en id--%>
    </div>

    <div class="form-outline mb-4">
        <input type="password" class="form-control"/>
        <label class="form-label"> Contraseña </label> <%--LO MISMO QUE EL LA PARTE DEL USUARIO --%>
    </div>

    <div class="row mb-4">
        <div class="col d-flex justify-content-center"> </div>
    </div>

    <button type="button" class="btn btn-primary btn-block mb-4"> log in </button>




</form>



</div>
<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
