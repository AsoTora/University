<!DOCTYPE html>

<?php
        if(isset($_POST['a']) && isset($_POST['b']))
        {
            $result = $_POST['a'] + $_POST['b']; 
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
    <title>Document</title>
</head>
<body>
    <form method="post">
    <input type="text" name="a" /> +
    <input type="text" name="b" />
    <input type="submit" value="=" />
    <?php echo $result;?>
    </form>
</body>
</html>


