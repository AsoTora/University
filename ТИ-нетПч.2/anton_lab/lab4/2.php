<!DOCTYPE html>

<?php
        if(isset($_POST['a']) && isset($_POST['b']) && isset($_POST["operation"]))
        {
            if ($_POST["operation"] == "+")
            {
                $result = $_POST['a'] + $_POST['b']; 
            }
            elseif ($_POST["operation"] == "-")
            {
                $result = $_POST['a'] - $_POST['b'];  
            }
            elseif ($_POST["operation"] == "*")
            {
                $result = $_POST['a'] * $_POST['b']; 
            }
            elseif ($_POST["operation"] == "/")
            {
                if ($_POST['b'] == "0")
                {
                    $result = "Деление на ноль невозможно";
                }
                else
                {
                    $result = $_POST['a'] / $_POST['b']; 
                }
            }
        }
        else
        {
            $result = "";
        }
        
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Галерея изображений</title>
</head>
<body>
    <form method="post">
    <input type="text" name="a" />
    <select name="operation">
        <option value="+" selected>+</option>
        <option value="-">-</option>
        <option value="*">*</option>
        <option value="/">/</option>
    </select>
    <input type="text" name="b" />
    <input type="submit" value="=" />
    <?php echo $result;?>
    </form>
</body>
</html>


