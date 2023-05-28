package tresenratllapersistent;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;

public class TresEnRatllaPersistent {

    public static Scanner entrada = new Scanner(System.in);
    public static List<Jugador> jugadors = new ArrayList<>();

    public static void main(String[] args) {

        recuperarRanking();
        int opcio = -1;
        do {
            System.out.println("BENVINGUTS AL TRES EN RATLLA\n");
            System.out.println("Tria la opció que vols:");
            System.out.println("1.- Jugar");
            System.out.println("2.- Veure Ranking");
            System.out.println("3.- Veure històric partides");
            System.out.println("0.- Sortir");
            System.out.print("Opció: ");
            if (entrada.hasNextInt()) {
                opcio = entrada.nextInt();

                switch (opcio) {
                    case 1: {
                        entrada.nextLine();
                        jugarPartida();
                        break;
                    }
                    case 2:
                        mostrarRanking();
                        break;
                    case 3:
                        mostrarHistoric();
                        break;
                    case 0:
                        break;
                    default:
                        System.out.println("Opció incorrecta.");
                }
            } else {
                System.out.println("Opció incorrecta.");
                entrada.nextLine();
            }
        } while (opcio != 0);
    }

    public static void introduccio(String[][] tauler) {

        for (int i = 0; i < tauler.length; i++) {
            for (int j = 0; j < tauler.length; j++) {
                tauler[i][j] = "·";
            }
        }

        System.out.print("""
                                                        ==TRES EN RATLLA== 
                               Per jugar s'han de seleccionar les posicions del tauler de l'1 al 9.
                               El jugador que completi una fila, columna o diagonal, haurà guanyat.\n""");
    }

    public static void mostraTauler(String[][] tauler) {

        System.out.println("--------------");

        for (int i = 0; i < tauler.length; i++) {
            for (int j = 0; j < tauler.length; j++) {
                System.out.print(tauler[i][j] + "     ");
            }
            System.out.println();
        }
        System.out.println("--------------");
    }

    public static void jugarPartida() {

        String[][] tauler = new String[3][3];
        int torns = 0;
        int jugador = 1;
        String resposta = "";
        boolean empat = false;
        Jugador j1 = demanarJugadors();
        Jugador j2 = demanarJugadors(j1);

        do {
            introduccio(tauler);
            mostraTauler(tauler);
            do {
                //Repetim el bucle mentre no hi hagi un guanyador o el tauler no s'hagi omplert.
                int moviment = demanaMoviment(jugador, j1, j2);
                if (assignaPosicio(moviment, jugador, tauler)) {
                    netejarPantalla();
                    mostraTauler(tauler);
                    jugador = canviaJugador(jugador);
                    torns++;
                }
                if (guanyadorColumna(tauler) || guanyadorFila(tauler) || guanyadorDiagonal(tauler)) {
                    jugador = canviaJugador(jugador);
                    if (jugador == 1) {
                        System.out.println(j1.getNom() + " és el guanyador.");
                        j1.setPunts(3);
                    } else {
                        System.out.println(j2.getNom() + " és el guanyador.");
                        j2.setPunts(3);
                    }
                    break;
                } else if ((!guanyadorColumna(tauler) || guanyadorFila(tauler) || guanyadorDiagonal(tauler)) && torns == 9) {
                    System.out.println("Empat.");
                    j1.setPunts(1);
                    j2.setPunts(1);
                    empat = true;
                }
            } while (torns <= 8);
            jugadors = ordenar();
            escriureRanking();
            actualitzarRanking();
            escriureHistoric(j1, j2, jugador, empat);
            resposta = tornarAJugar(resposta);
            jugador = 1;
            torns = 0;
        } while ("S".equalsIgnoreCase(resposta));
    }

