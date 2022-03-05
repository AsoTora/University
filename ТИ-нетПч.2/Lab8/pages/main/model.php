<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/Lab8' . '/constants.php';
    
    function resizeImage($originalFile, $targetFile, $newwidth, $newheight){
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
            return $tmp;
        } catch (Exception $e) {
            $e->getMessage();
        }
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
            resizeImage($uploadFilePath, $cropFilePath, 150,150);
            mysqli_query($connection, "INSERT INTO Gallery (name, clicks, title, alt) 
            VALUES ('".$fileName."', 0, 'image', 'image')");
            
            return "Файл корректен и был успешно загружен.\n";
        } else {
            return 'Ошибка загрузки файла'; 
        }
    }

    function getImagesInfoSortedByClicls($connection) {
        $result = mysqli_query($connection, "SELECT * FROM Gallery ORDER BY clicks DESC", MYSQLI_USE_RESULT);
        return mysqli_fetch_all($result, MYSQLI_BOTH);
    }
?>