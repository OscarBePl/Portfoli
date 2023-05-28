<?php
ini_set('session.gc_maxlifetime', 300);
session_start();
if (!isset($_SESSION['usuari'])) {
    header('Location:inici.php');
}
?>


<header>
Fins a un altre <?php echo $_SESSION['usuari'] ?>!
</header>
<main>
<br><a href='inici.php'>Tornar a l'inici</a>
</main>
<footer>
<br>Oscar Bellerino
</footer>
<?php
session_unset();
session_destroy();
?>