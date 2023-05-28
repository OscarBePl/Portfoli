package lordsofsteel;

public class Arma {

    private int WPOW;
    private int WVEL;
    private String nom;

    public Arma(int poder, int velocitat) {
        WPOW = poder;
        WVEL = velocitat;
    }

    public Arma() {
    }

    public int getWPOW() {
        return WPOW;
    }

    public int getWVEL() {
        return WVEL;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }
}
