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


</style>

<body style="background-color: #D8EAE3">

<div class="overflow-hidden fixed-top">
    <nav class="navbar navbar-expand-lg  " style= "background-color: #002F5D;">
        <div class="container d-flex align-content-between">

            <div class="container-fluid h-20 d-inline-block" style="width: 120px;">
                <a class="navbar-brand position-absolute top-50 start-50 translate-middle"
                   style="color: white;"> <h3> Ultimate Custom Quiz </h3></a>
            </div>

            <div>
                <button type="button" class="btn" style="background-color: transparent; border: transparent"
                        onclick="verificarYNavegar() ">
                    <img src="../../assets/img/icons8-volver-48.png">
                </button>
            </div>

            <br><br>
        </div>
    </nav>
</div>


<div class="d-flex">
    <div class="container col-xl-4 vh-100 m-0 sticky-top"
         style="text-align: left; background-color: #00AA83;">

        <br>
        <br>

        <form action="/path/to/save-exam.jsp" method="post">
            <div class="d-grid">
                <button type="button" class="btn mt-5" onclick="addQuestionClose()" style="background-color: #d9d9d9" >
                    Agregar pregunta cerrada
                    <img src="../../assets/img/icons8-add-48.png">
                </button>
                <button type="button" class="btn mt-5" onclick="addQuestionOpen()" style="background-color: #d9d9d9" >
                    Agregar pregunta abierta
                    <img src="../../assets/img/icons8-add2-48.png">
                </button>
            </div>
        </form>

        <div class="container mb-5">
            <div class=" container mt-5 mb-5 d-grid" style="text-align: center">
                <button type="submit" class="btn btn-success" style="background-color: #002F5D!important;
                color: white !important;" onclick="marcarCambiosComoGuardados()">Guardar</button>
            </div>
        </div>
    </div>


    <div class="container mt-5 w-50 p-3 containerExam mb-5" style="background-color: white;">

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



<jsp:include page="../../layouts/footer.jsp"/>
<script>

    var generarId = 0;

    function addQuestionClose() {
        var questionContainer = document.getElementById("questions-container");

        generarId++;

        var card = document.createElement("div");
        card.className = "card mt-3 card-color";
        card.id = "card-" + generarId;

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header card-header-color";

        var cardTitle = document.createElement("h5");
        cardTitle.className = "card-title";
        cardTitle.innerHTML = "Pregunta Cerrada";

        cardHeader.appendChild(cardTitle);

        var cardBody = document.createElement("div");
        cardBody.className = "card-body";

        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var scoreGroup = document.createElement("div");
        scoreGroup.className = "form-group col-md-1 col-lg-2";

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
            deleteQuestionClose(card.id);
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

    function deleteQuestionClose(cardId) {
        var card = document.getElementById(cardId);
        var currentCardId = parseInt(cardId.split("-")[1]);

        // Elimina la card del DOM
        card.parentNode.removeChild(card);

        // Actualiza los IDs de las cards siguientes
        var cards = document.getElementsByClassName("card");
        for (var i = currentCardId + 1; i <= cards.length; i++) {
            var currentCard = cards[i - 1];
            currentCard.id = "card-" + (i - 1);
            currentCard.querySelector("button").removeEventListener("click", deleteQuestionClose);
            currentCard.querySelector("button").addEventListener("click", function() {
                deleteQuestionClose(currentCard.id);
            });
        }

        // Disminuye el contador de IDs
        cardId--;

    }


    function addQuestionOpen() {
        var questionContainer = document.getElementById("questions-container");

        var card = document.createElement("div");
        card.className = "card mt-3 card-color";

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header card-header-color";

        var cardTitle = document.createElement("h5");
        cardTitle.className = "card-title";
        cardTitle.innerHTML = "Pregunta Abierta";

        cardHeader.appendChild(cardTitle);

        var cardBody = document.createElement("div");
        cardBody.className = "card-body";

        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var scoreGroup = document.createElement("div");
        scoreGroup.className ="form-group col-md-1 col-lg-1"

        var scoreLabel = document.createElement("label");
        scoreLabel.setAttribute("for", "question-score");
        scoreLabel.innerHTML = "Puntaje:";

        var scoreInput = document.createElement("input");
        scoreInput.className = "form-control";
        scoreInput.setAttribute("type", "number");
        scoreInput.setAttribute("value", 0);
        scoreInput.setAttribute("max", 10);
        scoreInput.setAttribute("min", 0)
        scoreInput.setAttribute("id", "question-score");
        scoreInput.setAttribute("name", "question-score");
        scoreInput.addEventListener('input',function(){
            if (this.value.length > 2)
                this.value = this.value.slice(0,2);
        })
        scoreInput.addEventListener('input', function (){
            if (this.value > 10)
                this.value = 10;
        })
        scoreInput.addEventListener('input', function (){
            if (this.value < 0)
                this.value = 0;
        })

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
        questionTextarea.style ="resize: none";
        questionTextarea.contentEditable = "true";
        questionTextarea.maxLength = 255;
        questionTextarea.setAttribute("id", "open-question");
        questionTextarea.setAttribute("name", "open-question");
        questionTextarea.style.overflow = "hidden";
        questionTextarea.addEventListener("input", resizeInput);
        questionTextarea.addEventListener("keyup", resizeInput);
        function resizeInput(){
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var removeQuestion= document.createElement("button");
        removeQuestion.className= "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function() {
            questionContainer.removeChild(card);
        });


        cardBody.appendChild(formGroupQuestion);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        cardBody.appendChild(removeQuestion);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });


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
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: 'Guardar',
                denyButtonText: 'No guardar',
                cancelButtonText: 'Volver al examen'
            }).then((result) => {
                if (result.isConfirmed) {
                    Swal.fire('EXAMEN GUARDADO', '', 'success');
                    // Redirige a la página principal con los cambios guardados
                    // Puedes actualizar el valor de href con la URL deseada
                    window.location.href = '/ruta/a/pagina-principal';
                } else if (result.isDenied) {
                    // Redirige a la página principal sin guardar cambios
                    // Puedes actualizar el valor de href con la URL deseada
                    window.location.href = '/ruta/a/pagina-principal';
                }
            });
        } else {
            // Redirige a la página principal directamente, ya que los cambios ya están guardados
            // Puedes actualizar el valor de href con la URL deseada
            window.location.href = '/ruta/a/pagina-principal';
        }
    }



</script>

</script>
</body>
</html>
