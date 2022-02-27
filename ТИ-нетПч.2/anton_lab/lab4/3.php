<!DOCTYPE html>

<?php
        if(isset($_POST['a']) && isset($_POST['b']))
        {
            if (isset($_POST["+"]))
            {
                $result = $_POST['a'] + $_POST['b']; 
                $operation = $_POST["+"];
            }
            elseif (isset($_POST["-"]))
            {
                $result = $_POST['a'] - $_POST['b'];
                $operation = $_POST["-"]; 
            }
            elseif (isset($_POST["*"]))
            {
                $result = $_POST['a'] * $_POST['b']; 
                $operation = $_POST["*"];
            }
            elseif (isset($_POST["/"]))
            {   
                if ($_POST['b'] == "0")
                {
                    $result = "Деление на ноль невозможно";
                }
                else
                {
                    $result = $_POST['a'] / $_POST['b']; 
                }
                $operation = $_POST["/"];
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
    <title>Calculator</title>
</head>
<body>
    <form method="post">
    <input type="text" name="a" />
    <input type="text" name="b" /> = 
    <input type="text" name="a2" value="<?php echo $_POST['a'];?>" disabled/>
    <?php echo $operation; ?>
    <input type="text" name="b2" value="<?php echo $_POST['b']; ?>" disabled/> =
    <?php echo $result;?>
    </br>
    <input type="submit" value="+" name="+" />
    <input type="submit" value="-" name="-" />
    <input type="submit" value="*" name="*" />
    <input type="submit" value="/" name="/" /> 
    </form>
</body>
</html>

