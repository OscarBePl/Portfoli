package lordsofsteel;

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class LordsOfSteel {

    private static Jugador jugador1;
    private static Jugador jugador2;
    public static List<Personatge> personatges = new ArrayList<>();
    public static Scanner entrada = new Scanner(System.in);

    public static void main(String[] args) {

        Arma daga = new Arma(5, 15);
        daga.setNom("Daga");
        Arma espasa = new Arma(10, 10);
        espasa.setNom("Espasa");
        Arma martell = new Arma(15, 5);
        martell.setNom("Martell de combat");
        Personatge p1 = new Huma("Ozymandias", 12, 12, 12, 12, 12, daga);
        p1.setCategoria("Humà");
        personatges.add(p1);
        Personatge p2 = new Nan("Bugenhagen", 20, 10, 8, 10, 12, martell);
        p2.setCategoria("Nan   ");
        personatges.add(p2);
        Personatge p3 = new Mitja("Prostagma", 10, 11, 14, 11, 14, espasa);
        personatges.add(p3);
        p3.setCategoria("Mitja");
        Personatge p4 = new Maia("Ininuin", 15, 13, 13, 15, 4, daga);
        personatges.add(p4);
        p4.setCategoria("Maia");

        mostrarMenu(daga, espasa, martell);
    }

    public static void mostrarMenu(Arma d, Arma e, Arma m) {

        int opcio;

        do {
            System.out.println("      LORDS OF STEEL\n");
            System.out.println("1 - Afegir un nou personatge");
            System.out.println("2 - Esborrar un personatge");
            System.out.println("3 - Editar un personatge");
            System.out.println("4 - Iniciar un combat");
            System.out.println("5 - Sortir");
            System.out.print("Opció: ");
            comprovarEntrada();
            opcio = entrada.nextInt();

            switch (opcio) {

                case 1 ->
                    afegirPersonatge(d, e, m);
                case 2 ->
                    esborrarPersonatge();
                case 3 ->
                    editarPersonatge();
                case 4 -> {
                    if (personatges.size() < 2) {
                        System.out.println("\nNo hi ha suficients personatges per combatir.\n");
                    } else {
                        iniciarCombat();
                    }
                }
                case 5 -> {
                    break;
                }
                default -> {
                    System.out.println("\nOpció incorrecta.\n");
                }
            }
        } while (opcio != 5);
    }

    public static void comprovarEntrada() {

        while (!entrada.hasNextInt()) {
            System.out.println("\nOpció incorrecta.\n");
            entrada.next();
        }
    }

    public static void afegirPersonatge(Arma d, Arma e, Arma m) {

        int opcio;
        String devocio;

        System.out.println("\nAFEGIR PERSONATGE\n");
        System.out.println("Escull la categoria del personatge:");
        System.out.println("1 - Nan");
        System.out.println("2 - Humà");
        System.out.println("3 - Mitjà");
        System.out.println("4 - Maia");
        System.out.println("5 - Tornar");
        System.out.print("Opció: ");
        comprovarEntrada();
        opcio = entrada.nextInt();
        System.out.println();

        switch (opcio) {

            case 1 -> {
                Personatge nouPersonatge = new Nan();
                nouPersonatge.setNom(assignaNom());
                nouPersonatge.setCategoria("Nan   ");
                devocio = assignaDevocio();
                if (devocio.equals("Ordre")) {
                    nouPersonatge.setOrdre(new NanOrdre());
                } else if (devocio.equals("Caos")) {
                    nouPersonatge.setCaos(new NanCaos());
                }
                Arma novaArma = (assignaArma(d, e, m));
                nouPersonatge.setArma(novaArma);
                assignaEstadistiques(nouPersonatge, "a");
                nouPersonatge.calcularSecundaries(nouPersonatge.getConstitucio(), nouPersonatge.getForça(),
                        nouPersonatge.getInteligencia(), nouPersonatge.getSort(), nouPersonatge.getVelocitat(), novaArma);
            }
            case 2 -> {
                Personatge nouPersonatge = new Huma();
                nouPersonatge.setNom(assignaNom());
                nouPersonatge.setCategoria("Humà");
                devocio = assignaDevocio();
                if (devocio.equals("Ordre")) {
                    nouPersonatge.setOrdre(new HumaOrdre());
                } else if (devocio.equals("Caos")) {
                    nouPersonatge.setCaos(new HumaCaos());
                }
                Arma novaArma = (assignaArma(d, e, m));
                nouPersonatge.setArma(novaArma);
                assignaEstadistiques(nouPersonatge, "a");
                nouPersonatge.calcularSecundaries(nouPersonatge.getConstitucio(), nouPersonatge.getForça(),
                        nouPersonatge.getInteligencia(), nouPersonatge.getSort(), nouPersonatge.getVelocitat(), novaArma);
            }
            case 3 -> {
                Personatge nouPersonatge = new Mitja();
                nouPersonatge.setNom(assignaNom());
                nouPersonatge.setCategoria("Mitjà");
                devocio = assignaDevocio();
                if (devocio.equals("Ordre")) {
                    nouPersonatge.setOrdre(new MitjaOrdre());
                } else if (devocio.equals("Caos")) {
                    nouPersonatge.setCaos(new MitjaCaos());
                }
                Arma novaArma = (assignaArma(d, e, m));
                nouPersonatge.setArma(novaArma);
                assignaEstadistiques(nouPersonatge, "a");
                nouPersonatge.calcularSecundaries(nouPersonatge.getConstitucio(), nouPersonatge.getForça(),
                        nouPersonatge.getInteligencia(), nouPersonatge.getSort(), nouPersonatge.getVelocitat(), novaArma);
            }
            case 4 -> {
                Personatge nouPersonatge = new Maia();
                nouPersonatge.setNom(assignaNom());
                nouPersonatge.setCategoria("Maia");
                devocio = assignaDevocio();
                if (devocio.equals("Ordre")) {
                    nouPersonatge.setOrdre(new MaiaOrdre());
                } else if (devocio.equals("Caos")) {
                    nouPersonatge.setCaos(new MaiaCaos());
                }
                Arma novaArma = (assignaArma(d, e, m));
                nouPersonatge.setArma(novaArma);
                assignaEstadistiques(nouPersonatge, "a");
                nouPersonatge.calcularSecundaries(nouPersonatge.getConstitucio(), nouPersonatge.getForça(),
                        nouPersonatge.getInteligencia(), nouPersonatge.getSort(), nouPersonatge.getVelocitat(), novaArma);
            }
            case 5 -> {
                break;
            }
            default -> {
                System.out.println("Opció incorrecta.");
            }
        }
    }

    public static String assignaNom() {

        entrada.nextLine();
        System.out.print("Introdueix el nom del teu personatge: ");
        String nom = entrada.nextLine();
        return nom;
    }

    public static void assignaEstadistiques(Personatge nou, String editat) {

        int força;
        int constitucio;
        int velocitat;
        int inteligencia;
        int sort;
        int total;
        int punts = 60 + (nou.getNivell() * 5);

        do {
            System.out.println("\nAssigna un total de " + punts + " punts entre les 5 estadístiques (mínim 3 i màxim 18 en cadascuna)");
            System.out.print("Força: ");
            força = entrada.nextInt();
            System.out.print("Constitució: ");
            constitucio = entrada.nextInt();
            System.out.print("Velocitat: ");
            velocitat = entrada.nextInt();
            System.out.print("Inteligencia: ");
            inteligencia = entrada.nextInt();
            System.out.print("Sort: ");
            sort = entrada.nextInt();
            total = força + constitucio + velocitat + inteligencia + sort;

            if ((força < 3 || força > 18) || (constitucio < 3 || constitucio > 18) || (velocitat < 3 || velocitat > 18)
                    || (inteligencia < 3 || inteligencia > 18) || (sort < 3 || sort > 18) && total >= punts) {
                System.out.println("\nAlguna estadística té menys de 3 punts o més de 18.");
            } else if (total > punts) {
                System.out.println("\nEl total dels punts no pot ser major que " + punts + ".");
            } else if (total < punts) {
                System.out.println("\nS'ha d'assignar un total de " + punts + " punts.");
            } else {
                nou.setForça(força);
                nou.setConstitucio(constitucio);
                nou.setVelocitat(velocitat);
                nou.setInteligencia(inteligencia);
                nou.setSort(sort);
                if (editat.equals("e")) {
                    System.out.println("\nPersonatge editat correctament.\n");
                    break;
                } else {
                    personatges.add(nou);
                    System.out.println("\nPersonatge creat correctament.\n");
                }
            }
        } while (total != punts);
    }

    public static String assignaDevocio() {

        System.out.println("\nEscull una devoció: ");
        System.out.println("1 - Ordre");
        System.out.println("2 - Caos");
        System.out.print("Opció: ");
        int opcio = entrada.nextInt();

        switch (opcio) {

            case 1 -> {
                return "Ordre";
            }
            case 2 -> {
                return "Caos";
            }
        }
        return null;
    }

    public static Arma assignaArma(Arma d, Arma e, Arma m) {

        System.out.println("\nEscull una arma pel teu personatge: ");
        System.out.println("1 - Daga");
        System.out.println("2 - Espasa");
        System.out.println("3 - Martell de combat");
        System.out.print("Opció: ");
        int opcio = entrada.nextInt();

        switch (opcio) {

            case 1 -> {
                d.setNom("Daga");
                return d;
            }
            case 2 -> {
                e.setNom("Espasa");
                return e;
            }
            case 3 -> {
                m.setNom("Martell de combat");
                return m;
            }
            default -> {
                System.out.println("\nOpció incorrecta.");
            }
        }
        return null;
    }

    public static void esborrarPersonatge() {

        System.out.println("\nESBORRAR PERSONATGE");
        System.out.println("(Per sortir, teclejar \"sortir\")\n");
        if (personatges.isEmpty()) {
            System.out.println("No hi ha cap personatge per esborrar.\n");
        } else {
            mostrarPersonatges();
            entrada.nextLine();
            System.out.print("\nIntrodueix el nom del personatge a esborrar: ");
            String nom = entrada.nextLine();
            switch (nom) {
                case "sortir" -> {
                    break;
                }
                default -> {
                    Personatge personatgeAEsborrar = findPersonatgeByNom(nom);
                    if (personatgeAEsborrar != null) {
                        personatges.remove(personatgeAEsborrar);
                        System.out.println("\nPersonatge esborrat correctament.\n");
                    } else {
                        System.out.println("\nNo existeix cap personatge amb aquest nom.\n");
                    }
                }
            }
        }
    }

    public static Personatge findPersonatgeByNom(String nom) {

        for (Personatge personatge : personatges) {
            if (personatge.getNom().equalsIgnoreCase(nom)) {
                return personatge;
            }
        }
        return null;
    }

    public static void editarPersonatge() {

        System.out.println("\nEDITAR PERSONATGE");
        System.out.println("(Per sortir, teclejar \"sortir\")\n");
        if (personatges.isEmpty()) {
            System.out.println("No hi ha cap personatge per editar.\n");
        } else {
            mostrarPersonatges();
            entrada.nextLine();
            System.out.print("\nIntrodueix el nom del personatge a editar: ");
            String nom = entrada.nextLine();
            System.out.println();
            switch (nom) {
                case "sortir" -> {
                    break;
                }
                default -> {
                    Personatge personatgeAEditar = findPersonatgeByNom(nom);
                    if (personatgeAEditar != null) {
                        assignaEstadistiques(personatgeAEditar, "e");
                    } else {
                        System.out.println("\nNo existeix cap personatge amb aquest nom.\n");
                    }
                }
            }
        }
    }

    public static void iniciarCombat() {

        int jugador = 1;

        entrada.nextLine();
        System.out.println("\nINICIAR COMBAT\n");
        seleccionarPersonatges(jugador);
        combat(jugador1, jugador2);

    }

    public static int canviarJugador(int jugador) {

        if (jugador == 1) {
            jugador = 2;
        } else {
            jugador = 1;
        }
        return jugador;
    }

    public static void mostrarPersonatges() {

        for (Personatge personatge : personatges) {
            if (personatges != null) {
                System.out.println(personatge.toString());
            }
        }
    }

    public static void seleccionarPersonatges(int jugador) {

        String nom1;
        Personatge p1;
        String nom2;
        Personatge p2;
        boolean assignat = false;

        do {
            mostrarPersonatges();
            System.out.print("\nJugador " + jugador + ", escull un personatge pel seu nom: ");
            nom1 = entrada.nextLine();
            System.out.println();
            p1 = findPersonatgeByNom(nom1);
        } while (!assignarPersonatges(p1, jugador));
        jugador = canviarJugador(jugador);
        do {
            mostrarPersonatges();
            System.out.print("\nJugador " + jugador + ", escull un personatge pel seu nom: ");
            nom2 = entrada.nextLine();
            System.out.println();
            if (nom2.equals(nom1)) {
                System.out.println("\nNo es pot escollir el mateix personatge.\n");
            } else {
                p2 = findPersonatgeByNom(nom2);
                assignat = assignarPersonatges(p2, jugador);
            }
        } while (!assignat);
    }

    public static boolean assignarPersonatges(Personatge pers, int jugador) {

        if (pers != null) {
            if (jugador == 1) {
                jugador1 = new Jugador(pers);
                return true;
            } else if (jugador == 2) {
                jugador2 = new Jugador(pers);
                return true;
            }
        }

        System.out.println("No existeix cap personatge amb aquest nom.\n");
        return false;
    }

    public static void combat(Jugador j1, Jugador j2) {

        int jugador = 1;
        int tirada;
        int salut1 = j1.getPersonatge().getSalut();
        int salut2 = j2.getPersonatge().getSalut();
        boolean exit;

        do {
            tirada = tiradaDaus();
            if (tirada <= (j1.getPersonatge().getAtacar())) {
                System.out.println("Resultat tirada J1: " + tirada + "\n");
                System.out.println("El J1 ataca!\n");
                exit = true;
                canviarJugador(jugador);
            } else {
                System.out.println("Resultat tirada J1: " + tirada + "\n");
                System.out.println("El J1 ha fallat l'atac!\n");
                exit = false;
                canviarJugador(jugador);
            }
            tirada = tiradaDaus();
            if ((tirada <= (j2.getPersonatge().getEsquivar())) && exit == true) {
                System.out.println("Resultat tirada J2: " + tirada + "\n");
                System.out.println("El J2 ha pogut esquivar l'atac!\n");
            } else if ((tirada > (j2.getPersonatge().getEsquivar())) && exit == true) {
                System.out.println("Resultat tirada J2: " + tirada + "\n");
                System.out.println("El J2 ha rebut l'atac!\n");
                salut2 -= j1.getPersonatge().getDany();
                System.out.println("Salut del J2: " + salut2 + "\n");
                if (salut2 <= 0) {
                    break;
                }
            }
            tirada = tiradaDaus();
            if (tirada <= (j2.getPersonatge().getAtacar())) {
                System.out.println("Resultat tirada J2: " + tirada + "\n");
                System.out.println("El J2 ataca!\n");
                exit = true;
                canviarJugador(jugador);
            } else {
                System.out.println("Resultat tirada J2: " + tirada + "\n");
                System.out.println("El J2 ha fallat l'atac!\n");
                exit = false;
                canviarJugador(jugador);
            }
            tirada = tiradaDaus();
            if ((tirada <= (j1.getPersonatge().getEsquivar())) && exit == true) {
                System.out.println("Resultat tirada J1: " + tirada + "\n");
                System.out.println("El J1 ha pogut esquivar l'atac!\n");
            } else if ((tirada > (j1.getPersonatge().getEsquivar())) && exit == true) {
                System.out.println("Resultat tirada J1: " + tirada + "\n");
                System.out.println("El J1 ha rebut l'atac!\n");
                salut1 -= j2.getPersonatge().getDany();
                System.out.println("Salut del J1: " + salut1 + "\n");
                if (salut1 <= 0) {
                    break;
                }
            }
        } while (true);

        if (salut2 <= 0) {
            augmentarExpINiv(j1, j2, jugador, j2.getPersonatge().getSalut(), j1.getPersonatge().getArma());
        } else if (salut1 <= 0) {
            augmentarExpINiv(j2, j1, jugador, j1.getPersonatge().getSalut(), j2.getPersonatge().getArma());
        }
        j1.getPersonatge().restaurarSalut();
        j2.getPersonatge().restaurarSalut();
    }

    public static void augmentarExpINiv(Jugador guanyador, Jugador perdedor, int jugador, int salutPerdedor, Arma arma) {

        guanyador.getPersonatge().augmentarExperiencia(salutPerdedor);
        System.out.println("El jugador " + jugador + " (" + guanyador.getPersonatge().getNom() + ") ha guanyat el combat i rep "
                + perdedor.getPersonatge().getSalut() + " punts d'experiència! Total EXP: " + guanyador.getPersonatge().getExperiencia() + "\n");
        if (guanyador.getPersonatge().augmentarNivell()) {
            guanyador.getPersonatge().calcularSecundaries(guanyador.getPersonatge().getConstitucio(), guanyador.getPersonatge().getForça(),
                    guanyador.getPersonatge().getInteligencia(), guanyador.getPersonatge().getSort(), guanyador.getPersonatge().getVelocitat(),
                    guanyador.getPersonatge().getArma());
            System.out.println("Enhorabona, " + guanyador.getPersonatge().getNom() + " ha pujat un nivell!\n");
        }
    }

    public static int tiradaDaus() {

        int dau1 = (int) (Math.random() * 25 + 1);
        int dau2 = (int) (Math.random() * 25 + 1);
        int dau3 = (int) (Math.random() * 25 + 1);
        int total = dau1 + dau2 + dau3;

        return total;
    }
}
