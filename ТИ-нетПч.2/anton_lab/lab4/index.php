<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Галерея изображений</title>
</head>
<body>
    <?php
        for($i = 1; $i <= 4; $i++)
            echo "<a href = photo.php?id=$i >Картинка №$i</a><br/>";
    ?>
</body>
</html>