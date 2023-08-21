package mx.edu.utez.ucq.models.user;

import mx.edu.utez.ucq.models.crud.DaoRepository;
import mx.edu.utez.ucq.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoTeacher implements DaoRepository<User> {

    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

    @Override
    public List<User> findAll() {
        return null;
    }

    @Override
    public User findAllp(String password) {
        return null;
    }

    @Override
    public User findOne(long id) {
        return null;
    }

    @Override
    public boolean save(User object) {
        return false;
    }

    @Override
    public boolean update(User object) {
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
                Logger.getLogger(DaoTeacher.class.getName()).log(Level.SEVERE,"Error save"+e.getMessage());
            }finally {
                close();
            }
            return false;
    }

    @Override
    public boolean delete(Long id) {
        return false;
    }

    @Override
    public User loadUserByUsernameAndPassword(String mail, String password) {
        return null;
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
