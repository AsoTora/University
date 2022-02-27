<?php
require_once __DIR__ . '/check.php';
page_check();

// set style coockie
setcookie("style", "default.css");
isset($_POST["style"]) ? $_COOKIE["style"] = $_POST["style"] . ".css" : $_COOKIE["style"] = "default.css";
?>


<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Lab 5 task 2</title>
    <link rel="stylesheet" href="<?php echo "styles/{$_COOKIE["style"]}"; ?>" />
</head>

<h1>Style settings</h1>

<form action="<?php echo htmlspecialchars($_SERVER['PHP_SELF']) ?>" method="post">
    <div>
        <label for="style">Style</label>
        <select name="style" id="style">
            <option value=>--- Choose a style ---</option>
            <option value="light" <?php echo $_COOKIE["style"] == "light.css" ? "selected" : ""; ?>>Light</option>
            <option value="dark" <?php echo $_COOKIE["style"] == "dark.css" ? "selected" : ""; ?>>Dark</option>
            <option value="default" <?php echo $_COOKIE["style"] == "default.css" ? "selected" : ""; ?>>Default</option>
        </select>
    </div>
    <div>
        <button type="submit">Select</button>
    </div>
</form>

<footer>
    <a href="logout.php">Logout</a>
</footer>

</html>