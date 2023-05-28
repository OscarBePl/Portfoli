<?php
ini_set('session.gc_maxlifetime', 300);
session_start();
if (isset($_SESSION['ultima_activitat']) && (time() - $_SESSION['ultima_activitat'] > 300)) {
    session_unset();
    session_destroy();
    header('Location: inici.php?caducat=1');
    exit;
} else {
    if ($_SERVER['REQUEST_METHOD'] == 'POST') {
        $email = $_POST['email'];
        $data = $_POST['data'];
        $sexe = $_POST['sexe'];
        $opcions = $_POST['dades'];
        $aficionsSeleccionades = array();
        if (isset($_POST['aficio1'])) {
            $aficionsSeleccionades[] = $_POST['aficio1'];
        }
        if (isset($_POST['aficio2'])) {
            $aficionsSeleccionades[] = $_POST['aficio2'];
        }
        if (isset($_POST['aficio3'])) {
            $aficionsSeleccionades[] = $_POST['aficio3'];
        }
        if (isset($_POST['aficio4'])) {
            $aficionsSeleccionades[] = $_POST['aficio4'];
        }
        if (isset($_POST['aficio5'])) {
            $aficionsSeleccionades[] = $_POST['aficio5'];
        }
        $mascotesSeleccionades = $_POST['mascotes'];
    }
}
?>

<header>
    <span>
        Hola
        <?= $_SESSION['usuari'] ?>,
        avui és dia
        <?= date("d/m/y"), ' i són les ', date("H:i:s") ?>.
    </span>
    <form method="post" action="acomiadament.php" style='display: inline'>
        <input type="submit" value="Tancar la sessió">
    </form>
</header>
<main>
    <br>Les teves dades son les següents:<br>
    <?php if ($_SERVER['REQUEST_METHOD'] == 'POST'): ?>
        <br>Correu electrònic:
        <?= $email ?>
        <br>Data de naixement:
        <?= $data ?>
        <br>Sexe:
        <?= $sexe ?>
        <br>Aficions:
        <?php
        foreach ($aficionsSeleccionades as $aficio) {
            echo $aficio, ' ';
        }
        ?>
        <br>Mascota/es:
        <?php
        foreach ($mascotesSeleccionades as $mascota) {
            echo $mascota, ' ';
        }
        ?>
        <br>Altres dades:
        <?= $opcions ?>
    <?php endif; ?>
</main>
<footer>
    <br>Oscar Bellerino
</footer>