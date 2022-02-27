<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex2 Галерея изображений2</title>
</head>

<body>
    <h2>Наши картинки</h2>
    <?php
    for ($i = 1; $i <= 4; $i++)
        echo "<a href = 1-1.php?id=$i >Картинка No$i</a><br/>";
    ?>
</body>

</html>