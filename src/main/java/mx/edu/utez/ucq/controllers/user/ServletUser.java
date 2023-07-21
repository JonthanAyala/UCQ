package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.models.user.User;

import java.awt.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


    @WebServlet(name = "users",urlPatterns = {
            "/user/admin",			//admin index
            "/user/user",			//
            "/user/user-view",		//crear alumnos
            "/user/save",			//guardar alumnos
            "/user/user-view-update", 	//actualizar alumnos
            "/user/update",			// guardar actualizar alumnos
            "/user/delete",			//borrar

            "/user/view-view-teacher", 	//crear profesores

            "/user/student",//index student

            "/user/login",
            "/user/view-login",
            "/user/users"
})


public class ServletUser extends HttpServlet {
    private String action;
    private String redirect = "/user/users";
    HttpSession session;
    private  String id, name, surname, curp,status, type_user, mail, enrollment, password;
    private User user;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/user/admin":
                List<User> users = new DaoUser().findAll();
                req.setAttribute("users", users);
                redirect = "/views/admin/index.jsp";
                break;

            case "/user/user-view":
                redirect = "/views/admin/create-students.jsp";
                break;

            case "/user/view-view-teacher":
                redirect="/views/admin/create-teacher.jsp";
                break;

            case "/user/user-view-update":
                id= req.getParameter("id");
                User user3 = new DaoUser().findOne(id != null ? Long.parseLong(id):0);
                if(user3 !=null){
                    req.setAttribute("user",user3);
                    redirect = "/views/admin/";
                }else {
                    redirect = "/user/users?result" + false +
                            "&messages" + URLEncoder.encode("", StandardCharsets.UTF_8);
                }
                break;

            case "/user/student":
                redirect = "/views/student/index.jsp";
                break;

            case "/user/view-login":
                redirect="/views/logIn/createLogIn.jsp";
                break;
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
            /*case "/user/login":
                enrollment = req.getParameter("enrollment");
                password = req.getParameter("password");
                try {
                    user = new DaoUser()
                            .loadUserByUsernameAndPassword(enrollment, password);
                    if (user != null) {
                        session = req.getSession();
                        session.setAttribute("user", user);
                        switch (Math.toIntExact(user.getType_user())) {
                            case 1:
                                redirect = "/user/admin";
                                break;
                            case 2:
                                redirect = "/user/student";
                                break;
                        }
                    } else {
                        throw new Exception("Credentials mismatch");

                    }
                } catch (Exception e) {
                    redirect = "/api/auth?result=false&message=" + URLEncoder
                            .encode("Usuario y/o contraseña incorrecta",
                                    StandardCharsets.UTF_8);
                }
                break;*/
            case "/user/update":
                id = req.getParameter("id");
                name = req.getParameter("name");
                surname = req.getParameter("surname");
                curp = req.getParameter("curp");
                status = req.getParameter("status");
                type_user = req.getParameter("type_user");
                mail = req.getParameter("mail");
                enrollment = req.getParameter("enrollment");
                password = req.getParameter("password");
                user = new User(Long.parseLong(id), name, surname, curp, status, Long.parseLong(type_user), mail, enrollment, password);
                if (new DaoUser().update(user)){
                    redirect = "/user/users?result="+true+"&message="+ URLEncoder.encode("¡Exito! Usuario actualizado correctamente.", StandardCharsets.UTF_8);

                }else {
                    redirect = "/user/users?result="+false+"&message="+ URLEncoder.encode("Error accion no actualizado correctamente.", StandardCharsets.UTF_8);

                }
                break;
            case "/user/save":
                name = req.getParameter("name");
                surname = req.getParameter("surname");
                curp = req.getParameter("curp");
                status = req.getParameter("status");
                type_user = req.getParameter("type_user");
                mail = req.getParameter("mail");
                enrollment = req.getParameter("enrollment");
                password = req.getParameter("password");
                User user1 = new User(0L, name, surname, curp, status, Long.parseLong(type_user), mail, enrollment, password);

                boolean result = new DaoUser().save(user1);
                if (result){
                    redirect = "/user/users?result="+result+"&message="+ URLEncoder.encode("¡Exito! Usuario registrado correctamente.", StandardCharsets.UTF_8);

                }else {
                    redirect = "/user/users?result="+result+"&message="+ URLEncoder.encode("Error accion no realizada correctamente.", StandardCharsets.UTF_8);

                }
                break;
            case "/user/delete":
                id = req.getParameter("id");
                if (new DaoUser().delete(Long.parseLong(id))) {
                    redirect = "/user/users?result="+true+"&message="+ URLEncoder.encode("¡Exito! Usuario eliminado correctamente.", StandardCharsets.UTF_8);
                }else
                    redirect = "/user/users?result="+false+"&message="+ URLEncoder.encode("¡ERROR! Usuario no eliminado.", StandardCharsets.UTF_8);

                break;
        }
        resp.sendRedirect(req.getContextPath()+ redirect);
    }

}
