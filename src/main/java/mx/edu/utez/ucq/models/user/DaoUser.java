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

    public User loadUserByUsernameAndPassword(String enrollment, String password) {
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT enrollment, password, type_user FROM users u " +
                    "WHERE u.username = ? AND u.password = ? AND u.status = 'Activo';";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, enrollment);
            pstm.setString(2, password);
            rs = pstm.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getLong("id"));
                user.setEnrollment(rs.getString("enrollment"));
                user.setType_user(rs.getLong("type_user"));
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
            String query = "SELECT * from users where id = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id);
            rs = pstm.executeQuery();
            User user = new User();
            if (rs.next()){
                user.setId(rs.getLong("id_user"));
                user.setName(rs.getString("name"));
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
                String query = "INSERT INTO users (name, surname, curp, status, type_user, mail, enrollment, password) VALUES (?, ?, ?, ?, ?, ?, ?, ?);";
                pstm = conn.prepareStatement(query);
                pstm.setString(1,object.getName());
                pstm.setString(2,object.getSurname());
                pstm.setString(3, object.getCurp());
                pstm.setString(4,object.getStatus());
                pstm.setLong(5, object.getType_user());
                pstm.setString(6,object.getMail());
                pstm.setString(7,object.getEnrollment());
                pstm.setString(8,object.getPassword());
                return pstm.executeUpdate() > 0; // == 1

            }catch (SQLException e){
                Logger.getLogger(DaoUser.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
            }finally {
                close();
            }
            return false;
        }


        @Override
        public boolean update(User object) {
            try {
                conn = new MySQLConnection().connect();
                String query = "UPDATE users SET name = ?, surname = ?, curp = ?, status = ?, type_user = ?, mail = ?, enrollment = ?, password = ? where id = ?";
                pstm = conn.prepareStatement(query);
                pstm.setString(1,object.getName());
                pstm.setString(2,object.getSurname());
                pstm.setString(3, object.getCurp());
                pstm.setString(4,object.getStatus());
                pstm.setLong(5,object.getType_user());
                pstm.setString(6,object.getMail());
                pstm.setString(7,object.getEnrollment());
                pstm.setString(8,object.getPassword());
                pstm.setLong(9,object.getId());
                return pstm.executeUpdate() > 0; // == 1
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
            String query = "DELETE FROM users where id = ?";
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
