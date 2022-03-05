<?php 
    require __DIR__ . '/model.php';

    function checkForUploadRequest() {
        $response = NULL;

        if (isset($_FILES['userfile'])) {
            $connection = mysqli_connect(DB_IP, DB_USERNAME,DB_PASSWORD, DB_NAME);
            $response = uploadFile($_FILES['userfile'], $connection);
            mysqli_close($connection);
        }

        return $response;
    }

    function getImagesInfoArray() {
        $connection = mysqli_connect(DB_IP, DB_USERNAME,DB_PASSWORD, DB_NAME);
        $imagesInfoArray = getImagesInfoSortedByClicls($connection);
        mysqli_close($connection);

        return $imagesInfoArray;
    }
?>