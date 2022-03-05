<?php
$imageName = $_GET["name"];

?>

<!DOCTYPE html>

<html>

<head>
    <title>Lab6</title>
    <link rel="stylesheet" href="./style.css">
</head>

<body>
    <img class="original" src='img/original/<?php echo $imageName ?>' alt='<?php echo $imageName ?>' />
    <p></p>
    <a href="./index.php">Назад</a>
</body>

</html>