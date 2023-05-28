package lordsofsteel;

public class Maia extends Personatge {

    public Maia(String nom, int força, int constitucio, int velocitat, int inteligencia, int sort, Arma arma) {
        super(nom, força, constitucio, velocitat, inteligencia, sort, arma);
    }

    @Override
    public void calcularSecundaries(int CON, int FOR, int INT, int SOR, int VEL, Arma arma) {

        int PS = CON + FOR;
        int PD = (FOR + arma.getWPOW()) / 4;
        int PA = INT + SOR + arma.getWVEL() + VEL;
        int PE = VEL + SOR + INT;

        setSalut(PS);
        setDany(PD);
        setAtacar(PA);
        setEsquivar(PE);
    }

    public Maia() {

    }
}
