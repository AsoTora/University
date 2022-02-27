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
        function sum($arg1, $arg2)
        {
            return $arg1 + $arg2;
        }
        function sub($arg1, $arg2)
        {
            return $arg1 - $arg2;
        }
        function multi($arg1, $arg2)
        {
            return $arg1 * $arg2;
        }
        function percent($arg1, $arg2)
        {
            return $arg1*$arg2/100;
        }

        echo sub(100, 30);
    ?>
</body>
</html>