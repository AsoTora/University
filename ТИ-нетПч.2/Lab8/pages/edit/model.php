<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/constants.php';

    function fetchImageInfo($connection, $name) {
        $result = mysqli_query($connection, "SELECT * FROM DB_NAME.Gallery WHERE name = '$name'", MYSQLI_USE_RESULT);
        $fetchedInfo = mysqli_fetch_all($result, MYSQLI_BOTH);

        return $fetchedInfo[0];
    }

    function updateImageTitle($connection, $name, $title) {
        mysqli_query($connection, 
        "UPDATE DB_NAME.Gallery
        SET title = '$title'
        WHERE name = '$name'");
    }

    function updateImageAlt($connection, $name, $alt) {
        mysqli_query($connection, 
        "UPDATE DB_NAME.Gallery
        SET alt = '$alt'
        WHERE name = '$name'");
    }
?>