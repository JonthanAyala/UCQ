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
        <div class="container-fluid mt-5">
            <form>
                <textarea class="form-control textareaTittle" name="nameExam" id="nameExam"
                  style="font-size: 30px; overflow: hidden; resize: none"
                  maxlength="50" oninput="autoResize(this)"
                  placeholder="Titulo Examen" required onfocusout="saveExam()">
                </textarea>
                <div class=" container mt-5 col-4" style="text-align: center">
                    <div class="form-group">
                        <label for="exam-code1" class="placeholder-exam-code1"> <h6> Código del examen:</h6> </label>
                        <input type="text" class="form-control" id="exam-code1" style="background-color:#D9D9D9;" readonly>
                        <input hidden name="exam-code" id="exam-code" name="exam-code">
                    </div>
                </div>
            </form>
        </div>

        <div class="container mb-5">
            <div class=" container mt-5 mb-5 d-grid" style="text-align: center">
                <input type="text" hidden id="fk_user" name="fk_user" value="${sessionScope.user.id}" >
                <button id="guardarButton" type="" class="btn btn-success" style="background-color: #002F5D!important;
                color: white !important;" onclick="marcarCambiosYCambiarColor( )">Guardar</button>
            </div>
        </div>
    </div>


    <div class="container mt-5 w-50 p-3 containerExam mb-5" style="background-color: white;
    box-shadow: 0 0 8px rgba(0, 170, 131, 0.3);">



        <div id="questions-container" class="overflow-y-auto">

        </div>
    </div>
</div>


