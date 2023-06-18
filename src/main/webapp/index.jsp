<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>Usuarios</title>
  <jsp:include page="./layouts/head.jsp"/>
</head>
<body>
<div class="container-fluid">
  <div class="row">
    <div class="col text-center mt-5">
      <a href="user/users">Usuarios</a>
      <a href="user/prueba2">Alumnos</a>
    </div>
  </div>
</div>
<jsp:include page="./layouts/footer.jsp"/>
</body>
</html>