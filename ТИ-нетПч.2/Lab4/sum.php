<!DOCTYPE html>
<html lang="en">
<?php
if (isset($_POST['a']) && isset($_POST['b'])) {
    $result = $_POST['a'] + $_POST['b'];
} else {
    $result = "";
}
?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex3 Галерея изображений</title>
</head>

<body>
    <form method="post">
        <input type="text" name="a" />
        +
        <input type="text" name="b" />
        <input type="submit" value="=" /> 
        <?php echo $result; ?>
    </form>
</body>

</html>