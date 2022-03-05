<?php
    $gallery_model_path = "C:\Apache24\htdocs\labs\lab8\models\gallery_model.php";
    include($gallery_model_path);

    error_reporting(E_ERROR | E_PARSE);
    
    $error = "";
    $success = "";
    if (isset($_FILES["file"]))
    {
        try
        {
            $result = upload_file($_FILES["file"]);

            if ($result)
            {
                $success = "Файл успешно загружен.";
            }
        }
        catch (Exception $e) 
        {
            $error = $e->getMessage();
        }
        
    }

    $images = get_images();
?>