<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/constants.php';

    function resizeImage($filePath, $targetFilePath, $newWidth) {
        list($width, $height, $type, $attr) = getimagesize( $filePath );
        $newHeight = $height / ($width / $newWidth);

        $src = imagecreatefromstring(file_get_contents( $filePath ) );
        $dst = imagecreatetruecolor( $newWidth, $newHeight );
        imagecopyresampled( $dst, $src, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height );
        imagedestroy( $src );
        imagepng( $dst, $targetFilePath );
        imagedestroy( $dst );
        
        return $dst;
    }

    
    function uploadFile($file, $connection) {
        $fileName = basename($file['name']);
        $uploadFilePath = ORIGINAL_DIR . $fileName;
        $cropFilePath = PREVIEW_DIR . $fileName;
        
        if (!str_contains($file['type'], 'image')) {
            return 'Данный тип файла не поддерживается!'; ;
        }

        if ($file['size'] > 5E+6) {
            return 'Размер файла на должен превышать 5 мегабайт!'; 
        }
        
        if (copy($file['tmp_name'], $uploadFilePath)) {
            resizeImage($uploadFilePath, $cropFilePath, 300);
            mysqli_query($connection, "INSERT INTO sakila.Gallery (name, clicks, title, alt) 
            VALUES ('".$fileName."', 0, 'image', 'image')");
            
            return "Файл корректен и был успешно загружен.\n";
        } else {
            return 'Ошибка загрузки файла'; 
        }
    }

    function getImagesInfoSortedByClicls($connection) {
        $result = mysqli_query($connection, "SELECT * FROM sakila.Gallery ORDER BY clicks DESC", MYSQLI_USE_RESULT);
        return mysqli_fetch_all($result, MYSQLI_BOTH);
    }
?>