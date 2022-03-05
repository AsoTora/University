<?php
    $photo_model_path = "C:\Apache24\htdocs\labs\lab8\models\photo_model.php";
    include($photo_model_path);

    error_reporting(E_ERROR | E_PARSE);
    
    $filename = $_GET["filename"];
    
    [$number_of_clicks, $alt, $title] = update_number_of_clicks($filename);
?>