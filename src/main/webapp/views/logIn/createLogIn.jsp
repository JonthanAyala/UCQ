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

    .circulo {

        position:relative;
        width: 500px;
        height: 500px;
        -moz-border-radius: 50%;
        -webkit-border-radius: 50%;
        border-radius: 50%;
        background:  #002F5D;
    }

</style>

<body style="background-color: #D8EAE3;">


<div class="centrado mt-5">

    <div class="row align-items-stretch">

        <h2>
            <span style="color: #00AA83;">ULTIMATE CUSTOME</span> <span style="color: #002F5D;"> QUIZ</span>
        </h2>

    </div>
</div>

<div class="position-relative">
    <div class="position-absolute top-0 start-0 translate-middle">

        <div class="container">
            <div class="circulo">

            </div>
        </div>

    </div>
</div>


<div class="container  mt-5 centrado align-items-stretch">
    <div class="col-4">
        <div class="card">
            <div class="card-header" style=" background-color:  #002F5D; text-align: center">
                <h5 style="color: white"> Inicio de sesión </h5>
            </div>

            <div class="card-body">

                <form action="login" method="post">

                    <tr style="background-color: white;">
                        <th style="border: 2px solid #374b43;">
                            <div class="form-outline ">
                                <input name="user/user" type="text" class="form-control" style="background-color: #D9D9D9;" required/>
                                <label class="form-label"> Usuario </label>
                            </div>

                            <div class="form-outline">
                                <input name="passwordUser" type="password" class="form-control" style="background-color: #D9D9D9;" required/>
                                <label class="form-label"> Contraseña </label>
                            </div>

                        </th>

                    </tr>
                </form>

                <h6 style="color: #002F5D" href=""> ¿olvidaste tu contraseña? </h6>
                <div class="card-footer">

                    <div class="d-grid ">

                        <button type="submit" class="btn btn-primary btn-block " value="login" style="background-color: #00AA83 !important;">
                            <h6 class="mt-2 mb-2"> Iniciar sesion </h6>
                        </button>

                    </div>

                </div>
            </div>
        </div>
    </div>
</div>



<jsp:include page="../../layouts/footer.jsp"/>

</body>
</html>
