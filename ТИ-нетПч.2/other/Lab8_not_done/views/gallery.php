<?php
$gallery_controller_path = "~/controllers/gallery_controller.php";
include($gallery_controller_path);

if (isset($_SESSION["error"])) {
    $error = $_SESSION["error"];
    unset($_SESSION["error"]);
}
?>

<!DOCTYPE html>
<html lang="ru">

<head>
    <meta charset="UTF-8">
    <link href="../../../style.css" rel="stylesheet">
    <link href="../style.css" rel="stylesheet">
    <title>Загрузка файлов на сервер</title>
</head>

<body>
    <div class="container">
        <h1>Загрузка файлов на сервер</h1>
        <form method="post" enctype="multipart/form-data">
            <div><?php echo $error . $success; ?></div>
            <div class="form-submit-container">
                <input type="file" name="file" />
            </div>
            <div class="form-submit-container">
                <input class="form-submit" type="submit" value="Загрузить" />
            </div>
        </form>
        <form method="post">
            <div class="parent">
                <?php
                $counter = 0;

                foreach ($images as $image) {
                    $name = $image["filename"];
                    //$noc = $image["number_of_clicks"];
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