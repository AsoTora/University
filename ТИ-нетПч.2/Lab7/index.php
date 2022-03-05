<?php
    define('ORIGINAL_DIR', './images/original/');
    define('PREVIEW_DIR', './images/preview/');

    $connection = mysqli_connect("localhost:3306", "root", "password", "lab7");

    function resize($originalFile, $targetFile, $newwidth, $newheight){
        $info = getimagesize($originalFile);
        $mime = $info['mime'];
    
        switch ($mime) {
            case 'image/jpeg':
                $image_create_func = 'imagecreatefromjpeg';
                $image_save_func = 'imagejpeg';
                break;
    
            case 'image/jpg':
                $image_create_func = 'imagecreatefromjpeg';
                $image_save_func = 'imagejpeg';
                break;
    
            case 'image/png':
                $image_create_func = 'imagecreatefrompng';
                $image_save_func = 'imagepng';
                break;
    
            default:
                throw new Exception('Unknown image type.');
                break;
        }
    
        try {
            $img = $image_create_func($originalFile);
            list($width, $height) = getimagesize($originalFile);
            $tmp = imagecreatetruecolor($newwidth, $newheight);
            imagecopyresampled($tmp, $img, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);
    
            if (file_exists($targetFile)) {
                unlink($targetFile);
            }
            $image_save_func($tmp, "$targetFile");
        } catch (Exception $e) {
            $e->getMessage();
        }
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

        if (file_exists($uploadFilePath) || file_exists($cropFilePath)) {
            echo 'Sorry, file already exists.';
            return;
        }
        
        if (copy($file['tmp_name'], $uploadFilePath)) {
            resize($uploadFilePath, $cropFilePath, 150,150);
            echo "Файл корректен и был успешно загружен.\n";

            mysqli_query($connection, "INSERT INTO lab7.Gallery (name, clicks) VALUES ('".$fileName."', 0)");
        } else {
            echo 'Ошибка загрузки файла'; 
        }
    }

    if (isset($_FILES['userfile'])) {
        try {
            upload_file($_FILES['userfile'], $connection);
        }
        catch (Exception $e) {
            $e->getMessage();
        }
    }
    $result = mysqli_query($connection, "SELECT * FROM lab7.Gallery ORDER BY clicks DESC", MYSQLI_USE_RESULT);
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
        <h1>Lab7</h1>

        <form method="post" enctype="multipart/form-data">
            <input type="file" accept="image/*" name="userfile" value="Загрузить файл" />
            <br />
            <br />

            <input type="submit" value="Загрузить файл!" />
        </form>

        <br />
        <br />

        <div class="images_list">
            <?php 
                foreach($imagesInfoArray as $imageInfo) {
                    $imageName = $imageInfo[1];
                    $imageClicks = $imageInfo[0];
                    $file_path = "images/preview/" . $imageName;
                    $orig_path = "images/original/" . $imageName;

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