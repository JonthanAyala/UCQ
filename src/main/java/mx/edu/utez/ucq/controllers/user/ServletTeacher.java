package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.ucq.models.user.User;

import java.io.IOException;


@WebServlet(name = "teacher",urlPatterns = {
        "/teacher/view",

}) // Endpoints --> Acceso para el CRUD usuarios

public class ServletTeacher extends HttpServlet {

    private String action;
    private String redirect = "/user/users";
    HttpSession session;
    User user;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/teacher/view":
                session = req.getSession();
                req.setAttribute("user", user);
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

    }


}
