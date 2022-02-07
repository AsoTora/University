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
    <div class="content"></div>
    <?php
        $n = 100;
        $i = 0;
        while ($i <= $n)
        {
            if ($i%3 == 0){
               echo "$i<br/>";
                $i++; 
            }
                
            else
        $i++;
        }
    ?>
</body>
</html>