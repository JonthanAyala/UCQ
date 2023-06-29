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
<div class="card position-absolute top-50 start-50 translate-middle" style="width: 18rem;">
  <ul class="list-group list-group-flush">
    <li class="list-group-item"><a href="user/users">Usuarios</a></li>
    <li class="list-group-item"><a href="exam/exams">Pruebas</a></li>
    <li class="list-group-item"><a href="user/teacher">Examen</a></li>
     <li class="list-group-item"><a href="user/student">Alumnos</a></li>
     <li class="list-group-item"><a href="user/admin">Admin</a></li>
  </ul>
    </div>
  </div>
</div>
<jsp:include page="./layouts/footer.jsp"/>
</body>
</html>