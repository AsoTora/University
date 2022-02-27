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
        $a = -10;
        $b = -5;

        echo "a = $a b = $b</br>";

        if ($a>=0 && $b>=0)
        {
            $result = $a-$b;
            echo "a и b положительные, их разность равна: $result";
        }
        elseif ($a<0 && $b<0)
        {
            $result = $a*$b;
            echo "a и b отрицательные, их произведение равно: $result";
        }
        elseif (($a>=0 && $b<0) || ($a<0 && $b>=0))
        {
            $result = $a+$b;
            echo "a и b разных знаков, их сумма равна: $result";
        }

    ?>
</body>
</html>