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
        echo date('H:i')."</br>";

        $hour = date('H');
        $minute = date('i');
    

        if ($hour == 0 || $hour>=5 && $hour<=20)
        {
            echo "$hour часов ";
        }
        elseif ($hour == 1 || $hour == 21)
        {
            echo "$hour час ";
        }
        else
        {
            echo "$hour часа ";
        }

        if ($minute == 0 || $minute>=11 && $minute<=14 ||($minute%10 >=5) &&  ($minute%10 <= 9))
        {
            echo "$minute минут";
        }
        elseif ($minute%10 == 1)
        {
            echo "$minute минута";
        }
        else
        {
            echo "$minute минуты";
        }

        // if (($minute%10 >=2) &&  ($minute%10 <= 4))

    ?>
</body>
</html>