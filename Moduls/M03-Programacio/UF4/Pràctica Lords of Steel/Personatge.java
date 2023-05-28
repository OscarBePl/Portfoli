package lordsofsteel;

public abstract class Personatge {

    private String nom;
    private int FOR;
    private int CON;
    private int VEL;
    private int INT;
    private int SOR;
    private int PS;
    private int PD;
    private int PA;
    private int PE;
    private Arma arma;
    private int EXP = 0;
    private int NIV = 0;
    private String categoria;
    private Ordre ordre;
    private Caos caos;

    public Personatge(String nom, int força, int constitucio, int velocitat, int inteligencia, int sort, Arma arma) {

        this.nom = nom;
        FOR = força;
        CON = constitucio;
        VEL = velocitat;
        INT = inteligencia;
        SOR = sort;
        this.arma = arma;

        calcularSecundaries(CON, FOR, INT, SOR, VEL, arma);

    }

    public Personatge() {

    }

    public String getNom() {
        return nom;
    }

    public int getForça() {
        return FOR;
    }

    public int getConstitucio() {
        return CON;
    }

    public int getVelocitat() {
        return VEL;
    }

    public int getInteligencia() {
        return INT;
    }

    public int getSort() {
        return SOR;
    }

    public int getSalut() {
        return PS;
    }

    public int getDany() {
        return PD;
    }

    public int getAtacar() {
        return PA;
    }

    public int getEsquivar() {
        return PE;
    }

    public int getExperiencia() {
        return EXP;
    }

    public int getNivell() {
        return NIV;
    }

    public Arma getArma() {
        return arma;
    }

    public String getCategoria() {
        return categoria;
    }

    public Ordre getOrdre() {
        return ordre;
    }

    public Caos getCaos() {
        return caos;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public void setForça(int FOR) {
        this.FOR = FOR;
    }

    public void setConstitucio(int CON) {
        this.CON = CON;
    }

    public void setVelocitat(int VEL) {
        this.VEL = VEL;
    }

    public void setInteligencia(int INT) {
        this.INT = INT;
    }

    public void setSort(int SOR) {
        this.SOR = SOR;
    }

    public void setSalut(int PS) {
        this.PS = PS;
    }

    public void setDany(int PD) {
        this.PD = PD;
    }

    public void setAtacar(int PA) {
        this.PA = PA;
    }

    public void setEsquivar(int PE) {
        this.PE = PE;
    }

    public void setArma(Arma arma) {
        this.arma = arma;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public void setOrdre(Ordre ordre) {
        this.ordre = ordre;
    }

    public void setCaos(Caos caos) {
        this.caos = caos;
    }

    public abstract void calcularSecundaries(int CON, int FOR, int INT, int SOR, int VEL, Arma arma);

    public void rebreDany() {
        PS -= PD;
    }

    public int restaurarSalut() {
        int salut = PS = CON + FOR;
        return salut;
    }

    public void augmentarExperiencia(int PS) {
        EXP += PS;
    }

    public boolean augmentarNivell() {

        if (EXP >= 100 && NIV == 0) {
            NIV = 1;
            EXP = 0;
            augmentarEstadistiques();
            return true;
        } else if (EXP >= 200 && NIV == 1) {
            NIV = 2;
            EXP = 0;
            augmentarEstadistiques();
            return true;
        } else if (EXP >= 500 && NIV == 2) {
            NIV = 3;
            EXP = 0;
            augmentarEstadistiques();
            return true;
        } else if (EXP >= 1000 && NIV == 3) {
            NIV = 4;
            EXP = 0;
            augmentarEstadistiques();
            return true;
        } else if (EXP >= 2000 && NIV == 4) {
            NIV = 5;
            augmentarEstadistiques();
            return true;
        }
        return false;
    }

    public void augmentarEstadistiques() {
        FOR++;
        CON++;
        VEL++;
        INT++;
        SOR++;
    }

    @Override
    public String toString() {
        return "Nom: " + nom + "\t Nivell: " + NIV + "\t Categoria: " + categoria + "\t Arma: " + arma.getNom();
    }
}
