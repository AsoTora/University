<?php
    session_start();
    set_exception_handler("my_exception_handler");

    function my_exception_handler()
    {
        $_SESSION["error"] = "Ошибка загрузки файла.";

        unlink($_SESSION["filename"]);
        $fn = $_SESSION["filename_short"];

        $connection = mysqli_connect(getenv("MYSQL_HOST"), getenv("MYSQL_USER"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_DB"));
        mysqli_query($connection, "delete from image_info where filename = '$fn'");
        mysqli_close($connection);
        
        header("Location: ../views/gallery.php");
    }
    function get_images()
    {
        $connection = mysqli_connect(getenv("MYSQL_HOST"), getenv("MYSQL_USER"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_DB"));
        $result = mysqli_query($connection, "select * from image_info order by number_of_clicks desc");
        $images = array();

        $final_images = array();

        while($row = mysqli_fetch_assoc($result))
        {
            $images[] = $row;
        }

        foreach ($images as $image)
        {
            $info = pathinfo("~/views/img/" . $image["filename"]);
            $ext = $info["extension"];
            if (is_file("~/views/img/" . $image["filename"]) && ($ext == "jpg" || $ext == "png" || $ext == "gif"))
            {
                $final_images[] = $image;
            }
        }
        
        mysqli_close($connection);

        return $final_images;
    }

    function upload_file($file)
    {            
        $type = $file["type"];
        $size = $file["size"];

        if($type != "image/jpeg" && $type != "image/png" && $type != "image/gif" && $type != "")
        {
            throw new Exception("Недопустимый тип файла ($type).");
            
        }
        else if ($size > 250000)
        {
            throw new Exception("Размер файла должен быть менее 244 Кбайт.");
        }
        else if ($file["name"] == "")
        {
            throw new Exception("Файл не выбран.");
        }

        $connection = mysqli_connect("localhost", "root", "tema1107", "gallery");

        $bytes = bin2hex(random_bytes(10));

        $filename = "~/views/img/" . $bytes . $file["name"];
        $filename_short = $bytes . $file["name"];
        $_SESSION["filename"] = $filename;
        $_SESSION["filename_short"] = $filename_short;

        if(copy($file["tmp_name"], "img/" . $bytes . $file["name"]))
        {
            mysqli_query($connection, "insert into image_info (filename) values ('$filename_short')");
            mysqli_close($connection);
        }
        else
        {
            throw new Exception("Ошибка загрузки файла.");
        }
    
        $type = $file["type"];
        if ($type == "image/png")
        {
            $new_pic = imagecreatefrompng($filename);
        }
        else if ($type == "image/gif")
        {
            $new_pic = imagecreatefromgif($filename);
        }
        else
        {
            $img = imagecreatefromjpeg($filename);
            imagejpeg($img, "img_bq/" . $bytes . $file["name"], 0);
            return true;
        }

        $w = imagesx($new_pic);
        $h = imagesy($new_pic);
        $white = imagecreatetruecolor($w, $h);

        $bg = imagecolorallocate($white, 255, 255, 255);
        imagefill($white, 0, 0, $bg);

        imagecopy($white, $new_pic, 0, 0, 0, 0, $w, $h);

        $new_pic = $white;

        imagejpeg($new_pic, "img_bq/" . $bytes . $file["name"], 0);

        return true;
    }
?>