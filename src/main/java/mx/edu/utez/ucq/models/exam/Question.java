package mx.edu.utez.ucq.models.exam;

public class Question {
    private long id_question;
    private String url_image;
    private Long type_question;
    private String Description;
    private Long points;
    private Long fk_exam;

    public Question() {
    }

    public Question(Long id_question, String url_image, Long type_question, String description, Long points, Long fk_exam) {
        this.id_question = id_question;
        this.url_image = url_image;
        this.type_question = type_question;
        this.Description = description;
        this.points = points;
        this.fk_exam = fk_exam;
    }

    public long getId_question() {
        return id_question;
    }

    public void setId_question(long id_question) {
        this.id_question = id_question;
    }

    public String getUrl_image() {
        return url_image;
    }

    public void setUrl_image(String url_image) {
        this.url_image = url_image;
    }

    public Long getType_question() {
        return type_question;
    }

    public void setType_question(Long type_question) {
        this.type_question = type_question;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public Long getPoints() {
        return points;
    }

    public void setPoints(Long points) {
        this.points = points;
    }

    public Long getFk_exam() {
        return fk_exam;
    }

    public void setFk_exam(Long fk_exam) {
        this.fk_exam = fk_exam;
    }
}
