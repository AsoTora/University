<?php
$connection = mysqli_connect("localhost:3306", "root", "password", "lab7");

$imageName = $_GET["name"];
$imageClicks = $_GET["clicks"];

mysqli_query(
    $connection,
    "UPDATE lab7.Gallery
        SET clicks = clicks + 1
        WHERE name = '$imageName' AND clicks = $imageClicks"
);
?>

<!DOCTYPE html>

<html>

<head>
    <title>Галерея фотографий</title>
    <link rel="stylesheet" href="./style.css">
</head>

<body>
    <img class="original" src='images/original/<?php echo $imageName ?>' alt='<?php echo $imageName ?>' />
    <div class="info">
        <h3>Количество нажатий: <?php echo $imageClicks + 1 ?></h3>
        <a href="./index.php">Назад</a>
    </div>
</body>

</html>