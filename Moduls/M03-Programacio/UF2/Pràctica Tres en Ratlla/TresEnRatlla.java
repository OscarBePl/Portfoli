package tresenratlla;

import java.util.Scanner;

public class TresEnRatlla {

    public static void main(String[] args) {

        Scanner entrada = new Scanner(System.in);
        String[][] tauler = new String[3][3];
        int torns = 0;
        int jugador = 1;
        String resposta = "";

        do {
            introduccio(tauler);
            mostraTauler(tauler);
            do {
                //Repetim el bucle mentre no hi hagi un guanyador o el tauler no s'hagi omplert.
                int moviment = demanaMoviment(jugador);
                if (assignaPosicio(moviment, jugador, tauler)) {
                    netejarPantalla();
                    mostraTauler(tauler);
                    jugador = cambiaJugador(jugador);
                    torns++;
                }
                if (guanyadorColumna(tauler, jugador) || guanyadorFila(tauler, jugador) || guanyadorDiagonal(tauler, jugador)) {
                    jugador = cambiaJugador(jugador);
                    System.out.println("El jugador " + jugador + " és el guanyador.");
                    break;
                } else if ((!guanyadorColumna(tauler, jugador) || guanyadorFila(tauler, jugador) || guanyadorDiagonal(tauler, jugador)) && torns == 9) {
                    System.out.println("Empat.");
                }
            } while (torns <= 8);
            resposta = tornarAJugar(resposta, jugador, torns);
            jugador = 1;
            torns = 0;
        } while ("S".equalsIgnoreCase(resposta));
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

    public static int demanaMoviment(int jugador) {

        Scanner entrada = new Scanner(System.in);
        //Només seran vàlids els valors de l'1 al 9.
        int posicio = 0;
        if (jugador == 1) {
            System.out.print("\033[34mJugador 1: \033[30m");
        } else {
            System.out.print("\033[35mJugador 2: \033[30m");
        }

        do {
            if (entrada.hasNextInt()) {
                posicio = entrada.nextInt();
                if (posicio > 0 && posicio < 10) {
                    break;
                } else {
                    System.out.println("Posició no vàlida.");
                    entrada.nextLine();
                }
            } else {
                System.out.println("Posició no vàlida.");
                entrada.nextLine();
            }
        } while (true);
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

    public static int cambiaJugador(int jugador) {

        if (jugador == 1) {
            jugador = 2;
        } else {
            jugador = 1;
        }
        return jugador;
    }

    public static boolean guanyadorColumna(String[][] tauler, int jugador) {
        //Comprovem si hi ha un guanyador per columnes començant per la columna de l'esquerra.
        for (int i = 0; i < 3; i++) {
            if (!"·".equals(tauler[0][i]) && tauler[0][i].equals(tauler[1][i]) && tauler[1][i].equals(tauler[2][i])) {
                return true;
            }
        }
        return false;
    }

    public static boolean guanyadorFila(String[][] tauler, int jugador) {
        //Comprovem si hi ha un guanyador per files començant per la primera fila.
        for (int i = 0; i < 3; i++) {
            if (!"·".equals(tauler[i][0]) && tauler[i][0].equals(tauler[i][1]) && tauler[i][1].equals(tauler[i][2])) {
                return true;
            }
        }
        return false;
    }

    public static boolean guanyadorDiagonal(String[][] tauler, int jugador) {
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

    public static String tornarAJugar(String resposta, int jugador, int torns) {

        Scanner entrada = new Scanner(System.in);

        System.out.println("Voleu tornar a jugar? (S/N)");
        do {
            resposta = entrada.nextLine();
            if (!"S".equalsIgnoreCase(resposta) && !"N".equalsIgnoreCase(resposta)) {
                System.out.println("Opció incorrecta.");
            } else if ("N".equalsIgnoreCase(resposta)) {
                break;
            }
        } while (!"S".equalsIgnoreCase(resposta) && !"N".equalsIgnoreCase(resposta));

        return resposta;
    }

    public static void netejarPantalla() {

        System.out.print("\033[H\033[2J");
        System.out.flush();
    }
}