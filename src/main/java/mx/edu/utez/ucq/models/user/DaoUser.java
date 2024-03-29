package mx.edu.utez.ucq.models.user;

import mx.edu.utez.ucq.models.crud.DaoRepository;
import mx.edu.utez.ucq.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoUser implements DaoRepository<User>{
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

    public User loadUserByUsernameAndPassword(String loginCredential, String password) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT id_user, mail, type_user, name, lastname, surname FROM users " +
                    "WHERE (mail = ? OR enrollment = ?) AND password = ? AND status = 'Activo';";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, loginCredential);
            pstm.setString(2, loginCredential);
            pstm.setString(3, password);
            rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id_user"));
                user.setMail(rs.getString("mail"));
                user.setType_user(rs.getLong("type_user"));
                user.setName(rs.getString("name"));
                user.setLastname(rs.getString("lastname"));
                user.setSurname(rs.getString("surname"));
                return user;


            }

        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName())
                    .log(Level.SEVERE,
                            "Credentials mismatch: " + e.getMessage());
        } finally {
            close();
        }
        return null;
    }

    public User findOneByUser(long id) {
        System.out.println(id);
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from users where id_user = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, id);
            rs = pstm.executeQuery();
            if (rs.next()) {
                User user1 = new User();
                user1.setId(rs.getLong("id_user"));
                user1.setName(rs.getString("name"));
                user1.setLastname(rs.getString("lastname"));
                user1.setSurname(rs.getString("surname"));
                user1.setCurp(rs.getString("curp"));
                user1.setStatus(rs.getString("status"));
                user1.setType_user(rs.getLong("type_user"));
                user1.setMail(rs.getString("mail"));
                user1.setEnrollment(rs.getString("enrollment"));
                user1.setPassword(rs.getString("password"));
                return user1;
            }
        } catch (Exception e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR findOne" + e.getMessage());
        } finally {
            close();
        }
        return null;
    }

    @Override
    public User findAllp(String password){
        try{
            conn = new MySQLConnection().connect();
            String query = "SELECT name, lastname, curp, mail, password from users where password = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, password);
            rs = pstm.executeQuery();
            User user = new User();
            if (rs.next()){
                user.setName(rs.getString("name"));
                user.setLastname(rs.getString("lastname"));
                user.setCurp(rs.getString("curp"));
                user.setMail(rs.getString("mail"));
                user.setPassword(rs.getString("password"));
            }
            return user;
        }catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "ERROR findAllp" + e.getMessage());
        }finally {
            close();
        }
        return null;
    }

    @Override
    public List<User> findAll() {
        List<User> users = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from users;";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                User user = new User();
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setLastname(rs.getString("lastname"));
                user.setSurname(rs.getString("surname"));
                user.setCurp(rs.getString("curp"));
                user.setStatus(rs.getString("status"));
                user.setType_user(rs.getLong("type_user"));
                user.setMail(rs.getString("mail"));
                user.setEnrollment(rs.getString("enrollment"));
                user.setPassword(rs.getString("password"));
                users.add(user);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return users;
    }

    @Override
    public User findOne(long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from users where id_user = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id);
            rs = pstm.executeQuery();
            User user = new User();
            if (rs.next()){
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
                user.setLastname(rs.getString("lastname"));
                user.setSurname(rs.getString("surname"));
                user.setCurp(rs.getString("curp"));
                user.setStatus(rs.getString("status"));
                user.setType_user(rs.getLong("type_user"));
                user.setMail(rs.getString("mail"));
                user.setEnrollment(rs.getString("enrollment"));
                user.setPassword(rs.getString("password"));
            }
            return user;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return null;
    }
        @Override
        public boolean save(User object) {
            try {
                conn = new MySQLConnection().connect();
                String query = "call crear_usuarios(?, ?, ?, ?, ?, ?, ?, ?, ?);";
                pstm = conn.prepareStatement(query);
                pstm.setString(1,object.getName());
                pstm.setString(2,object.getLastname());
                pstm.setString(3,object.getSurname());
                pstm.setString(4, object.getCurp());
                pstm.setString(5,"Activo");
                pstm.setLong(6, object.getType_user());
                pstm.setString(7,object.getMail());
                pstm.setString(8,object.getEnrollment());
                pstm.setString(9,object.getPassword());
                int result = pstm.executeUpdate();
                System.out.println(result);
                return result > 0; // == 1
            }catch (SQLException e){
                Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
            }finally {
                close();
            }
            return false;
        }


        @Override
        public boolean
        update(User object) {
            try {
                conn = new MySQLConnection().connect();
                String query = "UPDATE users SET name = ?,lastname= ?, surname = ?, curp = ?, status = ?, mail = ?, enrollment = IFNULL(?, enrollment), password = ? where id_user = ?;";
                pstm = conn.prepareStatement(query);
                pstm.setString(1,object.getName());
                pstm.setString(2,object.getLastname());
                pstm.setString(3,object.getSurname());
                pstm.setString(4,object.getCurp());
                pstm.setString(5,object.getStatus());
                pstm.setString(6,object.getMail());
                pstm.setObject(7, object.getEnrollment());
                pstm.setString(8,object.getPassword());
                pstm.setLong(9,object.getId());
                return pstm.executeUpdate() == 1; // == 1
            }catch (SQLException e){
                Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
            }finally {
                close();
            }
            return false;
        }
    @Override
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM users where id_user = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public void close(){
        try {
            if(conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        }catch (SQLException e){

        }

    }

}