    public static int demanaMoviment(int jugador, Jugador j1, Jugador j2) {

        //Només seran vàlids els valors de l'1 al 9.
        int posicio = 0;
        boolean valid = false;
        if (jugador == 1) {
            System.out.print("\033[34m" + j1.getNom() + ": \033[30m");
        } else {
            System.out.print("\033[35m" + j2.getNom() + ": \033[30m");
        }

        do {
            if (entrada.hasNextInt()) {
                posicio = entrada.nextInt();
                if (posicio > 0 && posicio < 10) {
                    valid = true;
                } else {
                    System.out.println("Posició no vàlida.");
                    entrada.nextLine();
                }
            } else {
                System.out.println("Posició no vàlida.");
                entrada.nextLine();
            }
        } while (valid == false);
        return posicio;
    }

    public static boolean assignaPosicio(int moviment, int jugador, String[][] tauler) {

        boolean valid = false;
        // Comprovem per cada posició si l'espai es lliure. Si ho és, introduïm el caracter corresponent.
        switch (moviment) {
            case 1 -> {
                if (!"·".equals(tauler[0][0])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[0][0] = "\033[34mX\033[30m";
                    } else {
                        tauler[0][0] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 2 -> {
                if (!"·".equals(tauler[0][1])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[0][1] = "\033[34mX\033[30m";
                    } else {
                        tauler[0][1] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 3 -> {
                if (!"·".equals(tauler[0][2])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[0][2] = "\033[34mX\033[30m";
                    } else {
                        tauler[0][2] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 4 -> {
                if (!"·".equals(tauler[1][0])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[1][0] = "\033[34mX\033[30m";
                    } else {
                        tauler[1][0] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 5 -> {
                if (!"·".equals(tauler[1][1])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[1][1] = "\033[34mX\033[30m";
                    } else {
                        tauler[1][1] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 6 -> {
                if (!"·".equals(tauler[1][2])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[1][2] = "\033[34mX\033[30m";
                    } else {
                        tauler[1][2] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 7 -> {
                if (!"·".equals(tauler[2][0])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[2][0] = "\033[34mX\033[30m";
                    } else {
                        tauler[2][0] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 8 -> {
                if (!"·".equals(tauler[2][1])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[2][1] = "\033[34mX\033[30m";
                    } else {
                        tauler[2][1] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
            case 9 -> {
                if (!"·".equals(tauler[2][2])) {
                    System.out.println("Posició ocupada.");
                } else {
                    if (jugador == 1) {
                        tauler[2][2] = "\033[34mX\033[30m";
                    } else {
                        tauler[2][2] = "\033[35mO\033[30m";
                    }
                    valid = true;
                }
            }
        }
        return valid;
    }

    public static int canviaJugador(int jugador) {

        if (jugador == 1) {
            jugador = 2;
        } else {
            jugador = 1;
        }
        return jugador;
    }

    public static boolean guanyadorColumna(String[][] tauler) {
        //Comprovem si hi ha un guanyador per columnes començant per la columna de l'esquerra.
        for (int i = 0; i < 3; i++) {
            if (!"·".equals(tauler[0][i]) && tauler[0][i].equals(tauler[1][i]) && tauler[1][i].equals(tauler[2][i])) {
                return true;
            }
        }
        return false;
    }

    public static boolean guanyadorFila(String[][] tauler) {
        //Comprovem si hi ha un guanyador per files començant per la primera fila.
        for (int i = 0; i < 3; i++) {
            if (!"·".equals(tauler[i][0]) && tauler[i][0].equals(tauler[i][1]) && tauler[i][1].equals(tauler[i][2])) {
                return true;
            }
        }
        return false;
    }

    public static boolean guanyadorDiagonal(String[][] tauler) {
        //Comprovem si hi ha un guanyador per diagonal:
        //primer de dalt a l'esquerra a abaix a la dreta i després de dalt a la dreta a abaix a l'esquerra.
        if (!"·".equals(tauler[1][1])) {
            if (tauler[0][0].equals(tauler[1][1]) && tauler[1][1].equals(tauler[2][2])) {
                return true;
            }
            if (tauler[0][2].equals(tauler[1][1]) && tauler[1][1].equals(tauler[2][0])) {
                return true;
            }
        }
        return false;
    }

    public static String tornarAJugar(String resposta) {

        entrada.nextLine();
        System.out.println("Voleu tornar a jugar? (S/N)");
        do {
            resposta = entrada.nextLine();
            if (!"S".equalsIgnoreCase(resposta) && !"N".equalsIgnoreCase(resposta)) {
                System.out.println("Opció incorrecta.");
            }
        } while (!"S".equalsIgnoreCase(resposta) && !"N".equalsIgnoreCase(resposta));
        System.out.println();

        return resposta;
    }

    public static void netejarPantalla() {

        System.out.print("\033[H\033[2J");
        System.out.flush();
    }

    public static Jugador demanarJugadors() {

        Jugador j;
        System.out.print("\nIntrodueix el nom del jugador 1: ");
        String nom = entrada.nextLine();
        j = findJugadorByNom(nom);
        if (j == null) {
            j = new Jugador(nom);
            jugadors.add(j);
            System.out.println("\nBenvingut, " + j.getNom() + ".");
        } else {
            System.out.println("\nHola, " + j.getNom() + ". Ets el jugador número " + j.getRanking() + " del ranking.");
        }
        return j;
    }

    public static Jugador demanarJugadors(Jugador j1) {

        Jugador j;
        String nom;
        do {
            System.out.print("\nIntrodueix el nom del jugador 2: ");
            nom = entrada.nextLine();
            if (nom.equalsIgnoreCase(j1.getNom())) {
                System.out.println("\nHas d'escollir un nom diferent al del Jugador 1.");
            }
        } while (nom.equalsIgnoreCase(j1.getNom()));
        j = findJugadorByNom(nom);
        if (j == null) {
            j = new Jugador(nom);
            jugadors.add(j);
            System.out.println("\nBenvingut, " + j.getNom() + ".");
        } else {
            System.out.println("\nHola, " + j.getNom() + ". Ets el jugador número " + j.getRanking() + " del ranking.\n");
        }
        return j;
    }

    public static Jugador findJugadorByNom(String nom) {

        for (Jugador jugador : jugadors) {
            if (jugador.getNom().equalsIgnoreCase(nom)) {
                return jugador;
            }
        }
        return null;
    }

    public static void recuperarRanking() {

        String[] parts;

        try {
            FileReader ranking = new FileReader("ranking.txt");
            BufferedReader entrada = new BufferedReader(ranking);
            String llegeixLinia = entrada.readLine();

            while (llegeixLinia != null) {
                Jugador g = new Jugador();
                parts = llegeixLinia.split("-");
                g.setRanking(Integer.parseInt(parts[0]));
                g.setNom(parts[1]);
                g.setPunts(Integer.parseInt(parts[2]));
                jugadors.add(g);
                llegeixLinia = entrada.readLine();
            }

        } catch (FileNotFoundException fnf) {
            fnf.getMessage();
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }

    public static List<Jugador> ordenar() {

        Collections.sort(jugadors, new Comparator<Jugador>() {
            @Override
            public int compare(Jugador j1, Jugador j2) {
                return Integer.compare(j2.getPunts(), j1.getPunts());
            }
        });
        return jugadors;
    }

    public static void escriureRanking() {

        int rank = 1;
        try {
            FileWriter ranking = new FileWriter("ranking.txt");
            BufferedWriter sortida = new BufferedWriter(ranking);
            for (Jugador j : jugadors) {
                sortida.write(rank + "-" + j.getNom() + "-" + j.getPunts() + "\n");
                rank++;
            }
            sortida.close();
        } catch (FileNotFoundException fnf) {
            fnf.getMessage();
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }

    public static void actualitzarRanking() {

        String[] parts;

        try {
            FileReader ranking = new FileReader("ranking.txt");
            BufferedReader entrada = new BufferedReader(ranking);
            String llegeixLinia = entrada.readLine();

            while (llegeixLinia != null) {
                parts = llegeixLinia.split("-");
                if (parts.length >= 3) {
                    for (Jugador g : jugadors) {
                        if (g.getNom().equals(parts[1])) {
                            g.setRanking(Integer.parseInt(parts[0]));
                            break;
                        }
                    }
                }
                llegeixLinia = entrada.readLine();
            }

        } catch (FileNotFoundException fnf) {
            fnf.getMessage();
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }

    public static void mostrarRanking() {

        System.out.println();
        String[] parts;

        try {
            FileReader ranking = new FileReader("ranking.txt");
            BufferedReader entrada = new BufferedReader(ranking);
            String llegeixLinia = entrada.readLine();
            System.out.print(String.format("%26s\n\n", "***RANKING***"));
            System.out.print("Posició\t\tJugador\t\tPuntuació\n\n");

            while (llegeixLinia != null) {
                parts = llegeixLinia.split("-");
                System.out.print(String.format("   %-14s%-19s%s\n", parts[0], parts[1], parts[2]));
                llegeixLinia = entrada.readLine();
            }
            System.out.println();

        } catch (FileNotFoundException fnf) {
            System.out.print(String.format("%26s\n\n", "***RANKING***"));
            System.out.print("Posició\t\tJugador\t\tPuntuació\n\n");
            System.out.print(String.format("%35s", "No hi ha jugadors guardats\n\n"));
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }

    public static void escriureHistoric(Jugador j1, Jugador j2, int jugador, boolean empat) {

        Calendar c = Calendar.getInstance();
        String dia = Integer.toString(c.get(Calendar.DATE));
        String mes = Integer.toString(c.get(Calendar.MONTH) + 1);
        String any = Integer.toString(c.get(Calendar.YEAR));
        String hora = Integer.toString(c.get(Calendar.HOUR_OF_DAY));
        String minut = Integer.toString(c.get(Calendar.MINUTE));
        String segon = Integer.toString(c.get(Calendar.SECOND));

        if (Integer.parseInt(hora) < 10 || Integer.parseInt(minut) < 10 || Integer.parseInt(segon) < 10) {
            hora = String.format("%02d", Integer.parseInt(hora));
            minut = String.format("%02d", Integer.parseInt(minut));
            segon = String.format("%02d", Integer.parseInt(segon));
        }

        try {
            FileWriter historic = new FileWriter("historic.txt", true);
            BufferedWriter sortida = new BufferedWriter(historic);
            if (jugador == 1 && !empat) {
                sortida.write(dia + "/" + mes + "/" + any + " (" + hora + ":" + minut + ":" + segon + ") _" + j1.getNom() + " - " + j2.getNom() + "_" + j1.getNom() + "\n");
            } else if (jugador == 2 && !empat) {
                sortida.write(dia + "/" + mes + "/" + any + " (" + hora + ":" + minut + ":" + segon + ") _" + j1.getNom() + " - " + j2.getNom() + "_" + j2.getNom() + "\n");
            } else if (empat) {
                sortida.write(dia + "/" + mes + "/" + any + " (" + hora + ":" + minut + ":" + segon + ") _" + j1.getNom() + " - " + j2.getNom() + "_" + "Empat\n");
            }
            sortida.close();
        } catch (FileNotFoundException fnf) {
            fnf.getMessage();
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }

    public static void mostrarHistoric() {

        System.out.println();
        String[] parts;

        try {
            FileReader historic = new FileReader("historic.txt");
            BufferedReader entrada = new BufferedReader(historic);
            String llegeixLinia = entrada.readLine();
            System.out.print(String.format("%31s\n\n", "***HISTÒRIC***"));
            System.out.print("    Data i hora\t\tJugadors\tGuanyador\n\n");

            while (llegeixLinia != null) {
                parts = llegeixLinia.split("_");
                System.out.print(String.format("%-22s%-20s%s\n", parts[0], parts[1], parts[2]));
                llegeixLinia = entrada.readLine();
            }
            System.out.println();

        } catch (FileNotFoundException fnf) {
            System.out.print(String.format("%31s\n\n", "***HISTÒRIC***"));
            System.out.print("    Data i hora\t\tJugadors\tGuanyador\n\n");
            System.out.print(String.format("%40s", "No hi ha partides guardades\n\n"));
        } catch (IOException ioe) {
            ioe.getMessage();
        }
    }
}
