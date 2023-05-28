package lordsofsteel;

public class NanOrdre extends Nan implements Ordre {

    @Override
    public int recuperarSalut(int salut, int constitucio, int força) {

        if (salut < ((constitucio + força) / 90)) {
            salut += ((constitucio + força) / 10);
        } else {
            salut = constitucio + força;
        }
        return salut;
    }
}
