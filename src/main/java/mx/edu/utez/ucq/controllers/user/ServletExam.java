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
        "/exam/deleteA",
        "/exam/if-answer",
        "/exam/comenzar",
        "/exam/terminar",
        "/exam/find-exam",
        "/exam/redirect",
        "/exam/IdsQ",
        "/exam/create-studen-exam",
        "/exam/enviar",
        "/exam/create-student-answer",
        "/exam/update-student-answer",
        "/exam/update-student-answer-open",
        "/exam/create-student-answer-open"
}) // Endpoints --> Acceso para el CRUD usuarios


public class ServletExam extends HttpServlet {
    private String action;
    private String redirect = "";

    private  String name, surname, lastname, username, birthday, status;
    private Long id_user, id_exam;
    private User user;
    private HttpSession session;


    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/exam/redirect":
                User user6 = (User) session.getAttribute("user");// se guardan los datos en un objeto
                System.out.println(session);// pa ver si hay una sesion
                switch (Math.toIntExact(user.getType_user())){
                    case 1:
                        redirect = "/user/admin";
                        break;
                    case 2:
                        redirect = "/user/index-teacher";
                        break;
                    case 3:
                        redirect = "/user/student";
                        break;
                    default:
                        redirect = "/user/view-login?result=false&message=" + URLEncoder
                                .encode("Error grave", StandardCharsets.UTF_8);
                        break;
                }
                break;
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
                id_exam = Long.valueOf(req.getParameter("id"));
                if (new DaoExam().delete(id_exam)) {
                    redirect = "/user/index-teacher";
                }else
                    redirect = "/user/index-teacher";
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
                    System.out.println(idQuestion);
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
            case "/exam/if-answer":
                try {
                    Long idQ = Long.valueOf(req.getParameter("IdPregunta"));
                    Long idAnswer = Long.valueOf(req.getParameter("IdA"));
                    System.out.println(idQ+","+idAnswer);
                    boolean resultDA = new DaoExam().answerif(idQ,idAnswer);

                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/comenzar":
                id_exam = Long.valueOf(req.getParameter("id"));
                if (new DaoExam().comenzar(id_exam)) {
                    redirect = "/user/index-teacher";
                }else
                    redirect = "/user/index-teacher";
                break;
            case "/exam/terminar":
                id_exam = Long.valueOf(req.getParameter("id"));
                if (new DaoExam().terminar(id_exam)) {
                    redirect = "/user/index-teacher";
                }else
                    redirect = "/user/index-teacher";
                break;
            case "/exam/find-exam":
                try {
                    String codigo = req.getParameter("codigo");
                    id_exam = new DaoExam().findExam(codigo);
                    System.out.println("IdExam "+id_exam);
                    if (id_exam != null) {
                        HttpSession session = req.getSession();
                        session.setAttribute("id_exam", id_exam);
                        redirect = "/user/view-exam";
                    }else {
                        redirect = "/user/student";
                    }
                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/enviar":
                try {

                }catch (Exception e) {
                    e.printStackTrace(); // Imprime detalles del error para el diagnóstico
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/create-student-answer":
                Long id_A = Long.parseLong(req.getParameter("id_A"));
                Long id_Q = Long.parseLong(req.getParameter("id_Q"));
                Long id_SE = Long.parseLong(req.getParameter("id_SE"));

                // Llama a la función para crear una nueva respuesta de estudiante
                boolean resultCreate = new DaoExam().createStudentAnswer(id_A, id_Q, id_SE);
                if (resultCreate) {
                    Long resultID = new DaoExam().extractIDStudentAnswer(id_SE);
                    resp.getWriter().write(String.valueOf(resultID));
                    resp.getWriter().flush();
                    return;
                } else {
                    // Manejo de error en la creación de respuesta
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/update-student-answer":
                Long id_SE_A = Long.parseLong(req.getParameter("id_SE_A"));
                Long id_A2 = Long.parseLong(req.getParameter("id_A"));

                // Llama a la función para actualizar la respuesta de estudiante
                boolean resultUpdate = new DaoExam().updateStudentAnswer(id_SE_A,id_A2);
                if (resultUpdate) {
                    // Respuesta exitosa
                    resp.getWriter().write("Respuesta actualizada");
                } else {
                    // Manejo de error en la actualización de respuesta
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }
                break;
            case "/exam/create-student-answer-open":
                String answer = req.getParameter("Answer");
                Long id_Question = Long.parseLong(req.getParameter("id_Q"));
                Long id_Student_Exam = Long.parseLong(req.getParameter("id_SE"));

                boolean resultCreateAO = new DaoExam().createStudentAnswerOpen(id_Question,id_Student_Exam,answer);
                if (resultCreateAO) {
                    Long resultID = new DaoExam().extractIDStudentAnswer(id_Student_Exam);
                    resp.getWriter().write(String.valueOf(resultID));
                    resp.getWriter().flush();
                    return;
                } else {
                    // Manejo de error en la creación de respuesta
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }

                break;
            case "/exam/update-student-answer-open":
                String updatedAnswer = req.getParameter("Answer");
                Long id_Student_Exam_Answer = Long.parseLong(req.getParameter("id_SE_A"));

                boolean resultUpdateOpen = new DaoExam().updateStudentAnswerOpen(id_Student_Exam_Answer,updatedAnswer);
                if (resultUpdateOpen) {
                    // Respuesta exitosa
                    resp.getWriter().write("Respuesta actualizada");
                } else {
                    // Manejo de error en la actualización de respuesta
                    resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                }

                break;
            default:
                    System.out.println(action);
        }
        resp.sendRedirect(req.getContextPath() + redirect);
    }

}

