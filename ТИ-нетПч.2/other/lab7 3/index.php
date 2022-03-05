<?php
    define('ORIGINAL_DIR', './images/original/');
    define('PREVIEW_DIR', './images/preview/');

    $connection = mysqli_connect("0.0.0.0:33060", "student", "student", "DB_NAME");

    function resizeImage($filePath, $targetFilePath, $newWidth) {
        list($width, $height, $type, $attr) = getimagesize( $filePath );
        $newHeight = $height / ($width / $newWidth);

        $src = imagecreatefromstring(file_get_contents( $filePath ) );
        $dst = imagecreatetruecolor( $newWidth, $newHeight );
        imagecopyresampled( $dst, $src, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height );
        imagedestroy( $src );
        imagepng( $dst, $targetFilePath ); // adjust format as needed
        imagedestroy( $dst );
        
        return $dst;
    }
    
    function upload_file($file, $connection) {
        $fileName = basename($file['name']);
        $uploadFilePath = ORIGINAL_DIR . $fileName;
        $cropFilePath = PREVIEW_DIR . $fileName;
        
        if (!str_contains($file['type'], 'image')) {
            echo 'Данный тип файла не поддерживается! '; 
            return;
        }

        if ($file['size'] > 5E+6) {
            echo 'Размер файла на должен превышать 5 мегабайт!'; 
            return;
        }
        
        if (copy($file['tmp_name'], $uploadFilePath)) {
            resizeImage($uploadFilePath, $cropFilePath, 300);
            echo "Файл корректен и был успешно загружен.\n";

            mysqli_query($connection, "INSERT INTO Gallery (name, clicks) VALUES ('".$fileName."', 0)");
        } else {
            echo 'Ошибка загрузки файла'; 
        }
    }

    if (isset($_FILES['userfile'])) {
        upload_file($_FILES['userfile'], $connection);
    }

    $result = mysqli_query($connection, "SELECT * FROM Gallery ORDER BY clicks DESC", MYSQLI_USE_RESULT);
    $imagesInfoArray = mysqli_fetch_all($result, MYSQLI_BOTH);
?>

<!DOCTYPE html>

<html>

<head>
    <title>Галерея фотографий</title>
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

                    echo "<div class='image_preview'>
                            <a href='./photo.php?name=$imageName&clicks=$imageClicks'>
                                <img class='preview' src='images/preview/$imageName' alt='$imageName' />
                            </a>
                            <span class='image_clicks'>Нажатий: $imageClicks</span>
                        </div>";
                }
            ?>
        </div>
    </main>
</body>

</html>