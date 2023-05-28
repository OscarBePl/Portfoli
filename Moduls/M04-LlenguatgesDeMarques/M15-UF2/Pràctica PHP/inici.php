<?php
session_start();
session_unset();
if (isset($_GET['err']) && $_GET['err'] == 1) {
    echo "<p style = 'color: red'>L’usuari o contrasenya no són vàlids.</p>";
}
if (isset($_GET['caducat']) && $_GET['caducat'] == 1) {
    echo "<p style = 'color: red'>La sessió ha caducat</p>";
}
?>
<header>
    <h2>Login</h2>
</header>
<main>
    <form method="post" action="formulari.php">
        <p>Usuari <input type="text" name='usuari' required></p>
        <p>Contrasenya <input type="password" name='contrasenya' required></p>
        <input type="submit" value="Iniciar sessió">
    </form>
</main>
<footer>
    <br>Oscar Bellerino
</footer>