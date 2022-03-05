<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/constants.php';
    
    function increseClicksOfImage($connection, $name, $clicks) {
        mysqli_query($connection, 
        "UPDATE sakila.Gallery
        SET clicks = clicks + 1
        WHERE name = '$name' AND clicks = $clicks");
    }
?>