<?php

session_start();
session_destroy();
// unset($_SESSION);
// session_write_close();

$login_page = "index.php";
header("Location: $login_page");

?>
