<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/Lab8' . '/constants.php';

    function fetchImageInfo($connection, $name) {
        $result = mysqli_query($connection, "SELECT * FROM Gallery WHERE name = '$name'", MYSQLI_USE_RESULT);
        $fetchedInfo = mysqli_fetch_all($result, MYSQLI_BOTH);

        return $fetchedInfo[0];
    }

    function updateImageTitle($connection, $name, $title) {
        mysqli_query($connection, 
        "UPDATE Gallery
        SET title = '$title'
        WHERE name = '$name'");
    }

    function updateImageAlt($connection, $name, $alt) {
        mysqli_query($connection, 
        "UPDATE Gallery
        SET alt = '$alt'
        WHERE name = '$name'");
    }
?>