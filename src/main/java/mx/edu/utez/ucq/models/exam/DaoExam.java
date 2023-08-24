package mx.edu.utez.ucq.models.exam;

import mx.edu.utez.ucq.models.Respuestas.ExamDetails;
import mx.edu.utez.ucq.models.user.DaoUser;
import mx.edu.utez.ucq.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DaoExam{
    private Connection conn;
    private PreparedStatement pstm;
    private ResultSet rs;

    public boolean saveExam(Exam object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO exams (name_exam, code, fk_user) VALUES (?, ?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getName_exam());
            pstm.setString(2, object.getCode());
            pstm.setLong(3, object.getFk_user());
            return pstm.executeUpdate() > 0 ;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean updateExam(Exam object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET name_exam = ? WHERE id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getName_exam());
            pstm.setLong(2,object.getId_exam());
            System.out.println(pstm.executeUpdate());
            return pstm.executeUpdate() > 0 ;
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error update" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    public boolean saveQuestion(Question object) {
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions (type_question, fk_exam) VALUES (?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, object.getType_question());
            pstm.setLong(2,object.getFk_exam());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la pregunta"+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveDescription(Question object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions SET description = ? WHERE id_Question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, object.getDescription());
            pstm.setLong(2,object.getId_question());
            int result = pstm.executeUpdate();
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveScore(Question object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions SET points = ? WHERE id_Question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,object.getPoints());
            pstm.setLong(2,object.getId_question());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la puntuacion: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean deleteQuestion(Long idQuestion){
        try {
        conn = new MySQLConnection().connect();
        String query = "DELETE FROM questions WHERE id_Question = ?;";
        pstm = conn.prepareStatement(query);
        pstm.setLong(1,idQuestion);
        int result = pstm.executeUpdate();
        System.out.println("Pregunta Eliminada: "+result);
        return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }

    //crear ID respuesta y colocar la descripcion, si es correcta etc.
    public boolean createAnswer(Long idQ){
        try {
            conn = new MySQLConnection().connect();
            String query = "INSERT INTO questions_answer (fk_question) VALUES (?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, idQ);
            int result = pstm.executeUpdate();
            System.out.println("Se creo la respuesta "+idQ+": "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean saveAnswer(Answer object){
        try {
            conn = new MySQLConnection().connect();
            String query = "UPDATE questions_answer SET answer = ? WHERE id_Question_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1,object.getAnswer());
            pstm.setLong(2,object.getId_answer());
            int result = pstm.executeUpdate();
            System.out.println("Se guardo la respuesta: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean answerif(Long idQ, Long idAnswer){
        try {
            conn = new MySQLConnection().connect();
            String query = "CALL respuestasif(?, ?);";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idQ);
            pstm.setLong(2,idAnswer);
            int result = pstm.executeUpdate();
            System.out.println("Se hizo? : "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public boolean deleteAnswer(Long idA){
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM questions_answer WHERE id_Question_answer = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idA);
            int result = pstm.executeUpdate();
            System.out.println("Respuesta Eliminada: "+result);
            return result > 0;
        } catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error save" + e.getMessage());
        } finally {
            close();
        }
        return false;
    }
    public List<Exam> findAllExam(Long id) {
        List<Exam> exams = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * from exams where fk_user = "+id+";";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                Exam exam = new Exam();
                exam.setId_exam(rs.getLong("id_exam"));
                exam.setName_exam(rs.getString("name_exam"));
                exam.setCode(rs.getString("code"));
                exam.setStart_time(rs.getString("start_time"));
                exam.setEnd_time(rs.getString("end_time"));
                exam.setFk_user(rs.getLong("fk_user"));
                exams.add(exam);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return exams;
    }


    public void close(){
        try {
            if(conn != null) conn.close();
            if (pstm != null) pstm.close();
            if (rs != null) rs.close();
        }catch (SQLException e){

        }

    }

    public Long extractId(Long userId) {
        Long id = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_exam) AS id_exam FROM exams WHERE fk_user = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, String.valueOf(userId));
            rs = pstm.executeQuery();
            if (rs.next()) {
                id = rs.getLong("id_exam"); // Obtener el valor de la columna "id_exam"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error extractId"+e.getMessage());
        }finally {
            close();
        }
        return id;
    }
    public Long extractIdQuestion(Long fk_exam) {
        Long id_question = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Question) AS id_question FROM questions where fk_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, String.valueOf(fk_exam));
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_question = rs.getLong("id_question"); // Obtener el valor de la columna "id_question"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return id_question;
    }
    public Long extractIdAnswer(Long idQuestion){
        Long id_answer = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT MAX(id_Question_answer) AS id_Question_answer FROM questions_answer where fk_question = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,idQuestion);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_answer = rs.getLong("id_Question_answer"); // Obtener el valor de la columna "id_question"
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return id_answer;

    }
    public boolean delete(Long id) {
        try {
            conn = new MySQLConnection().connect();
            String query = "DELETE FROM exams where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }


    public boolean comenzar(Long id_exam){
        try {
            // UPDATE `ucq_chido`.`exams` SET `start_time` = 'sysdate()' WHERE (`id_exam` = '53');
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET start_time = sysdate() where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id_exam);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }
    public boolean terminar(Long id_exam){
        try {
            // UPDATE `ucq_chido`.`exams` SET `start_time` = 'sysdate()' WHERE (`id_exam` = '53');
            conn = new MySQLConnection().connect();
            String query = "UPDATE exams SET end_time = sysdate() where id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1,id_exam);
            return  pstm.executeUpdate() == 1;
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error delete"+e.getMessage());
        }finally {
            close();
        }
        return false;
    }

    public List<ExamDetails> findAllExamS(Long id) {
        List<ExamDetails> exams = new ArrayList<>();
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM ExamDetails WHERE id_s = "+id+";";
            pstm = conn.prepareStatement(query);
            rs = pstm.executeQuery();
            while (rs.next()){
                ExamDetails examsd = new ExamDetails();
                examsd.setId_Student_exam(rs.getLong("id_Student_exam"));
                examsd.setStart_date(rs.getString("start_date"));
                examsd.setEnd_date(rs.getString("end_date"));
                examsd.setName_exam(rs.getString("name_exam"));
                examsd.setProfessor_name(rs.getString("professor_name"));
                examsd.setId_s(rs.getLong("id_s"));
                exams.add(examsd);
            }
        }catch (SQLException e){
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findAll"+e.getMessage());
        }finally {
            close();
        }
        return exams;
    }

    // Buscar examen
    public Long findExam(String code) {
        Long id_exam = null;
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT id_exam from exams where code = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setString(1, code);
            rs = pstm.executeQuery();
            if (rs.next()) {
                id_exam = rs.getLong("id_exam"); // Obtener el valor de la columna
            }
        }catch (SQLException e) {
            Logger.getLogger(DaoExam.class.getName()).log(Level.SEVERE, "Error findExam"+e.getMessage());
        }finally {
            close();
        }
        return id_exam;
    }
    public Exam LoadExam(Long id_exam){
        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT * FROM exams WHERE id_exam = ?;";
            pstm = conn.prepareStatement(query);
            pstm.setLong(1, id_exam);

            rs = pstm.executeQuery();
            if (rs.next()) {
                Exam exam = new Exam();
                exam.setId_exam(rs.getLong("id_exam"));
                exam.setName_exam(rs.getString("name_exam"));
                exam.setCode(rs.getString("code"));
                exam.setStart_time(rs.getString("start_time"));
                exam.setEnd_time(rs.getString("end_time"));
                exam.setFk_user(rs.getLong("fk_user"));
                return exam;
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

    public Long[] finQuestions(Long idE) {
        Long[] ids = null;
        int rowCount = 0;

        try {
            conn = new MySQLConnection().connect();
            String query = "SELECT id_Question FROM questions WHERE fk_exam = ?;";
            pstm = conn.prepareStatement(query,ResultSet.TYPE_SCROLL_INSENSITIVE);
            pstm.setLong(1, idE);
            rs = pstm.executeQuery();

            while (rs.next()) {
                rowCount++;  // Incrementa el contador de filas
            }

            // Vuelve a configurar el ResultSet para que esté en la primera fila
            rs.beforeFirst();

            ids = new Long[rowCount];  // Inicializa el arreglo con el tamaño adecuado
            int index = 0;

            while (rs.next()) {
                ids[index] = rs.getLong("id_Question");
                index++;
            }
        } catch (SQLException e) {
            Logger.getLogger(DaoUser.class.getName())
                    .log(Level.SEVERE,
                            "Credentials mismatch: " + e.getMessage());
        } finally {
            close();
        }
        return ids;
    }

}
