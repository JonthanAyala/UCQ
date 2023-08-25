<%--
  Created by IntelliJ IDEA.
  User: angry
  Date: 20/07/2023
  Time: 08:27 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <jsp:include page="../../layouts/head.jsp"/>
</head>
<body style="background-color: #D8EAE3;">

<nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
  <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
    <a class="navbar-brand position-absolute top-50 start-50 translate-middle" style="color: white;">
      <h3 class="text-center">Ultimate Custom Quiz</h3>
    </a>
    <a class="navbar-brand position-absolute top-0 end-0">
      <img src=" ${pageContext.request.contextPath}/docs/5.3/assets/brand/bootstrap-logo.svg" alt="Bootstrap" width="30" height="24">
    </a>
    <br><br>
  </div>
</nav>


<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
