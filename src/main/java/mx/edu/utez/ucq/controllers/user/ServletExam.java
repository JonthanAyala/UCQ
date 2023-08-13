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
            case "/exam/save-exam":
            String examCode = req.getParameter("exam-code");
            String nameExam = req.getParameter("nameExam");
            Long userId = Long.valueOf(req.getParameter("fk_user"));
            String[] questionTypes = req.getParameterValues("question-type");
            String[] questionDescriptions = req.getParameterValues("description");
            String[] questionScores = req.getParameterValues("score");

            // Guardar examen y obtener su ID
            Exam exam = new Exam(null, nameExam, examCode, null, null, userId);
            boolean resultE = new DaoExam().saveExam(exam);

            if (resultE) {
                Long examId = new DaoExam().extractId(userId);

                for (int i = 0; i < questionDescriptions.length; i++) {
                    int questionType = Integer.parseInt(questionTypes[i]);
                    String description = questionDescriptions[i];
                    int score = Integer.parseInt(questionScores[i]);

                    // Guardar pregunta y obtener su ID
                    Question question = new Question(i,null, (long) questionType, description, (long) score);
                    boolean resultQ = new DaoExam().saveQuestion(question);
                    Long questionId = new DaoExam().extractIdQuestion();

                    // Guardar respuestas asociadas a la pregunta
                    String[] answers = req.getParameterValues("answer-" + i);
                    String correctAnswer = req.getParameter("correct-answer-" + i);
                    if (answers != null) {
                        for (int j = 0; j < answers.length; j++) {
                            String answerText = answers[j];
                            boolean isCorrect = (j == Integer.parseInt(correctAnswer));

                            Answer answer = new Answer(null, answerText, isCorrect, questionId);
                            boolean resultA = new DaoExam().saveAnswer(answer);
                        }
                    }
                }

                redirect ="/user/index-teacher";
            } else {
                redirect ="/user/index-teacher?result=false&message=" + URLEncoder
                        .encode("Error no se guardo el examen", StandardCharsets.UTF_8);
            }
            break;
            default:
                System.out.println(action);

        }
        resp.sendRedirect(req.getContextPath()+ redirect);
    }

}
