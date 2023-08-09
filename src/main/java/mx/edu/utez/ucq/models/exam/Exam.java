package mx.edu.utez.ucq.models.exam;

public class Exam {
    private Long id_exam;
    private String name_exam;
    private String code;
    private String start_time;
    private String end_time;
    private Long fk_user;

    public Exam() {
    }

    public Exam(Long id_exam, String name_exam, String code, String start_time, String end_time, Long fk_user) {
        this.id_exam = id_exam;
        this.name_exam = name_exam;
        this.code = code;
        this.start_time = start_time;
        this.end_time = end_time;
        this.fk_user = fk_user;
    }

    public Long getId_exam() {
        return id_exam;
    }

    public void setId_exam(Long id_exam) {
        this.id_exam = id_exam;
    }

    public String getName_exam() {
        return name_exam;
    }

    public void setName_exam(String name_exam) {
        this.name_exam = name_exam;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public Long getFk_user() {
        return fk_user;
    }

    public void setFk_user(Long fk_user) {
        this.fk_user = fk_user;
    }
}

