<?php
    $edit_model_path = '~/models/edit_model.php';
    include($edit_model_path);

    error_reporting(E_ERROR | E_PARSE);
    
    $filename = $_GET["filename"];
    
    if (isset($_POST["alt"]) && isset($_POST["title"]))
    {
        update_alt_and_title($filename, $_POST["alt"], $_POST["title"]);
    }
    
    [$alt, $title] = get_alt_and_title($filename);
?>