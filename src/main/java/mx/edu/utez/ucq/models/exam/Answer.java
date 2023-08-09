package mx.edu.utez.ucq.models.exam;

public class Answer {
    private Long id_question_answer;
    private String answer;
    private boolean if_answer;
    private Long fk_question;

    public Answer() {
    }

    public Answer(Long id_question_answer, String answer, boolean if_answer, Long fk_question) {
        this.id_question_answer = id_question_answer;
        this.answer = answer;
        this.if_answer = if_answer;
        this.fk_question = fk_question;
    }

    public Long getId_question_answer() {
        return id_question_answer;
    }

    public void setId_question_answer(Long id_question_answer) {
        this.id_question_answer = id_question_answer;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public boolean isIf_answer() {
        return if_answer;
    }

    public void setIf_answer(boolean if_answer) {
        this.if_answer = if_answer;
    }

    public Long getFk_question() {
        return fk_question;
    }

    public void setFk_question(Long fk_question) {
        this.fk_question = fk_question;
    }
}
