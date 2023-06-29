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

</style>

<body style="background-color: #d9d9d9">

<div>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <input class="form-control bg-dark text-white" type="text" placeholder="Nombre Examen">
        </div>
    </nav>

</div>

<div class="container" style="background-color: white">

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

<div class=" container mt-5" style="text-align: right">
    <button type="submit" class="btn btn-success">Guardar</button>
    <a href="/path/to/continue-creating.jsp" class="btn btn-secondary">Continuar Creando en Otro Momento</a><br>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
<script>

    function addQuestionClose() {
        var questionContainer = document.getElementById("questions-container");

        var card = document.createElement("div");
        card.className = "card mt-3 card-color";

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

        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "closed-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.style ="resize: none";
        questionTextarea.contentEditable = "true";
        questionTextarea.maxLength = 255;
        questionTextarea.setAttribute("id", "closed-question");
        questionTextarea.setAttribute("name", "closed-question");

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var answerContainer = document.createElement("div");
        answerContainer.setAttribute("id", "answer-container");

        var answerLabel = document.createElement("label");
        answerLabel.innerHTML = "Respuestas:";

        var divInputGroup = document.createElement("div");
        divInputGroup.className="input-group-text input-group-sm";
        answerContainer.setAttribute("id", "answer-container");

        var divInputGroupText = document.createElement("div");
        divInputGroupText.className = "input-group-text";

        var inputCheckbox = document.createElement("input");
        inputCheckbox.className = "form-check-input mt-0";
        inputCheckbox.type = "checkbox";
        inputCheckbox.value = "";
        inputCheckbox.setAttribute("aria-label", "correctAnswer");
        inputCheckbox.setAttribute("name", "correct-answer");

        divInputGroupText.appendChild(inputCheckbox);

        var answerInput2 = document.createElement("input")
        answerInput2.type = "text";
        answerInput2.className ="form-control"
        answerInput2.setAttribute("aria-label", "correctAnswer");
        answerInput2.style ="resize: none";
        answerInput2.maxLength = 255;
        answerInput2.contentEditable = "true";
        answerInput2.setAttribute("name", "answer");
        answerInput2.setAttribute("placeholder", "Respuesta");
        answerInput2.required = true;

        divInputGroup.appendChild(divInputGroupText);
        divInputGroup.appendChild(answerInput2);

        answerContainer.appendChild(answerLabel);
        answerContainer.appendChild(divInputGroup);

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(answerContainer);

        var addButton = document.createElement("button");
        addButton.className = "btn btn-primary mt-2";
        addButton.setAttribute("type", "button");
        addButton.innerHTML = "Agregar Respuesta";
        addButton.addEventListener("click", addAnswerClose);

        var removeQuestion= document.createElement("button");
        removeQuestion.className= "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function() {
            questionContainer.removeChild(card);
        });

        cardBody.appendChild(addButton);
        cardBody.appendChild(removeQuestion);


        card.appendChild(cardHeader);
        card.appendChild(cardBody);


        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }


    function addAnswerClose() {
        var answerContainer = document.getElementById("answer-container");

        var answerGroup = document.createElement("div");
        answerGroup.className = "form-group align-items-center";

        var divInputGroup = document.createElement("div");
        divInputGroup.className="input-group-text  mb-2 input-group-sm mt-2";

        var divInputGroupText = document.createElement("div");
        divInputGroupText.className = "input-group-text ";

        var inputCheckbox = document.createElement("input");
        inputCheckbox.className = "form-check-input mt-0";
        inputCheckbox.type = "checkbox";
        inputCheckbox.value = "";
        inputCheckbox.setAttribute("aria-label", "correctAnswer");
        inputCheckbox.setAttribute("name", "correct-answer");

        divInputGroupText.appendChild(inputCheckbox);

        var answerInput2 = document.createElement("input");
        answerContainer.setAttribute("id", "answer-container");
        answerInput2.className ="form-control"
        answerInput2.setAttribute("aria-label", "correctAnswer");
        answerInput2.style ="resize: none";
        answerInput2.maxLength = 255;
        answerInput2.contentEditable = true;
        answerInput2.setAttribute("name", "answer");
        answerInput2.setAttribute("placeholder", "Respuesta");
        answerInput2.required = true;

        divInputGroup.appendChild(divInputGroupText);
        divInputGroup.appendChild(answerInput2);

        var divRemoveButton = document.createElement("div");
        divRemoveButton.className ="mb-2"

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

        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "open-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.setAttribute("id", "open-question");
        questionTextarea.setAttribute("name", "open-question");

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var formGroupScore = document.createElement("div");
        formGroupScore.className = "form-group";

        var scoreLabel = document.createElement("label");
        scoreLabel.setAttribute("for", "question-score");
        scoreLabel.innerHTML = "Puntaje:";

        var scoreInput = document.createElement("input");
        scoreInput.className = "form-control";
        scoreInput.setAttribute("type", "number");
        scoreInput.setAttribute("id", "question-score");
        scoreInput.setAttribute("name", "question-score");

        var removeQuestion= document.createElement("button");
        removeQuestion.className= "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.addEventListener("click", function() {
            questionContainer.removeChild(card);
        });

        formGroupScore.appendChild(scoreLabel);
        formGroupScore.appendChild(scoreInput);

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(formGroupScore);

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
