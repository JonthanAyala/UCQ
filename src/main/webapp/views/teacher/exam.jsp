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
        color: black;
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


</style>

<body style="background-color: #D8EAE3">

<div>
    <nav class="navbar navbar-color">

        <div class="container">
            <div class="justify-content-xl-center col-xl-5">
                <form>
                    <input class="form-control navbar-input placeholder-name-exam" style="background-color:  #002F5D" type="text" placeholder="Nombre Examen" required>
                </form>
            </div>
            <button type="button" class="btn" onclick="
 Swal.fire({
            title: '¿Deseas guardar los cambios?',
            showDenyButton: true,
            showCancelButton: true,
            confirmButtonText: 'guardar',
            denyButtonText: `no guardar`,
        }).then((result) => {

            if (result.isConfirmed) {
                Swal.fire('EXAMEN GUARDADO', '', 'success')
                //LA ALERTA APARECERÁ EN CASO DE QUE APRETEN EL BOTON DE REGRESAR Y NO SE HAYAN GUARDADOS LOS CAMBIOS
                //REDIRIGIR A LA PAGINA PRINCIPAL CON LOS CAMBIOS GUARDADOS
            } else if (result.isDenied) {
               //REDIRIGIR SOLAMENTE A LA PAGINA PRINCIPAL
            }
        })" style="background-color: transparent; border: transparent">
                <img src="../../assets/img/icons8-volver-48.png">
            </button>
        </div>
    </nav>

</div>

<div class="container mt-5 w-50 p-3" style="background-color: white">

    <div id="questions-container">

    </div>

    <div class="container mt-5" style="background-color: white">
        <div class="row">
            <div class="col mb-5">
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
            </div>
        </div>
    </div>
</div>

<div class="container mt-5 mb-5">
    <div class=" container mt-5 mb-5 d-grid" style="text-align: center">
        <button type="submit" class="btn btn-success">Guardar</button>
    </div>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
<script>
    

    function addQuestionClose() {
        var questionContainer = document.getElementById("questions-container");

        let idCard = 1;

        var card = document.createElement("div");
        card.className = "card mt-3 card-color";
        card.setAttribute = ("id", idCard);



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
        function resizeInput(){
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var answerContainer = document.createElement("div");
        answerContainer.setAttribute("id", "answer-container");

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(answerContainer);

        var divButtons = document.createElement("div");
        divButtons.className = "form-group";

        var addButton = document.createElement("button");
        addButton.className = "btn btn-primary mt-2";
        addButton.setAttribute("type", "button");
        addButton.innerHTML = "Agregar Respuesta";
        addButton.addEventListener("click", addAnswerClose);

        var divRemoveQuestion = document.createElement("div");
        divRemoveQuestion.className="form-group";
        divRemoveQuestion.style="text-align: right";

        var removeQuestion= document.createElement("button");
        removeQuestion.className= "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function() {
            questionContainer.removeChild(card);
        });

        divButtons.appendChild(addButton);
        answerContainer.appendChild(divButtons);
        divRemoveQuestion.appendChild(removeQuestion);

        divButtons.appendChild(divRemoveQuestion);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);


        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });

        if (removeQuestion.addEventListener("click"))

        idCard ++;
    }


    function addAnswerClose() {
        var answerContainer = document.getElementById("answer-container");

        var answerGroup = document.createElement("div");
        answerGroup.className = "form-group align-items-center";

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
            answerContainer.removeChild(answerGroup);
        });

        divRemoveButton.appendChild(removeButton);

        answerGroup.appendChild(divInputGroup);

        answerGroup.appendChild(divRemoveButton)

        answerContainer.appendChild(answerGroup);

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

</script>

</script>
</body>
</html>
