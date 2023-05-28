package lordsofsteel;

public class MaiaCaos extends Maia implements Caos {

    @Override
    public boolean contraatac(int tirada, int atacar, int salut) {
        atacar = (atacar / 2);
        if (tirada <= atacar) {
            salut -= atacar;
            return true;
        }
        return false;
    }

}
