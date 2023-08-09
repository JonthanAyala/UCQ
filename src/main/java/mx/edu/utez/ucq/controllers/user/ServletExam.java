package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
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
                // Obtener datos del examen del formulario
                String examTitle = req.getParameter("nameExam");
                String examCode = req.getParameter("exam-code");
                Long userId = (Long) req.getSession().getAttribute("user_id");

                // Crear un objeto Exam y establecer sus atributos
                Exam exam = new Exam();
                exam.setName_exam(examTitle);
                exam.setCode(examCode);
                exam.setFk_user(userId);

                boolean resultE = new DaoExam().saveExam(exam);
                if (resultE) {
                    // Obtener preguntas generadas del formulario
                    List<Question> questions = new ArrayList<>();

                    String[] type_question = req.getParameterValues("type_question");//tipo de pregunta
                    String[] questionTexts = req.getParameterValues("closed-question");//Descripccion
                    String[] questionScores = req.getParameterValues("question-score");//puntaje

                    /*if (questionTexts != null && questionScores != null) {
                        for (int i = 0; i < questionTexts.length; i++) {
                            String questionText = questionTexts[i];
                            int questionScore = Integer.parseInt(questionScores[i]);

                            // Crear un objeto Question y establecer sus atributos
                            Question question = new Question();
                            question.setDescription(questionText);
                            question.setPoints((long) questionScore);
                            // Establecer otros atributos de la pregunta según tu modelo

                            // Agregar la pregunta a la lista
                            questions.add(question);
                        }
                    }*/
                    resp.sendRedirect("/ruta/a/pagina-de-confirmacion"); // Cambia la ruta según tus necesidades}
                }

                break;
            default:
                System.out.println(action);

        }
        resp.sendRedirect(req.getContextPath()+ redirect);
    }

}
