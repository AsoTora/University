<!DOCTYPE html>
<html lang="en">

<?php
$id = $_GET['id']; // Считываем передаваемый параметр 
?>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ex1 Просмотр картинки No <?php echo $id; ?></title>
</head>

<body>
    <img src="img/<?php echo $id; ?>.png" width="300" />
    <h2>Какое-то описание картинки</h2>
</body>

</html>