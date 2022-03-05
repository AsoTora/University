<?php 
    require __DIR__ . '/model.php';

    function getImageName() {
        return $_GET["name"];
    }

    function getImageInfo() {
        $connection = mysqli_connect(DB_IP, DB_USERNAME, DB_PASSWORD, DB_NAME);
        $imageInfo = fetchImageInfo($connection, getImageName());
        mysqli_close($connection);

        return $imageInfo;
    }

    function updateTitleAndAlt() {
        if (isset($_POST['title']) && isset($_POST['alt'])) {
            $connection = mysqli_connect(DB_IP, DB_USERNAME, DB_PASSWORD, DB_NAME);
            
            updateImageTitle($connection, getImageName(), $_POST['title']);
            updateImageAlt($connection, getImageName(), $_POST['alt']);

            mysqli_close($connection);
        }
    }
?>