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
                user.setId(rs.getLong("id"));
                user.setUsuario(rs.getString("usuario"));
                user.setContra(rs.getString("contra"));
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
                user.setId(rs.getLong("id"));
                user.setUsuario(rs.getString("name"));
                user.setContra(rs.getString("lastname"));

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
            String query = "insert into users (name, surname, lastname, username, birthday, status) Values (?,?,?,?,?,?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getName());
            pstm.setString(2,object.getSurname());
            pstm.setString(3, object.getLastname());
            pstm.setString(4,object.getUsername());
            pstm.setString(5, object.getBirthday());
            pstm.setString(6,object.getStatus());
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
            String query = "UPDATE users set name = ?, surname = ?, lastname = ?, username = ?, birthday = ?, status = ?, status = ? where id = ?";

            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getUsuario());
            pstm.setString(2,object.getContra());
            pstm.setString(3, object.getLastname());
            pstm.setString(4,object.getUsername());
            pstm.setString(5,object.getBirthday());
            pstm.setString(6,object.getStatus());
            pstm.setString(7,object.getId());
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
            String query = "DELETE users where id = ?";
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