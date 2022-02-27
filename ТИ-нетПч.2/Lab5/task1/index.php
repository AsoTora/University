<?php
session_start([
    'cookie_lifetime' => time() + 360,
]);

if (isset($_COOKIE['last_visited'])) {
    $last_visit = $_COOKIE['last_visited'];
}

// Check if the user is logged in already or not.
if (!empty($_SESSION['logged_in'])) {
    // redirect to last visited, if it was set
    empty($last_visit) ? header("Location: choose.php") : header("Location: $last_visit");
}

// Set coockies
if (!empty($_POST['username']) && !empty($_POST['password'])) {
    if (!empty($_POST["remember"])) {
        setcookie("username", $_POST["username"]);
        setcookie("password", $_POST["password"]);
    } else {
        setcookie("username", "");
        setcookie("password", "");
    }
    $_SESSION['logged_in'] = True;
    empty($last_visit) ? header("Location: choose.php") : header("Location: $last_visit");
} 
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 5 task 1</title>
    <link rel="stylesheet" href="style.css">
</head>
<h1> Login page </h1>

<body>

    <form action="index.php" method="post">
        <p>
            Username: <input name="username" type="text" class="input-field" value="<?php if (isset($_COOKIE["username"])) {
                                                                                        echo $_COOKIE["username"];
                                                                                    } ?>" required>
        </p>
        <p>
            Password: <input name="password" type="password" class="input-field" value="<?php if (isset($_COOKIE["password"])) {
                                                                                            echo $_COOKIE["password"];
                                                                                        } ?>" required>
        </p>
        <p>
            <input type="checkbox" name="remember" /> Remember me
        </p>
        <p>
            <input type="submit" value="Login"></span>
        </p>
    </form>

</body>

</html>