<jsp:include page="../../layouts/footer.jsp"/>
<script>
    var codigo = '';
    var generarId = 0;
    var fk_user = ${sessionScope.user.id};
    console.log(fk_user);
    var idExam = null;

    var questionsID = [];

    var answerID = [];

    var i = 0;

    function saveExam() {
        var examTitle = document.getElementById("nameExam").value;
        var examCode = document.getElementById("exam-code").value;

        if (!idExam || idExam === "") {
            $.ajax({
                type: "POST",
                url: "/exam/save-exam",
                data: {
                    "exam-code": examCode,
                    "nameExam": examTitle
                },
                success: function (response) {
                    idExam = response;
                    console.log("nuevo Examen Id: " + response);
                },
                error: function (xhr, status, error) {
                    console.log("Error en la solicitud AJAX:", error);
                },
            });
        } else {
            $.ajax({
                type: "POST",
                url: "/exam/update",
                data: {
                    "nameExam": examTitle,
                    "id_exam": idExam
                },
                success: function (response) {
                    console.log(response);
                },
                error: function (xhr, status, error) {
                    console.log("Error en la solicitud AJAX:", error);
                },
            });
        }
    }
    function saveDescription(arreglo){
        var descriptionElement = document.getElementById("description-" + arreglo);
        var description = descriptionElement.value;

        $.ajax({
            type: "POST",
            url: "/exam/save-description",
            data: {
                "id_question": questionsID[arreglo],
                "description": description,
            },
            success: function (response) {
                console.log("Descripcion guardada");
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });
    }
    function saveScore(arreglo){

        var scoreElement = document.getElementById("score-" + arreglo);
        var score = scoreElement.value;

        $.ajax({
            type: "POST",
            url: "/exam/save-score",
            data: {
                "id_question": questionsID[arreglo],
                "score": score ,
            },
            success: function (response) {
                console.log("Score  guardada");
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });
    }
    // borrar el trigger drop trigger delete_exam_question;
    function saveAnswer(arregloi, answerId){
        var answerElement = document.getElementById("answer-" + answerId);
        var answer = answerElement.value;
        console.log("arreglo: "+arregloi);
        console.log(answerID[arregloi]);
        var idA = answerID[arregloi];
        console.log("ID en arreglo: "+idA);
        console.log("A enviar respuesta: "+answer);
        $.ajax({
            type: "POST",
            url: "/exam/save-answer",
            data: {
                "id_answer": answerID[arregloi],
                "answer": answer ,
            },
            success: function (response) {
                console.log("respuesta  guardada");
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });
    }
    ///
    function addQuestionClose() {
        $.ajax({
            type: "POST",
            url: "/exam/createQ",
            data: {
                "id_exam": idExam,
                "type_question": "2"
            },
            success: function (response) {
                questionsID[generarId] = response;
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });

        var questionContainer = document.getElementById("questions-container");
        generarId++;

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

        var scoreForm = document.createElement("form");
        var scoreGroup = document.createElement("div");
        scoreGroup.className = "form-group col-md-1 col-lg-2";

        var scoreLabel = document.createElement("label");
        scoreLabel.setAttribute("for", "question-score");
        scoreLabel.innerHTML = "Puntaje:";

        var scoreInput = document.createElement("input");
        scoreInput.className = "form-control";
        scoreInput.setAttribute("type", "number");
        scoreInput.setAttribute("value", "0");
        scoreInput.setAttribute("max", "10");
        scoreInput.setAttribute("min", "0");
        scoreInput.setAttribute("id", "score-"+generarId);
        scoreInput.setAttribute("name", "score-"+generarId);
        scoreInput.setAttribute("onfocusout", "saveScore("+generarId+")");
        scoreInput.addEventListener("input", function () {
            if (this.value.length > 2) {
                this.value = this.value.slice(0, 2);
            }
            if (this.value > 10) {
                this.value = 10;
            }
            if (this.value < 0) {
                this.value = 0;
            }
        });

        scoreGroup.appendChild(scoreLabel);
        scoreGroup.appendChild(scoreInput);
        scoreForm.appendChild(scoreGroup);
        cardBody.appendChild(scoreForm);

        var questionForm = document.createElement("form");
        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "closed-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.style.resize = "none";
        questionTextarea.style.overflow = "hidden";
        questionTextarea.maxLength = "255";
        questionTextarea.setAttribute("id", "description-"+generarId);
        questionTextarea.setAttribute("name", "description-"+generarId);
        questionTextarea.setAttribute("onfocusout", "saveDescription("+generarId+")");
        questionTextarea.addEventListener("input", resizeInput);
        questionTextarea.addEventListener("keyup", resizeInput);

        function resizeInput() {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        questionForm.appendChild(questionLabel);
        questionForm.appendChild(questionTextarea);
        cardBody.appendChild(questionForm);

        var answerContainer = document.createElement("div");
        answerContainer.id = "answer-container-" + generarId;
        cardBody.appendChild(answerContainer);

        var buttonGroup = document.createElement("div");
        buttonGroup.className = "form-group";

        var addButton = document.createElement("button");
        addButton.className = "btn btn-primary mt-2";
        addButton.setAttribute("type", "button");
        addButton.innerHTML = "Agregar Respuesta";
        addButton.setAttribute("onclick", "(function(id) { addAnswerClose(id); })(" + generarId + ")");


        var removeButtonGroup = document.createElement("div");
        removeButtonGroup.className = "form-group";
        removeButtonGroup.style.textAlign = "right";

        var removeButton = document.createElement("button");
        removeButton.className = "btn btn-danger mt-2";
        removeButton.setAttribute("type", "button");
        removeButton.innerHTML = "Eliminar pregunta";
        removeButton.setAttribute("onclick", "(function(id) { deleteQuestion('" + card.id + "', " + generarId + "); })()");

        buttonGroup.appendChild(addButton);
        removeButtonGroup.appendChild(removeButton);
        buttonGroup.appendChild(removeButtonGroup);
        cardBody.appendChild(buttonGroup);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function addAnswerClose(idQ) {
        $.ajax({
            type: "POST",
            url: "/exam/create-Answer",
            data: {
                "Id_Question": questionsID[idQ]
            },
            success: function (response) {
                console.log("valor de arreglo :"+i);
                answerID[i] = response;
                console.log("ID respuesta "+idQ+" : "+answerID[i]);
                i++;
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });

        var answerContainer = document.getElementById("answer-container-" + idQ); // Corrige esta línea
        var answerId = "answer-" + idQ + "-" + (answerContainer.children.length + 1); // Corrige esta línea
        var card = document.getElementById("card-" + idQ);

        console.log("Respuesta para pregunta no : " + idQ);
        console.log("respuesta no: " + answerId);

        var answerGroup = document.createElement("div");
        answerGroup.className = "form-group align-items-center";
        answerGroup.setAttribute("data-card-id", idQ);

        var divInputGroup = document.createElement("div");
        divInputGroup.className = "input-group mb-2 input-group-sm"; // Ajustado el margen aquí

        var divInputGroupText = document.createElement("div");
        divInputGroupText.className = "input-group-prepend"; // Ajustado el nombre de la clase

        var inputCheckbox = document.createElement("input");
        inputCheckbox.className = "form-check-input mt-0";
        inputCheckbox.type = "checkbox";
        inputCheckbox.value = "";
        inputCheckbox.setAttribute("aria-label", "correctAnswer");
        inputCheckbox.setAttribute("name", "correct-answer-"+answerId);

        divInputGroupText.appendChild(inputCheckbox);

        var answerInput2 = document.createElement("textarea");
        answerInput2.className = "form-control input-high-size";
        answerInput2.setAttribute("aria-label", "answer-" + answerId); // Ajustado el atributo aria-label
        answerInput2.maxLength = 255;
        answerInput2.setAttribute("name", "answer-" + answerId); // Ajustado el atributo name
        answerInput2.setAttribute("id","answer-"+ answerId);
        answerInput2.setAttribute("placeholder", "Respuesta");
        answerInput2.setAttribute("onfocusout", "saveAnswer("+i+",'"+answerId+"')");
        answerInput2.style.resize = "none";
        answerInput2.rows = 1;
        answerInput2.required = true;
        answerInput2.style.overflow = "hidden";
        answerInput2.addEventListener("input", resizeInput);
        answerInput2.addEventListener("keyup", resizeInput);
        function resizeInput() {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        // Aquí agregamos el evento para manejar la respuesta correcta
        inputCheckbox.addEventListener("change", function() {
            if (this.checked) {
                var otherCheckboxes = answerContainer.querySelectorAll("input[type='checkbox']");
                otherCheckboxes.forEach(function(checkbox) {
                    if (checkbox !== inputCheckbox) {
                        checkbox.checked = false;
                    }
                });
            }
        });

        divInputGroup.appendChild(divInputGroupText);
        divInputGroup.appendChild(answerInput2);

        var divRemoveButton = document.createElement("div");
        divRemoveButton.className = "mb-2";

        var removeButton = document.createElement("button");
        removeButton.className = "btn btn-danger";
        removeButton.setAttribute("type", "button");
        removeButton.innerHTML = "Eliminar";
        //removeButton.setAttribute("onclick", "(function(id) { deleteAnswer(" + i +");  })");

        console.log("ID answer a borrar: "+answer);
        removeButton.addEventListener("click", function () {
            answerGroup.parentNode.removeChild(answerGroup);

            $.ajax({
                type: "POST",
                url: "/exam/deleteA",
                data: {
                    "id_answer": answer,
                },
                success: function (response) {
                    console.log("Respuesta Eliminada");
                },
                error: function (xhr, status, error) {
                    console.log("Error en la solicitud AJAX:", error);
                },
            });

        });

        divRemoveButton.appendChild(removeButton);

        answerGroup.appendChild(divInputGroup);
        answerGroup.appendChild(divRemoveButton);

        answerContainer.appendChild(answerGroup); // Corregido aquí

    }

    function addQuestionOpen()  {
        $.ajax({
            type: "POST",
            url: "/exam/createQ",
            data: {
                "id_exam": idExam,
                "type_question": "1"
            },
            success: function (response) {
                questionsID[generarId] = response;
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });

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

        var scoreForm = document.createElement("form");
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
        scoreInput.setAttribute("id", "score-"+generarId);
        scoreInput.setAttribute("name", "score-"+generarId);
        scoreInput.setAttribute("onfocusout", "saveScore("+generarId+")");
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

        scoreForm.appendChild(scoreGroup);
        cardBody.appendChild(scoreForm);


        var formGroupQuestion = document.createElement("div");
        formGroupQuestion.className = "form-group";

        var questionForm = document.createElement("form");
        var questionLabel = document.createElement("label");
        questionLabel.setAttribute("for", "open-question");
        questionLabel.innerHTML = "Pregunta:";

        var questionTextarea = document.createElement("textarea");
        questionTextarea.className = "form-control";
        questionTextarea.style.resize = "none";
        questionTextarea.contentEditable = "true";
        questionTextarea.maxLength = 255;
        questionTextarea.setAttribute("id", "description-"+generarId);
        questionTextarea.setAttribute("name", "description-"+generarId);
        questionTextarea.setAttribute("onfocusout", "saveDescription("+generarId+")");
        questionTextarea.style.overflow = "hidden";
        questionTextarea.addEventListener("input", resizeInput);
        questionTextarea.addEventListener("keyup", resizeInput);
        function resizeInput() {
            this.style.height = "auto";
            this.style.height = this.scrollHeight + "px";
        }

        formGroupQuestion.appendChild(questionLabel);
        formGroupQuestion.appendChild(questionTextarea);
        cardBody.appendChild(questionForm);

        var removeQuestion = document.createElement("button");
        removeQuestion.className = "btn btn-danger mt-2";
        removeQuestion.setAttribute("type", "button");
        removeQuestion.innerHTML = "Eliminar pregunta";
        removeQuestion.setAttribute("onclick", "(function(id) { deleteQuestion('" + card.id + "', " + generarId + "); })()");


        cardBody.appendChild(formGroupQuestion);
        cardBody.appendChild(removeQuestion);

        card.appendChild(cardHeader);
        card.appendChild(cardBody);

        questionContainer.appendChild(card);
        card.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }

    function deleteQuestion(cardId,arreglo) {
        console.log("Pregunta a eliminar: "+ questionsID[arreglo])
        $.ajax({
            type: "POST",
            url: "/exam/deleteQ",
            data: {
                "id_question": questionsID[arreglo],
            },
            success: function (response) {
                console.log("Pregunta Eliminada");
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });
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
    }

    function deleteAnswer(arreglo){
        $.ajax({
            type: "POST",
            url: "/exam/deleteA",
            data: {
                "id_answer": answerID[arreglo],
            },
            success: function (response) {
                console.log("Respuesta Eliminada");
            },
            error: function (xhr, status, error) {
                console.log("Error en la solicitud AJAX:", error);
            },
        });
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
        /*console.log("Datos a enviar:");
        console.log(fk_user);
        var inputs = document.querySelectorAll('input, textarea');
        inputs.forEach(function(input) {
            console.log(input.name + ": " + input.value);
        });
        console.log(fk_user);
        marcarCambiosComoGuardados(); // Marcar cambios como guardados
        cambiarColorTemporarily(); // Cambiar el color del botón temporalmente*/
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
        const generatedCode = generateRandomCode(5);
        const codeInput = document.getElementById('exam-code');
        codeInput.value = generatedCode;
        const codeInput2 = document.getElementById('exam-code1');
        codeInput2.value = generatedCode;
        console.log(generatedCode)
    });
</script>
</script>
</body>
</html>
