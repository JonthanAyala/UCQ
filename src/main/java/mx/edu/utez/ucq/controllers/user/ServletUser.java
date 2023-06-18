package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.models.user.User;

import java.awt.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

@WebServlet(name = "users",urlPatterns = {
        "/user/menuEs",
        "/user/menuProf",
        "/user/menuAdm",
        "/user/save",
        "/user/user-view-update",
        "/user/update",
        "/user/delete"
}) // Endpoints --> Acceso para el CRUD usuarios


public class ServletUser extends HttpServlet {
    private String action;
    private String redirect = "/user/users";

    private  String usuario, contra;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/user/users":
                List<User> users = new DaoUser().findAll();
                req.setAttribute("users", users);
                redirect = "/views/user/index.jsp";

                break;
            case "/user/user-view":
                //Consultas catalogos
                redirect = "/views/user/create.jsp";
                break;
            case "/user/user-view-update":

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
        if(action=){

            else{

            }
        }
        switch (action){
            case "/user/user-view-update":
                String id = req.getParameter("id");
                User user = new DaoUser().findOne(id != null ? Long.parseLong(id): 0);
                if (user != null){
                    req.setAttribute("user", user);
                    redirect = "/views/user/update.jsp";
                }else {
                    redirect = "/user/users";
                }
                break;
            case "/user/save":
                usuario = req.getParameter("usuario");
                contra = req.getParameter("contra");
                User user1 = new User(0L, name, surname, lastname, birthday, username, status);
                boolean result = new DaoUser().save(user1);
                if (result){
                    redirect = "/user/users?result="+result+"&message="+ URLEncoder.encode("¡Exito! Usuario registrado correctamente.", StandardCharsets.UTF_8);

                }else {
                    redirect = "/user/users?result="+result+"&message="+ URLEncoder.encode("Error accion no realizada correctamente.", StandardCharsets.UTF_8);

                }
                break;
            default:
                System.out.println(action);
        }
    }

}
