package tresenratllapersistent;

public class Jugador {

    private String nom;
    private int punts = 0;
    private int ranking;

    public Jugador(String nom) {
        this.nom = nom;
    }

    public Jugador() {

    }

    public String getNom() {
        return nom;
    }

    public int getPunts() {
        return punts;
    }

    public int getRanking() {
        return ranking;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setPunts(int punts) {

        this.punts += punts;
    }

    public void setRanking(int ranking) {

        this.ranking = ranking;
    }
}
