<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Examen</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/path/to/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="../../layouts/head.jsp"/>
</head>

<style>

    .navbar-color{
        background-color: #002F5D;
    }

    .navbar-input{
        border: solid #002F5D;
    }

    .placeholder-name-exam {
        color: #D8EAE3;
        font-size: 1.5em;
    }

    .card-color{
        border: solid #ffffff;
    }

    .card-header-color{

        border: solid #ffffff;
    }

    .answer-container{
        display: inline-block;
        min-width: 500px;
    }

    .input-high-size {
        white-space: pre-wrap;
        overflow-wrap: break-word;
    }

    .containerExam {

        margin-top: 3cm !important;
    }

    .textareaTittle {
        /* Establecer una altura mínima inicial */
        height: 1em;

        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }

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

<div class="overflow-hidden fixed-top">
    <nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
        <div class="container d-flex align-content-between">

            <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
                <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
                   style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
            </div>

            <div>
                <button type="button" class="btn" style="background-color: transparent; border: transparent"
                        onclick=" Swal.fire({
            title: '¿Deseas guardar los cambios?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'Guardar',
            denyButtonText: `No guardar`,
        }).then((result) => {

            if (result.isConfirmed) {
                Swal.fire('EXAMEN GUARDADO', '', 'success')
                //LA ALERTA APARECERÁ EN CASO DE QUE APRETEN EL BOTON DE REGRESAR Y NO SE HAYAN GUARDADOS LOS CAMBIOS
                //REDIRIGIR A LA PAGINA PRINCIPAL CON LOS CAMBIOS GUARDADOS
            } else if (result.isDenied) {
               //REDIRIGIR SOLAMENTE A LA PAGINA PRINCIPAL
            }
        })">
                    <img src="../../assets/img/back-48.png">
                </button>
            </div>

            <br><br>
        </div>
    </nav>
</div>

<form action="/path/to/save-exam.jsp" method="post">
<div class="d-flex">
    <div class="container col-xl-4 vh-100 m-0 sticky-top"
         style="text-align: left; background-color: #00AA83;">

        <br>
        <br>


            <div class="d-grid">
                <button type="button" class="btn mt-5" onclick="addQuestionClose()" style="background-color: #d9d9d9" >
                    Opción multiple
                    <img src="../../assets/img/icons8-add-48.png">
                </button>
                <button type="button" class="btn mt-5" onclick="addQuestionOpen()" style="background-color: #d9d9d9" >
                    Respuesta abierta
                    <img src="../../assets/img/icons8-add2-48.png">
                </button>
            </div>


        <div class=" container mt-5 col-4" style="text-align: center">
            <div class="form-group">
                <label for="exam-code" class="placeholder-name-exam"> <h6> Código del examen:</h6> </label>
                <input type="text" class="form-control" id="exam-code" style="background-color:#D9D9D9;" readonly>
            </div>
        </div>

        <div class="container mb-5">
            <div class=" container mt-5 mb-5 d-grid" style="text-align: center">
                <button id="guardarButton" type="submit" class="btn btn-success" style="background-color: #002F5D!important;
                color: white !important;" onclick="marcarCambiosYCambiarColor()">Guardar</button>
            </div>
        </div>
    </div>


    <div class="container mt-5 w-50 p-3 containerExam mb-5" style="background-color: white;
    box-shadow: 0 0 8px rgba(0, 170, 131, 0.3);">

        <div class="container-fluid mt-5">
        <textarea class="form-control textareaTittle" name="nameExam"
                  style="font-size: 30px; overflow: hidden; resize: none"
                  maxlength="50" oninput="autoResize(this)"
                  placeholder="Titulo Examen" required></textarea>
        </div>

        <div id="questions-container" class="overflow-y-auto">

        </div>
    </div>
</div>
</form>


