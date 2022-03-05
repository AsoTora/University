<?php
    require __DIR__ . '/controller.php';

    $imageName = getImageName();
    $imageClicks = getImageClicks();
    increaseClicks();
?>

<!DOCTYPE html>

<html>

<head>
    <title>Просмотр фото</title>
    <link rel="stylesheet" href="./style.css">
</head>

<body>
    <img class="original" src='<?php echo ORIGINAL_DIR . $imageName?>' alt='<?php echo $imageName?>' />
    <div class="info">
        <h3>Количество нажатий: <?php echo $imageClicks + 1?></h3>
        <a href="../main/view.php">Назад</a>
    </div>
</body>

</html>