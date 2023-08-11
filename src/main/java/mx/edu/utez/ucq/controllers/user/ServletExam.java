package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.ucq.models.exam.Answer;
import mx.edu.utez.ucq.models.exam.DaoExam;
import mx.edu.utez.ucq.models.exam.Exam;
import mx.edu.utez.ucq.models.exam.Question;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.models.user.User;


import java.awt.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "exams",urlPatterns = {
        "/exam/exams",
        "/exam/save-exam"
}) // Endpoints --> Acceso para el CRUD usuarios


public class ServletExam extends HttpServlet {
    private String action;
    private String redirect = "/exam/exams";

    private  String id, name, surname, lastname, username, birthday, status;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/exam/exams":
                redirect = "/views/pruebas/exam.jsp";
                break;

            default:
                System.out.println(action);
        }
        req.getRequestDispatcher(redirect).forward(req, resp);
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        resp.setContentType("text/html");
        action = req.getServletPath();
        switch (action){
            case "/exams/save-exam":
                String examTitle = req.getParameter("nameExam");
                String examCode = req.getParameter("exam-code");
                Long userId = (Long) req.getSession().getAttribute("user_id");

                Exam exam = new Exam(null,examTitle, examCode,null,null, userId);

                boolean resultE = new DaoExam().saveExam(exam);
                if (resultE) {
                    Long fk_Exam = new DaoExam().extractId(userId);
                    List<Question> questions = new ArrayList<>();

                    String[] typeQuestion = req.getParameterValues("type_question");
                    String[] questionTexts = req.getParameterValues("closed-question");
                    String[] questionScores = req.getParameterValues("question-score");

                    if (typeQuestion != null && questionTexts != null && questionScores != null) {

                        for (int i = 0; i < questionTexts.length; i++) {
                            int questionType = Integer.parseInt(typeQuestion[i]);
                            String questionText = questionTexts[i];
                            int questionScore = Integer.parseInt(questionScores[i]);

                            Question question = new Question(i, null, (long) questionType, questionText, (long) questionScore);

                            questions.add(question);


                            boolean resultQ = new DaoExam().saveQuestion(question);
                            Long id_question = new DaoExam().extractIdQuestion();
                            boolean resultEQ =  new DaoExam().saveEQ(fk_Exam,id_question);

                            if (resultQ && resultEQ) {
                                // Obtener respuestas generadas del formulario
                                String[] answers = req.getParameterValues("answers_" + i);
                                String correctAnswerValue = req.getParameter("correct-answer_" + i);

                                if (answers != null) {
                                    for (int j = 0; j < answers.length; j++) {
                                        String answerText = answers[j];
                                        boolean isCorrect = (j == Integer.parseInt(correctAnswerValue));

                                        // Crear un objeto Answer y establecer sus atributos
                                        Answer answer = new Answer(null, answerText, isCorrect, id_question);
                                        boolean resultA = new DaoExam().saveAnswer(answer);
                                        // Manejar el resultado de guardar la respuesta si es necesario
                                    }
                                }
                            }
                        }
                    }
                    resp.sendRedirect("/user/index-teacher");
                } else {
                    // Handle exam save failure
                    resp.sendRedirect("/ruta/a/pagina-de-error");
                }

                break;
            default:
                System.out.println(action);

        }
        resp.sendRedirect(req.getContextPath()+ redirect);
    }

}
