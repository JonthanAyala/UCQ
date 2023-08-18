package mx.edu.utez.ucq.controllers.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mx.edu.utez.ucq.models.exam.DaoExam;
import mx.edu.utez.ucq.models.exam.Exam;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.models.user.User;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;


    @WebServlet(name = "users",urlPatterns = {
            "/ucq",
            "/user/admin",			//admin index
            "/user/user",			//
            "/user/user-view",		//crear alumnos
            "/user/save-teacher",
            "/user/save-student",   //guardar alumnos
            "/user/user-view-update", 	//actualizar alumnos
            "/user/update",			// guardar actualizar alumnos
            "/user/delete",			//borrar
            "/user/view-view-teacher", 	//crear profesores
            "/user/student",//index student
            "/user/login",
            "/user/logout",
            "/user/view-login",
            "/user/users",
              //Nuevas Bojita
            "/user/index-teacher",//menú principal maestros
            "/user/mark-exam",
            "/user/profile",
            "/user/profile-s",
            "/user/profile-a",
            "/user/view-exam"

})


public class ServletUser extends HttpServlet {
    private String action;
    private String redirect = "/user/users";
    HttpSession session;
    private  String id, name, lastname, surname, curp,status, type_user, mail, enrollment, password, loginCredential;
    private User user;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        action = req.getServletPath();
        switch (action){
            case "/ucq":
                redirect = "/index.jsp";
                break;
            case "/user/admin":
                List<User> users = new DaoUser().findAll();
                req.setAttribute("users", users);
                redirect = "/views/admin/index.jsp";
                break;
            case "/user/user-view-update":
                id= req.getParameter("id");
                User user3 = new DaoUser().findOne(id != null ? Long.parseLong(id):0);
                if(user3 !=null){
                    req.setAttribute("user",user3);
                    redirect = "/views/user/update.jsp";
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
            case "/user/index-teacher":
                User user2 = (User) session.getAttribute("user");// se guardan los datos en un objeto
                System.out.println(session);// pa ver si hay una sesion
                Long userId = user2.getId(); // se obtiene el campo a utilizar
                System.out.println("1User ID: " + userId); // simplemente pa verlo en pantalla
                List<Exam> exams = new DaoExam().findAllExam(userId);
                req.setAttribute("exams",exams);
                redirect="/views/teacher/index.jsp";
                break;
            case "/user/mark-exam":
                redirect="/views/teacher/markExam.jsp";
                break;
            case  "/user/profile":
                redirect = "/views/teacher/profileTeacher.jsp";
                break;
            case  "/user/profile-s":
                redirect = "/views/student/profileStudent.jsp";
                break;
            case  "/user/profile-a":
                redirect = "/views/admin/profileAdmin.jsp";
                break;
            case "/user/view-exam":
                redirect = "/views/student/exam.jsp";
                break;
            case "/user/logout":
                try {
                    HttpSession session = req.getSession(false);  // Obtener la sesión existente (sin crear una nueva)
                    if (session != null) {
                        session.invalidate();  // Invalidar la sesión para cerrarla
                    }
                    redirect = "/user/view-login?result=true&message=" + URLEncoder
                            .encode("Sesión cerrada correctamente", StandardCharsets.UTF_8);
                } catch (Exception e) {
                    int userType = (user != null) ? Math.toIntExact(user.getType_user()) : -1;
                    switch (userType) {
                        case 1:
                            redirect = "/user/admin?result=false&message=" + URLEncoder
                                    .encode("Error al cerrar sesión", StandardCharsets.UTF_8);
                            break;
                        case 2:
                            redirect = "/user/index-teacher?result=false&message=" + URLEncoder
                                    .encode("Error al cerrar sesión", StandardCharsets.UTF_8);
                            break;
                        case 3:
                            redirect = "/user/student?result=false&message=" + URLEncoder
                                    .encode("Error al cerrar sesión", StandardCharsets.UTF_8);
                            break;
                        default:
                            redirect = "/user/view-login?result=false&message=" + URLEncoder
                                    .encode("Usuario afectado, contacta al administrador", StandardCharsets.UTF_8);
                            break;
                    }
                }
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
            case "/user/login":
                loginCredential = req.getParameter("loginCredential");
                password = req.getParameter("password");
                try {
                    user = new DaoUser()
                            .loadUserByUsernameAndPassword(loginCredential, password);

                    if (user != null) {
                        session = req.getSession();
                        session.setAttribute("user", user);
                        System.out.println(session);
                        switch (Math.toIntExact(user.getType_user())) {
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
                                        .encode("Usuario Afectado acude al administrador",
                                                StandardCharsets.UTF_8);
                                break;
                        }
                    } else {
                        redirect = "/user/view-login?result=false&message=" + URLEncoder
                                .encode("Credenciales inválidas. Intenta de nuevo",
                                        StandardCharsets.UTF_8);
                    }
                } catch (Exception e) {
                    redirect = "/user/view-login?result=false&message=" + URLEncoder
                            .encode("Usuario y/o contraseña incorrecta",
                                    StandardCharsets.UTF_8);
                }
                break;

            case "/user/update":
                id = req.getParameter("id");
                name = req.getParameter("name");
                lastname = req.getParameter("lastname");
                surname = req.getParameter("surname");
                curp = req.getParameter("curp");
                status = "Activo";
                type_user = req.getParameter("type_user");
                mail = req.getParameter("mail");
                if (Long.parseLong(type_user) == 2) {
                    enrollment = null;
                } else {
                    enrollment = req.getParameter("enrollment");
                }
                password = req.getParameter("password");
                user = new User(Long.parseLong(id), name, lastname, surname, curp, status, Long.parseLong(type_user), mail, enrollment, password);

                if (new DaoUser().update(user)){
                    redirect = "/user/admin?result="+true+"&message="+ URLEncoder.encode("¡Exito! Usuario actualizado correctamente.", StandardCharsets.UTF_8);

                }else {
                    redirect = "/user/admin?result="+false+"&message="+ URLEncoder.encode("Error accion no actualizado correctamente.", StandardCharsets.UTF_8);

                }
                break;
            case "/user/save-teacher":
                name = req.getParameter("name");
                lastname = req.getParameter("lastname");
                surname = req.getParameter("surname");
                curp = req.getParameter("curp");
                mail = req.getParameter("mail");
                enrollment = req.getParameter("enrollment");
                password = req.getParameter("password");
                User user1 = new User(0L, name, lastname, surname, curp, "Activo", 2L, mail, enrollment, password);

                boolean result = new DaoUser().save(user1);
                if (result){
                    redirect = "/user/admin?result="+result+"&message="+ URLEncoder.encode("¡Exito! Usuario registrado correctamente.", StandardCharsets.UTF_8);
                }else {
                    redirect = "/user/admin?result="+result+"&message="+ URLEncoder.encode("Error accion no realizada correctamente.", StandardCharsets.UTF_8);
                }
                break;
            case "/user/save-student":
                name = req.getParameter("name");
                lastname = req.getParameter("lastname");
                surname = req.getParameter("surname");
                curp = req.getParameter("curp");
                mail = req.getParameter("mail");
                enrollment = req.getParameter("enrollment");
                password = req.getParameter("password");
                User user = new User(0L, name, lastname, surname, curp, "Activo", 3L, mail, enrollment, password);

                boolean result2 = new DaoUser().save(user);
                if (result2){
                    redirect = "/user/admin?result="+result2+"&message="+ URLEncoder.encode("¡Exito! Usuario registrado correctamente.", StandardCharsets.UTF_8);

                }else {
                    redirect = "/user/admin?result="+result2+"&message="+ URLEncoder.encode("Error accion no realizada correctamente.", StandardCharsets.UTF_8);

                }
                break;
            case "/user/delete":
                id = req.getParameter("id");
                if (new DaoUser().delete(Long.parseLong(id))) {
                    redirect = "/user/admin?result="+true+"&message="+ URLEncoder.encode("¡Exito! Usuario eliminado correctamente.", StandardCharsets.UTF_8);
                }else
                    redirect = "/user/admin?result="+false+"&message="+ URLEncoder.encode("¡ERROR! Usuario no eliminado.", StandardCharsets.UTF_8);

                break;

        }
        resp.sendRedirect(req.getContextPath()+ redirect);
    }

}
