<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>
    <?php
        $i=0;
        do
        {
            if ($i == 0)
            echo $i." - это ноль <br/>";
            elseif ($i%2 == 0)
            echo $i." - это четное число <br/>";
            elseif ($i%2 != 0)
            echo $i." - это нечетное число <br/>";
            
            $i++;
        }
        while ($i<=10);
        
    ?>
</body>
</html>