<?php
include("./func.php");
session_start();
$connection = mysqli_connect("localhost:3306", "root", "password", "lab7");

$error = "";
$success = "";
if (isset($_FILES["file"])) {
    try {
        $result = upload_file($_FILES["file"], $connection);

        if ($result) {
            $success = "Файл успешно загружен.";
        }
    } catch (Exception $e) {
        $error = $e->getMessage();
    }
}

$images = get_images($connection);

if (isset($_SESSION["error"])) {
    $error = $_SESSION["error"];
    error_reporting(E_ERROR | E_PARSE);
    unset($_SESSION["error"]);
}

mysqli_close($connection);
?>

<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="style.css">
    <title>Lab 7</title>
</head>

<body>
    <div class="container">
        <h1>Загрузка файлов на сервер</h1>
        <form method="post" enctype="multipart/form-data">
            <div><?php echo $error . $success; ?></div>
            <div class="form-submit-container">
                <input type="file" name="file" accept="image/*" />
            </div>
            <div class="form-submit-container">
                <input class="form-submit" type="submit" value="Загрузить" />
            </div>
        </form>
        <form method="post">
            <div class="parent">
                <?php
                $counter = 0;

                var_dump($images);
                foreach ($images as $image) {
                    $name = $image["filename"];
                    // $noc = $image["number_of_clicks"];
                    //$percentage = round($image["number_of_clicks"] / $total_count * 100, 2);
                    echo "
                            <div class='child'>
                                <div>
                                    <a href='photo.php?filename=$name'>
                                        <img src='img_bq/$name' width='100' height='100' />
                                    </a>
                                </div>
                                <div>

                                </div>
                            </div>";
                    $counter++;

                    if ($counter == 5) {
                        echo "<br />";
                        $counter = 0;
                    }
                }
                ?>
            </div>
        </form>
    </div>
</body>

</html>