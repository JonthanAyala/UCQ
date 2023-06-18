<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Crear Examen</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="/path/to/bootstrap.min.css" rel="stylesheet">
    <jsp:include page="../../layouts/head.jsp"/>
</head>
<body>
<div class="container">
    <h1>Crear Examen</h1>

    <form action="/path/to/save-exam.jsp" method="POST">
        <div id="questions-container">

        </div>
        <div>
            <button type="submit" class="btn btn-success">Guardar</button>
            <a href="/path/to/continue-creating.jsp" class="btn btn-secondary">Continuar Creando en Otro Momento</a><br>
        </div>
        <button type="button" class="btn btn-primary mt-3" onclick="addQuestionClose()">Agregar Pregunta Cerrada</button>
        <button type="button" class="btn btn-primary mt-3" onclick="addQuestionOpen()">Agregar Pregunta Abierta</button>
    </form>
</div>

<jsp:include page="../../layouts/footer.jsp"/>
<script>
    function addQuestionClose() {
        var questionContainer = document.getElementById("questions-container");

        var card = document.createElement("div");
        card.className = "card mt-3";

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header";

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
        questionTextarea.setAttribute("id", "closed-question");
        questionTextarea.setAttribute("name", "closed-question");

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);

        var answerContainer = document.createElement("div");
        answerContainer.setAttribute("id", "answer-container");

        var answerLabel = document.createElement("label");
        answerLabel.innerHTML = "Respuestas:";

        var answerInput = document.createElement("input");
        answerInput.setAttribute("type", "text");
        answerInput.className = "form-control";
        answerInput.setAttribute("name", "answer");
        answerInput.setAttribute("placeholder", "Respuesta");
        answerInput.required = true;

        var correctCheckbox = document.createElement("input");
        correctCheckbox.setAttribute("type", "checkbox");
        correctCheckbox.setAttribute("name", "correct-answer");
        correctCheckbox.className = "form-check-input";

        answerContainer.appendChild(answerLabel);
        answerContainer.appendChild(answerInput);
        answerContainer.appendChild(correctCheckbox);

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(answerContainer);

        var addButton = document.createElement("button");
        addButton.className = "btn btn-primary mt-2";
        addButton.setAttribute("type", "button");
        addButton.innerHTML = "Agregar Respuesta";
        addButton.addEventListener("click", addAnswerClose);

        cardBody.appendChild(addButton);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function addAnswerClose() {
        var answerContainer = document.getElementById("answer-container");

        var answerGroup = document.createElement("div");
        answerGroup.className = "form-group d-flex align-items-center";

        var answerInput = document.createElement("input");
        answerInput.setAttribute("type", "text");
        answerInput.className = "form-control mr-2";
        answerInput.setAttribute("name", "answer");
        answerInput.setAttribute("placeholder", "Respuesta");
        answerInput.required = true;

        var correctCheckbox = document.createElement("input");
        correctCheckbox.setAttribute("type", "checkbox");
        correctCheckbox.setAttribute("name", "correct-answer");
        correctCheckbox.className = "form-check-input mr-2";

        var removeButton = document.createElement("button");
        removeButton.className = "btn btn-danger";
        removeButton.setAttribute("type", "button");
        removeButton.innerHTML = "Eliminar";
        removeButton.addEventListener("click", function() {
            answerContainer.removeChild(answerGroup);
        });

        answerGroup.appendChild(answerInput);
        answerGroup.appendChild(correctCheckbox);
        answerGroup.appendChild(removeButton);

        answerContainer.appendChild(answerGroup);
    }
    function addQuestionOpen() {
        var questionContainer = document.getElementById("questions-container");

        var card = document.createElement("div");
        card.className = "card mt-3";

        var cardHeader = document.createElement("div");
        cardHeader.className = "card-header";

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

        formGroupScore.appendChild(scoreLabel);
        formGroupScore.appendChild(scoreInput);

        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(formGroupScore);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
</script>

</script>
</body>
</html>
