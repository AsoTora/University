<!DOCTYPE html>
<html lang="en">
<?php
if (isset($_POST['a']) && isset($_POST['b'])) {
    if (is_numeric($_POST['a']) && is_numeric(isset($_POST['b']))){
        $operator = $_POST['operator'];
        switch ($operator) {
            case "Add":
                $result = $_POST['a'] + $_POST['b'];
                break;
            case "Subtract":
                $result = $_POST['a'] - $_POST['b'];
                break;
            case "Multiply":
                $result = $_POST['a'] * $_POST['b'];
                break;
            case "Divide":
                if ($_POST['b'] == 0) {
                    $result = "you can't do this here!";
                    break;
                } else {
                    $result = $_POST['a'] / $_POST['b'];
                    break;
                }
            default:
                $result = "";
                break;
        }
    } else{
        $result = "";
    }
} else {
    $result = "";
}
?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex 2</title>
</head>

<body>
    <form method="post">
        <input type="text" name="a" />

        <select name="operator" id="operator">
            <option value="Add">+</option>
            <option value="Subtract">-</option>
            <option value="Multiply">*</option>
            <option value="Divide">/</option>
        </select>

        <input type="text" name="b" />
        <input type="submit" value="=" />
        <?php echo $result; ?>
    </form>
</body>

</html>