<?php 
    require __DIR__ . '/controller.php';

    $imageInfo = getImageInfo();
    $imageTitle = $imageInfo[2];
    $imageAlt = $imageInfo[3];

    updateTitleAndAlt();
?>

<!DOCTYPE html>

<html>

<head>
    <title>Lab 8</title>
    <link rel="stylesheet" href="./style.css">
</head>

<body>
    <h1>Изменение title и alt атрибутов картинки</h1>
    <br>
    <br>

    <form method='post'>
        <label for='title'>Title</label>
        <input type='text' name='title' value='<?php echo $imageTitle ?>' required>
        <label for='alt'>Alt</label>
        <input type='text' name='alt' value='<?php echo $imageAlt ?>' required>

        <input type="submit" value='Сохранить'>
    </form>

    <br>
    <br>
    <br>

    <a href="../main/view.php">Назад</a>
</body>

</html>