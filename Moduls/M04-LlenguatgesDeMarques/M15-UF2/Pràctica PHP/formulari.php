<?php
ini_set('session.gc_maxlifetime', 300);
session_start();
if (isset($_SESSION['ultima_activitat']) && (time() - $_SESSION['ultima_activitat'] > 300)) {
    session_unset();
    session_destroy();
    header('Location: inici.php?caducat=1');
    exit;
}
$_SESSION['ultima_activitat'] = time();
$usuari = 'Oscar';
$contrasenya = 'hola';
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    if (($usuari == $_POST['usuari']) && ($contrasenya == $_POST['contrasenya'])) {
        $_SESSION['usuari'] = 'Oscar';
    } else {
        header('Location:inici.php?err=1');
    }
}
if (!isset($_SESSION['usuari'])) {
    header('Location: inici.php?err=1');
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
    <form method="post" action="final.php">
        <p>Correu electrònic <input type="text" name="email" pattern="[a-z0-9._-]+@[a-z0-9._-]+\.[a-z]{2,}$" required>
        </p>
        <p>Data de naixement <input type="date" name="data" required></p>
        Sexe:
        <input type="radio" name="sexe" value="Home">Home
        <input type="radio" name="sexe" value="Dona">Dona
        <input type="radio" name="sexe" value="NoBinari">No Binari
        <input type="radio" name="sexe" value="Indefinit">Indefinit<br>
        <br>Aficions:<br><br>
        <input type="checkbox" name="aficio1" value="Esport">
        <label for="aficio1">Esport</label><br>
        <input type="checkbox" name="aficio2" value="Lectura">
        <label for="aficio2">Lectura</label><br>
        <input type="checkbox" name="aficio3" value="Pel·lícules/Sèries">
        <label for="aficio3">Pel·lícules/Sèries</label><br>
        <input type="checkbox" name="aficio4" value="Videojocs">
        <label for="aficio4">Videojocs</label><br>
        <input type="checkbox" name="aficio5" value="Música">
        <label for="aficio5">Música</label><br><br>
        <label for="mascotes">Escull una mascota:</label><br><br>
        <select multiple name="mascotes[]">
            <option value="Gat">Gat</option>
            <option value="Gos">Gos</option>
            <option value="Conill">Conill</option>
            <option value="Hamster">Hamster</option>
            <option value="Cap">Cap</option>
        </select><br>
        <br>Altres dades<br>
        <textarea type="text" name='dades'></textarea></p>
        <input type="submit" value="Enviar">
    </form>
</main>
<footer>
    <br>Oscar Bellerino
</footer>