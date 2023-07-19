<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>logIn</title>
    <jsp:include page="../../layouts/head.jsp"/>

</head>

<style>
    .centrado{
        display: grid;
        place-items: center;
    }

</style>

<body style="background-color: #99b0a7;">

<div class="centrado mt-5">

    <div class="row align-items-stretch">

        <h2>
            <span style="color: #00AAB3;">ULTIMATE CUSTOME</span> <span style="color: #006cb0;"> QUIZ</span>
        </h2>

    </div>
</div>


<div class="container mt-5 centrado">

    <div class="row align-items-stretch">

        <div class="col-md-5">

            <div>

                <div style="width: 516px; height: 328px;" class="centrado">

                    <table class="table">
                        <thead>
                        <tr style="background-color: #D9D9D9;">
                            <th style="border: 2px solid #374b43; text-align: center;"> INICIO DE SESIÓN</th>
                        </tr>
                        </thead>

                        <tbody>
                        <tr>
                            <form action="/user/login" class="needs-validation" novalidate method="post">

                                <tr style="background-color: white;">
                                    <th style="border: 2px solid #374b43;">
                                        <div class="form-outline ">
                                            <input id="user" name="user" type="text" class="form-control" style="background-color: #D9D9D9;" required/>
                                            <label for="user" class="form-label"> Correo </label>
                                        </div>


                                        <div class="form-outline">
                                            <input id="passwordUser" name="passwordUser" type="password" class="form-control" style="background-color: #D9D9D9;" required/>
                                            <label for="passwordUser" class="form-label"> Contraseña </label>
                                        </div>

                                    </th>

                                </tr>
                                <tr style="background-color: white;">
                                    <th style="border: 2px solid #374b43;">
                                        <div class="row ">
                                            <div class="col d-flex justify-content-center "> </div>
                                        </div>

                                        <div class="d-grid mt-3">

                                            <button type="submit" class="btn btn-primary btn-block mb-3 " value="login"> log in </button>

                                        </div>

                </th>
                </tr>
                </form>

                </tr>
                </tbody>

                </table>


            </div>


        </div>

    </div>

</div>



</div>
<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
