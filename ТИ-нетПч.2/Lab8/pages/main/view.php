<?php 
    require __DIR__ . '/controller.php';

    echo checkForUploadRequest();
    $imagesInfoArray = getImagesInfoArray();
?>

<!DOCTYPE html>

<html>

<head>
    <title>Lab 8</title>
    <link rel="stylesheet" href="./style.css">
</head>

<body>
    <main>
        <h1>Галерея фотографий</h1>

        <form method="post" enctype="multipart/form-data">
            <input type="file" name="userfile" value="Загрузить файл" />
            <br />
            <br />

            <input type="submit" value="Загрузить файл!" />
        </form>

        <br />
        <br />

        <div class="images_list">
            <?php 
                foreach($imagesInfoArray as $imageInfo) {
                    $imageName = $imageInfo[0];
                    $imageClicks = $imageInfo[1];
                    $imageTitle = $imageInfo[2];
                    $imageAlt = $imageInfo[3];

                    echo "<div class='image_preview'>
                            <a href='../edit/view.php?name=$imageName'>Изменить</a>
                            <a href='../photo/view.php?name=$imageName&clicks=$imageClicks'>
                                <img 
                                    src='".PREVIEW_DIR."$imageName' 
                                    alt='$imageAlt' 
                                    class='preview' 
                                    title='$imageTitle'
                                />
                            </a>
                            <span class='image_clicks'>Нажатий: $imageClicks</span>
                            <span class='image_clicks'>Title: $imageTitle</span>
                            <span class='image_clicks'>Alt: $imageAlt</span>
                        </div>";
                }
            ?>
        </div>
    </main>
</body>

</html>