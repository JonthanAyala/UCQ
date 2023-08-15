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
        "/exam/save-exam",
        "/exam/delete"
}) // Endpoints --> Acceso para el CRUD usuarios


public class ServletExam extends HttpServlet {
    private String action;
    private String redirect = "/exam/exams";

    private  String id, name, surname, lastname, username, birthday, status;
    private User user;
    private HttpSession session;


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
                Long fkUser = Long.valueOf(req.getParameter("fk_user"));
                session = req.getSession();
                session.setAttribute("user", user);
                id = req.getParameter("id_user");
                try {
                    // Recuperar los valores del formulario
                    String examCode = req.getParameter("exam-code");
                    String nameExam = req.getParameter("nameExam");

                    // Guardar examen y obtener su ID
                    Exam exam = new Exam(null, nameExam, examCode, null, null, fkUser);
                    boolean resultE = new DaoExam().saveExam(exam);

                    if (resultE) {
                        Long examId = new DaoExam().extractId(fkUser);
                    }
                }catch (Exception e) {
                    redirect = "/user/index-teacher?result=false&message=" + URLEncoder
                            .encode("Error no se guardo el examen2", StandardCharsets.UTF_8);
                }
                break;
            case "/exam/delete":
                Long userId = Long.valueOf(req.getParameter("id_user"));
                id = req.getParameter("id");
                if (new DaoExam().delete(Long.parseLong(id))) {
                    redirect = "/user/index-teacher?id_user="+ userId+"&?result="+true+"&message="+ URLEncoder.encode("¡Exito! Examen eliminado correctamente.", StandardCharsets.UTF_8);
                }else
                    redirect = "/user/index-teacher?id_user="+ userId+"&?result="+false+"&message="+ URLEncoder.encode("¡ERROR! Usuario no eliminado.", StandardCharsets.UTF_8);
                break;
            default:
                    System.out.println(action);
        }
        resp.sendRedirect(req.getContextPath() + redirect);
    }

}

