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
import mx.edu.utez.ucq.models.user.User;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
@WebServlet(name = "exams",urlPatterns = {
        "/exam/exams",
        "/exam/save-exam",
        "/exam/delete",
        "/exam/update",
        "/exam/createQ",
        "/exam/save-description",
        "/exam/save-score",
        "/exam/deleteQ",
        "/exam/create-Answer",
        "/exam/save-answer",
        "/exam/deleteA"
}) // Endpoints --> Acceso para el CRUD usuarios


public class ServletExam extends HttpServlet {
    private String action;
    private String redirect = "/exam/exams";

    private  String name, surname, lastname, username, birthday, status;
    private Long id_user, id_exam;
    private User user;
    private HttpSession session;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/exam/exams":
                User user2 = (User) session.getAttribute("user");// se guardan los datos en un objeto
                System.out.println(session);// pa ver si hay una sesion
                Long userId = user2.getId(); // se obtiene el campo a utilizar
                System.out.println("User ID: " + userId); // simplemente pa verlo en pantalla
                redirect = "/views/teacher/exam.jsp";
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
            /*
            Funciones submit
            onfocusout
            toast alert
            * */
            case "/exam/save-exam":
                session = req.getSession();
                System.out.println(session);// pa ver si hay una sesion
                User user1 = (User) session.getAttribute("user");
                if (user1 != null) {
                    try {
                        id_user = user1.getId();
                        System.out.println("User ID: " + id_user);
                        String examCode = req.getParameter("exam-code");
                        String nameExam = req.getParameter("nameExam");
                        System.out.println("Name Exam: " + nameExam);
                        System.out.println("Exam Code: " + examCode);
                        Exam exam = new Exam(null, nameExam, examCode, null, null, id_user);
                        boolean resultE = new DaoExam().saveExam(exam);

                        if (resultE) {
                            id_exam = new DaoExam().extractId(id_user);
                            System.out.println("Exam ID: " + id_exam);
                            String examIdStr = String   .valueOf(id_exam);
                            System.out.println("Exam ID en String: "+examIdStr);
                            resp.getWriter().write(examIdStr);
                            resp.getWriter().flush();
                            return;
                        }
                    } catch (Exception e) {
                        e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                    }
                } else {
                    System.out.println("User session is not valid.");
                }
                break;
            case  "/exam/update":
                try {
                    String nameExam = req.getParameter("nameExam");
                    id_exam = Long.valueOf(req.getParameter("id_exam"));
                    System.out.println("Actualizar: "+nameExam);
                    System.out.println("ID"+id_exam);
                    Exam exam = new Exam(id_exam, nameExam, null, null, null, null);
                    boolean resultEU = new DaoExam().updateExam(exam);
                    if (resultEU) {
                        resp.getWriter().write("Examen actualizado correctamente");
                        resp.getWriter().flush();
                        return;
                    } else {
                        resp.getWriter().write("Error al actualizar el examen");
                        resp.getWriter().flush();
                        return;
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/delete":
                Long userId = Long.valueOf(req.getParameter("id_user"));
                id_exam = Long.valueOf(req.getParameter("id"));
                if (new DaoExam().delete(id_exam)) {
                    redirect = "/user/index-teacher?id_user="+ userId+"&?result="+true+"&message="+ URLEncoder.encode("¡Exito! Examen eliminado correctamente.", StandardCharsets.UTF_8);
                }else
                    redirect = "/user/index-teacher?id_user="+ userId+"&?result="+false+"&message="+ URLEncoder.encode("¡ERROR! Usuario no eliminado.", StandardCharsets.UTF_8);
                break;
            case "/exam/createQ":
                try {
                    Long id_exam = Long.valueOf(req.getParameter("id_exam"));
                    System.out.println("Id Exam "+id_exam);
                    Long type_question = Long.valueOf(req.getParameter("type_question"));
                    System.out.println("Tipo pregunta "+type_question);
                    Question question1;
                    question1 = new Question(0L, null, type_question, null, 0L, id_exam);

                    boolean resultQ = new DaoExam().saveQuestion(question1);
                    System.out.println(resultQ);

                    if (resultQ) {
                        Long id_question = new DaoExam().extractIdQuestion(id_exam);
                        System.out.println("Question ID: " + id_question);

                        String questionIdStr = String   .valueOf(id_question);
                        System.out.println("Question id en String: "+questionIdStr);

                        resp.getWriter().write(questionIdStr);
                        resp.getWriter().flush();
                        return;
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/save-description":
                try {
                    Long idQuestion = Long.valueOf(req.getParameter("id_question"));
                    String description = req.getParameter("description");

                    Question question2;
                    question2 = new Question(idQuestion, null, 0L, description, 0L, 0L);

                    boolean resultD = new DaoExam().saveDescription(question2);

                    if (resultD) {
                        // La descripción se guardó correctamente
                        resp.setStatus(HttpServletResponse.SC_OK);
                        resp.getWriter().write("La descripción se guardó correctamente.");
                        resp.getWriter().flush();
                        return;
                    } else {
                        // Ocurrió un error al guardar la descripción
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        resp.getWriter().write("No se pudo guardar la descripción.");
                        resp.getWriter().flush();
                        return;
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/save-score":
                try {
                    Long idQuestion = Long.valueOf(req.getParameter("id_question"));
                    Long score = Long.valueOf(req.getParameter("score"));

                    Question question3;
                    question3 = new Question(idQuestion, null, 0L, null, score, 0L);

                    boolean resultS = new DaoExam().saveScore(question3);

                    if (resultS) {
                        // La descripción se guardó correctamente
                        resp.setStatus(HttpServletResponse.SC_OK);
                        resp.getWriter().write("La descripción se guardó correctamente.");
                        resp.getWriter().flush();
                        return;
                    } else {
                        // Ocurrió un error al guardar la descripción
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        resp.getWriter().write("No se pudo guardar la descripción.");
                        resp.getWriter().flush();
                        return;
                    }

                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }

                break;
            case "/exam/deleteQ":
                try {
                    Long idQuestion = Long.valueOf(req.getParameter("id_question"));
                    boolean resultS = new DaoExam().deleteQuestion(idQuestion);
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/create-Answer":
                try {
                    Long idQuestion = Long.valueOf(req.getParameter("Id_Question"));
                    boolean resultA = new DaoExam().createAnswer(idQuestion);
                    System.out.println(resultA);

                    if (resultA) {
                        Long idAnswer = new DaoExam().extractIdAnswer(idQuestion);
                        System.out.println("Id answer: "+idAnswer);
                        String questionIdStr = String.valueOf(idAnswer);

                        resp.getWriter().write(questionIdStr);
                        resp.getWriter().flush();
                        return;
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/save-answer":
                try {
                    Long id_answer = Long.valueOf(req.getParameter("id_answer"));
                    String answer = req.getParameter("answer");
                    Answer answer1;
                    answer1 = new Answer(id_answer,answer,false,null);

                    boolean result = new DaoExam().saveAnswer(answer1);
                    if (result) {
                        resp.setStatus(HttpServletResponse.SC_OK);
                        resp.getWriter().write("La respuesta se guardó correctamente.");
                        resp.getWriter().flush();
                        return;
                    } else {
                        // Ocurrió un error al guardar la descripción
                        resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                        resp.getWriter().write("No se pudo guardar la respuesta.");
                        resp.getWriter().flush();
                        return;
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/deleteA":
                try {
                    Long idAnswer = Long.valueOf(req.getParameter("id_answer"));
                    boolean resultDA = new DaoExam().deleteAnswer(idAnswer);
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            default:
                    System.out.println(action);
        }
        resp.sendRedirect(req.getContextPath() + redirect);
    }

}

