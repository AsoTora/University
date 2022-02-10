<!DOCTYPE html>
<html lang="en">
<?php
if (isset($_POST['a']) && isset($_POST['b'])) {
    $operator = $_POST['operator'];

    switch ($operator) {
        case "+":
            $result = $_POST['a'] + $_POST['b'];
            break;
        case "-":
            $result = $_POST['a'] - $_POST['b'];
            break;
        case "*":
            $result = $_POST['a'] * $_POST['b'];
            break;
        case "/":
            if ($_POST['b'] == 0) {
                echo '<script>alert("You cant do this here!!")</script>';
                $result = "";
                break;
            } else {
                $result = $_POST['a'] / $_POST['b'];
                break;
            }
        default:
            $result = "";
            break;
    }
} else {
    $result = "";
}
?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex3 Галерея изображений</title>
    <link rel="stylesheet" href="style.css">
</head>

<body>
    <form method="post">
        a: <input name="a" value="<?php echo isset($_POST['a']) ? htmlspecialchars($_POST['a'], ENT_QUOTES) : ''; ?>">
        <br>
        b: <input name="b" value="<?php echo isset($_POST['b']) ? htmlspecialchars($_POST['b'], ENT_QUOTES) : ''; ?>">

        <p>
            <input type="submit" name="operator" value="+" />
            <input type="submit" name="operator" value="-" />
            <input type="submit" name="operator" value="*" />
            <input type="submit" name="operator" value="/" />
        </p>

        Result: <input type='text' value="<?php echo $result; ?>"><br>
    </form>

</body>

</html>