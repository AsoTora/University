<?php 
    require $_SERVER['DOCUMENT_ROOT'] . '/Lab8' . '/constants.php';
    
    function increseClicksOfImage($connection, $name, $clicks) {
        mysqli_query($connection, 
        "UPDATE Gallery
        SET clicks = clicks + 1
        WHERE name = '$name' AND clicks = $clicks");
    }
?>