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
        $intValue = 1234;
        $doubleValue = 1234.5;
        $boolValue = true;
        $stringValue = 'This is string';
        define("PI",3.14);
        echo "Целочисленная переменная: $intValue <br/>";
        echo "Дробная переменная: $doubleValue <br/>";
        echo "Булева переменная: $boolValue <br/>";
        echo "Строка: $stringValue <br/>";
        echo "Константа: PI";
    ?>
</body>
</html>