<jsp:include page="../../layouts/footer.jsp"/>
<script>

    var generarId = 0;

    function addQuestionClose() {
        var questionContainer = document.getElementById("questions-container");

        generarId++;
        console.log(generarId);
        var card = document.createElement("div");
        card.className = "card mt-3 card-color";
        card.id = "card-" + generarId;

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header card-header-color";

        var cardTitle = document.createElement("h5");
        cardTitle.className = "card-title";
        cardTitle.innerHTML = "Opción multiple";


        cardHeader.appendChild(cardTitle);

        var cardBody = document.createElement("div");
        cardBody.className = "card-body";

        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var scoreGroup = document.createElement("div");
        scoreGroup.className = "form-group col-md-1 col-lg-2";
        //Label para la puntuacion
        var scoreLabel = document.createElement("label");
        scoreLabel.setAttribute("for", "question-score");
        scoreLabel.innerHTML = "Puntaje:";

        var scoreInput = document.createElement("input");
        scoreInput.className = "form-control";
        scoreInput.setAttribute("type", "number");
        scoreInput.setAttribute("value", 0);
        scoreInput.setAttribute("max", 10);
        scoreInput.setAttribute("min", 0);
        scoreInput.setAttribute("id", "question-score");
        scoreInput.setAttribute("name", "question-score");
        scoreInput.addEventListener("input", function () {
            if (this.value.length > 2)
                this.value = this.value.slice(0, 2);
        });
        scoreInput.addEventListener("input", function () {
            if (this.value > 10)
                this.value = 10;
        });
        scoreInput.addEventListener("input", function () {
            if (this.value < 0)
                this.value = 0;
        });

        scoreGroup.appendChild(scoreLabel);
        scoreGroup.appendChild(scoreInput);
        cardBody.appendChild(scoreGroup);
        // no se que sea apeenchild
        //
        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "closed-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.style.resize = "none";
        questionTextarea.contentEditable = "true";
        questionTextarea.maxLength = 255;
        questionTextarea.setAttribute("id", "closed-question");
        questionTextarea.setAttribute("name", "closed-question");
        questionTextarea.style.overflow = "hidden";
        questionTextarea.addEventListener("input", resizeInput);
        questionTextarea.addEventListener("keyup", resizeInput);
        function resizeInput() {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var answerContainer = document.createElement("div");
        answerContainer.setAttribute("id", "answer-container");

        var divButtons = document.createElement("div");
        divButtons.className = "form-group";

        var addButton = document.createElement("button");
        addButton.className = "btn btn-primary mt-2";
        addButton.setAttribute("type", "button");
        addButton.innerHTML = "Agregar Respuesta";
        addButton.addEventListener("click", function () {
            addAnswerClose(card.id);
        });

        var divRemoveQuestion = document.createElement("div");
        divRemoveQuestion.className = "form-group";
        divRemoveQuestion.style = "text-align: right";

        var removeQuestion = document.createElement("button");
        removeQuestion.className = "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function () {
            deleteQuestion(card.id);
        });

        divRemoveQuestion.appendChild(removeQuestion);

        divButtons.appendChild(addButton);
        divRemoveQuestion.appendChild(removeQuestion);
        divButtons.appendChild(divRemoveQuestion);

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(answerContainer);
        cardBody.appendChild(divButtons);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });

    }


    function addAnswerClose(cardId) {
        var answerContainer = document.getElementById("answer-container");
        var card = document.getElementById(cardId);

        var answerGroup = document.createElement("div");
        answerGroup.className = "form-group align-items-center";
        answerGroup.setAttribute("data-card-id", cardId);
        console.log("respuesta"+cardId);
        var divInputGroup = document.createElement("div");
        divInputGroup.className="input-group-text  mb-2 input-group-sm mt-2 col-6";

        var divInputGroupText = document.createElement("div");
        divInputGroupText.className = "input-group-text ";

        var inputCheckbox = document.createElement("input");
        inputCheckbox.className = "form-check-input mt-0";
        inputCheckbox.type = "checkbox";
        inputCheckbox.value = "";
        inputCheckbox.setAttribute("aria-label", "correctAnswer");
        inputCheckbox.setAttribute("name", "correct-answer");

        divInputGroupText.appendChild(inputCheckbox);


        var answerInput2 = document.createElement("textarea");
        answerContainer.setAttribute("id", "answer-container");
        answerInput2.className ="form-control input-high-size"
        answerInput2.setAttribute("aria-label", "correctAnswer");
        answerInput2.maxLength = 255;
        answerInput2.setAttribute("name", "answer");
        answerInput2.setAttribute("placeholder", "Respuesta");
        answerInput2.style.resize = "none";
        answerInput2.rows = 1;
        answerInput2.required = true;
        answerInput2.style.overflow = "hidden";
        answerInput2.addEventListener("input", resizeInput);
        answerInput2.addEventListener("keyup", resizeInput);
        function resizeInput(){
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        divInputGroup.appendChild(divInputGroupText);
        divInputGroup.appendChild(answerInput2);

        var divRemoveButton = document.createElement("div");
        divRemoveButton.className ="mb-2";

        var removeButton = document.createElement("button");
        removeButton.className = "btn btn-danger";
        removeButton.setAttribute("type", "button");
        removeButton.innerHTML = "Eliminar";
        removeButton.addEventListener("click", function() {
            answerGroup.parentNode.removeChild(answerGroup)
        });

        divRemoveButton.appendChild(removeButton);

        answerGroup.appendChild(divInputGroup);

        answerGroup.appendChild(divRemoveButton)

        card.querySelector("#answer-container").appendChild(answerGroup);

    }


    function addQuestionOpen() {
        var questionContainer = document.getElementById("questions-container");

        generarId++;
        console.log(generarId);
        var card = document.createElement("div");
        card.className = "card mt-3 card-color";
        card.id = "card-" + generarId;

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header card-header-color";

        var cardTitle = document.createElement("h5");
        cardTitle.className = "card-title";
        cardTitle.innerHTML = "Respuesta abierta";

        cardHeader.appendChild(cardTitle);

        var cardBody = document.createElement("div");
        cardBody.className = "card-body";

        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var scoreGroup = document.createElement("div");
        scoreGroup.className = "form-group col-md-1 col-lg-1";

        var scoreLabel = document.createElement("label");
        scoreLabel.setAttribute("for", "question-score");
        scoreLabel.innerHTML = "Puntaje:";

        var scoreInput = document.createElement("input");
        scoreInput.className = "form-control";
        scoreInput.setAttribute("type", "number");
        scoreInput.setAttribute("value", 0);
        scoreInput.setAttribute("max", 10);
        scoreInput.setAttribute("min", 0);
        scoreInput.setAttribute("id", "question-score");
        scoreInput.setAttribute("name", "question-score");
        scoreInput.addEventListener("input", function () {
            if (this.value.length > 2)
                this.value = this.value.slice(0, 2);
        });
        scoreInput.addEventListener("input", function () {
            if (this.value > 10)
                this.value = 10;
        });
        scoreInput.addEventListener("input", function () {
            if (this.value < 0)
                this.value = 0;
        });

        scoreGroup.appendChild(scoreLabel);
        scoreGroup.appendChild(scoreInput);

        cardBody.appendChild(scoreGroup);

        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "open-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.style.resize = "none";
        questionTextarea.contentEditable = "true";
        questionTextarea.maxLength = 255;
        questionTextarea.setAttribute("id", "open-question");
        questionTextarea.setAttribute("name", "open-question");
        questionTextarea.style.overflow = "hidden";
        questionTextarea.addEventListener("input", resizeInput);
        questionTextarea.addEventListener("keyup", resizeInput);
        function resizeInput() {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var removeQuestion = document.createElement("button");
        removeQuestion.className = "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function () {
            deleteQuestion(card.id);
        });

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(removeQuestion);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function deleteQuestion(cardId) {
        var card = document.getElementById(cardId);
        var currentCardId = parseInt(cardId.split("-")[1]);

        // Elimina la card del DOM
        card.parentNode.removeChild(card);

        // Actualiza los IDs de las cards siguientes
        var cards = document.getElementsByClassName("card");
        for (var i = currentCardId + 1; i <= cards.length; i++) {
            var currentCard = cards[i - 1];
            currentCard.id = "card-" + (i - 1);
            currentCard.querySelector("button").removeEventListener("click", deleteQuestion);
            currentCard.querySelector("button").addEventListener("click", function () {
                deleteQuestion(currentCard.id);
            });
        }

        // Decrementa el contador de IDs
        generarId--;

        // ...
    }

    function autoResize(textarea) {
        // Ajustar temporalmente el height al mínimo antes de medir el scrollHeight
        textarea.style.height = "1px";
        textarea.style.height = textarea.scrollHeight + "px";
    }



    // Variable global para rastrear si se han guardado los cambios
    let cambiosGuardados = false;

    function marcarCambiosComoGuardados() {
        cambiosGuardados = true;
    }

    function verificarYNavegar() {
        if (!cambiosGuardados) {
            Swal.fire({
                title: '¿Deseas guardar los cambios?',
                showCancelButton: true,
                confirmButtonText: 'Guardar',
                confirmButtonColor: '#00AA83', // Establecer el color de fondo para el botón "Guardar"
                confirmButtonBorder: '2px solid #002F5D', // Establecer el borde para el botón "Guardar"
                cancelButtonText: 'Volver al examen', // Cambiar "Cancelar examen" a "No guardar"
                cancelButtonColor: '#FAD324', // Establecer el color de fondo para el botón "No guardar"
                cancelButtonBorder: '2px solid #737373', // Establecer el borde para el botón "No guardar"
                denyButtonText: 'No guardar', // Cambiar "No guardar" a "Cancelar examen"
                denyButtonColor: '#d33', // Establecer el color de fondo para el botón "Cancelar examen"
                denyButtonBorder: '2px solid #802f2f',// Establecer el borde para el botón "Cancelar examen"
                showDenyButton: true,
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire({
                        icon: 'success',
                        title: 'EXAMEN GUARDADO',
                        showConfirmButton: false,
                        timer: 1500
                    }).then(() => {
                        // Redirigir a la página principal con los cambios guardados
                        // Puedes actualizar el valor de href con la URL deseada
                        window.location.href = '/ruta/a/pagina-principal';
                    });
                } else if (result.isDenied) {
                    // Redirigir a la página principal sin guardar cambios
                    // Puedes actualizar el valor de href con la URL deseada
                    window.location.href = '/ruta/a/pagina-principal';
                }
            });
        } else {
            // Redirigir a la página principal directamente, ya que los cambios ya están guardados
            // Puedes actualizar el valor de href con la URL deseada
            window.location.href = '/ruta/a/pagina-principal';
        }
    }

    // Variable global para el temporizador
    let guardarButtonTimer;

    // Función para cambiar temporalmente el color del botón "Guardar"
    function cambiarColorTemporarily() {
        var guardarButton = document.getElementById('guardarButton');
        guardarButton.style.backgroundColor = '#00aa83'; // Cambiar el color temporalmente

        // Restaurar el color original después de 1 segundo (1000 milisegundos)
        guardarButtonTimer = setTimeout(function () {
            guardarButton.style.backgroundColor = '#002F5D'; // Restaurar el color original
        }, 100);
    }

    // Función para marcar los cambios como guardados y cambiar el color del botón
    function marcarCambiosYCambiarColor() {
        marcarCambiosComoGuardados(); // Marcar cambios como guardados
        cambiarColorTemporarily(); // Cambiar el color del botón temporalmente
    }



    //--------------------------------------------------------------------------------//

    // Función para generar el código aleatorio
    function generateRandomCode(length) {
        const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        let code = '';
        for (let i = 0; i < length; i++) {
            const randomIndex = Math.floor(Math.random() * characters.length);
            code += characters.charAt(randomIndex);
        }
        return code;
    }

    // Generar el código aleatorio al cargar la página y mostrarlo en el input
    window.addEventListener('load', function() {
        const codeInput = document.getElementById('exam-code');
        const generatedCode = generateRandomCode(6);
        codeInput.value = generatedCode;
    });





</script>
</script>
</body>
</html>
