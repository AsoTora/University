<!DOCTYPE html>

<?php
        $id = $_GET['id'];
?>

<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Просмотр картинки № <?php echo $id;?></title>
</head>
<body>
    <img src="/lab4/img/<?php echo $id;?>.jpg" width="400"/> 
    <h2>Какое-то описание картинки</h2>
</body>
</html>
