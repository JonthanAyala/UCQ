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
import java.net.DatagramPacket;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Enumeration;
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
        switch (action) {
            case "/exam/save-exam":
                try {
                // Recuperar los valores del formulario
                String examCode = req.getParameter("exam-code");
                String nameExam = req.getParameter("nameExam");
                Long fkUser = Long.valueOf(req.getParameter("fk_user"));
                // Guardar examen y obtener su ID
                Exam exam = new Exam(null, nameExam, examCode, null, null, fkUser);
                boolean resultE = new DaoExam().saveExam(exam);

                if (resultE) {
                    Long examId = new DaoExam().extractId(fkUser);
                    Enumeration<String> parameterNames = req.getParameterNames();

                    while (parameterNames.hasMoreElements()) {

                        String paramName = parameterNames.nextElement();
                        if (paramName.startsWith("description-")) {
                            Long questionIndex = Long.valueOf(Integer.parseInt(paramName.substring("description-".length())));
                            String questionDescription = req.getParameter(paramName);
                            Long questionScore = Long.valueOf(Integer.parseInt(req.getParameter("score-" + questionIndex)));
                            Long questionType = Long.valueOf(req.getParameter("question-type"));

                            Question question = new Question(null,null,questionType,questionDescription,questionScore);
                            boolean resultQ = new DaoExam().saveQuestion(question);
                            Long id_Q = new DaoExam().extractIdQuestion(questionDescription);
                            boolean resultEQ = new DaoExam().saveEQ(examId,id_Q);

                            if (resultEQ && resultQ){
                            if (questionType == 2) {
                                int answerIndex = 1;
                                while (true) {
                                    String answerParamName = "answer-" + questionIndex + "-" + answerIndex;
                                    String answer = req.getParameter(answerParamName);

                                    Answer answer1 = new Answer(null, answer, if_answer,id_Q );
                                    if (answer == null) {
                                        break;
                                    }
                                    answerIndex++;
                                }
                                redirect = "/user/index-teacher?result=false&message=" + URLEncoder
                                        .encode("Examen guardado", StandardCharsets.UTF_8);
                            } else {
                                redirect = "/user/index-teacher?result=false&message=" + URLEncoder
                                            .encode("Error no se guardo el examen", StandardCharsets.UTF_8);
                            }
                            }
                        }
                    }

                }
                } catch (Exception e) {
                    redirect = "/user/index-teacher?result=false&message=" + URLEncoder
                            .encode("Error no se guardo el examen", StandardCharsets.UTF_8);
                }
                break;
                    default:
                    System.out.println(action);
        }
        resp.sendRedirect(req.getContextPath() + redirect);
    }

}

