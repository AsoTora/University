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
    <form>
        <input type="text" name="letter">
        <input type="submit" value="Применить">
    </form>
    <?php
        $i = -1;
        while (++$i <= 100)
        {
            if ($i%3 == 0)
            {
                echo $i." ";
                if ($i %  11 == 0 && $i != 0)
                {
                    echo "</br>";
                }
            }
        }
    ?>
</body>
</html>