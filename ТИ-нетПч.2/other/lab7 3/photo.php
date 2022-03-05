<?php
   $connection = mysqli_connect("0.0.0.0:33060", "student", "student", "sakila");  

   $imageName = $_GET["name"];
   $imageClicks = $_GET["clicks"];

   mysqli_query($connection, 
        "UPDATE sakila.Gallery
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
    <img class="original" src='images/original/<?php echo $imageName?>' alt='<?php echo $imageName?>' />
    <div class="info">
        <h3>Количество нажатий: <?php echo $imageClicks + 1?></h3>
        <a href="./index.php">Назад</a>
    </div>
</body>

</html>