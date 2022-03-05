<?php 
    require __DIR__ . '/model.php';

    function getImageName() {
        return $_GET["name"];
    }

    function getImageClicks() {
        return $_GET["clicks"];
    }
    
    function increaseClicks() {
        $connection = mysqli_connect(DB_IP, DB_USERNAME,DB_PASSWORD, DB_NAME);
        increseClicksOfImage($connection, getImageName(), getImageClicks());

        mysqli_close($connection);
    }
?>