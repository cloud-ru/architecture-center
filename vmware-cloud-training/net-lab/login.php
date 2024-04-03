<?php
session_start();

if (isset($_POST['login'])) {
    $uname = "admin@example.com";
    $passwd = "password";
    if ($_POST['username'] == $uname && $_POST['password'] == $passwd) {
        $_SESSION['user'] = $_POST['username'];
        header("location:welcome.php");
    } else {
        header("location:index.php");
    }
} else {
    header("location:index.php");
}
?>
