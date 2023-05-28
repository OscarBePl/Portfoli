package lordsofsteel;

public class Mitja extends Personatge {

    public Mitja(String nom, int força, int constitucio, int velocitat, int inteligencia, int sort, Arma arma) {
        super(nom, força, constitucio, velocitat, inteligencia, sort, arma);
    }

    @Override
    public void calcularSecundaries(int CON, int FOR, int INT, int SOR, int VEL, Arma arma) {

        int PS = CON + FOR;
        int PD = (FOR + arma.getWPOW()) / 4;
        int PA = INT + SOR + arma.getWVEL();
        int PE = VEL + SOR + INT + FOR;

        setSalut(PS);
        setDany(PD);
        setAtacar(PA);
        setEsquivar(PE);
    }

    public Mitja() {

    }

}
