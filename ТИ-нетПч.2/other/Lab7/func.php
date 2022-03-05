<?php
set_exception_handler("my_exception_handler");

function my_exception_handler($connection)
{   
    $_SESSION["error"] = "Ошибка загрузки файла.";

    unlink($_SESSION["filename"]);
    $fn = $_SESSION["filename_short"];

    mysqli_query($connection, "delete from image_info where filename = '$fn'");

    header("Location: index.php");
}

function get_images($connection)
{
    $result = mysqli_query($connection, "select * from image_info order by number_of_clicks desc");
    $images = array();

    $final_images = array();

    while ($row = mysqli_fetch_assoc($result)) {
        $images[] = $row;
    }

    foreach ($images as $image) {
        $info = pathinfo("img/" . $image["filename"]);
        $ext = $info["extension"];
        if (is_file("img/" . $image["filename"]) && ($ext == "jpg" || $ext == "png" || $ext == "gif")) {
            $final_images[] = $image;
        }
    }

    return $final_images;
}

function upload_file($file, $connection)
{
    $type = $file["type"];
    $size = $file["size"];

    if ($type != "image/jpeg" && $type != "image/png" && $type != "image/gif" && $type != "") {
        throw new Exception("Недопустимый тип файла ($type).");
    } else if ($size > 250000) {
        throw new Exception("Размер файла должен быть менее 244 Кбайт.");
    } else if ($file["name"] == "") {
        throw new Exception("Файл не выбран.");
    }

    $bytes = bin2hex(random_bytes(10));

    $filename = "img/" . $bytes . $file["name"];
    $filename_short = $bytes . $file["name"];
    $_SESSION["filename"] = $filename;
    $_SESSION["filename_short"] = $filename_short;
    
    var_dump($filename, $_SESSION, $filename_short);
    if (copy($file["tmp_name"], "img/" . $bytes . $file["name"])) {
        mysqli_query($connection, "insert into image_info (filename) values ('$filename_short')");
        mysqli_close($connection);
    } else {
        throw new Exception("Ошибка загрузки файла.");
    }

    $type = $file["type"];
    if ($type == "image/png") {
        $new_pic = imagecreatefrompng($filename);
    } else if ($type == "image/gif") {
        $new_pic = imagecreatefromgif($filename);
    } else {
        $img = imagecreatefromjpeg($filename);
        imagejpeg($img, "img/" . $bytes . $file["name"], 0);
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

function update_number_of_clicks($filename, $connection)
{
    $connection = mysqli_connect(getenv("MYSQL_HOST"), getenv("MYSQL_USER"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_DB"));

    $result = mysqli_query($connection, "select * from image_info where filename = '$filename'");
    $row = mysqli_fetch_assoc($result);

    $alt = $row["alt"];
    $title = $row["title"];
    $number_of_clicks = $row["number_of_clicks"];
    $number_of_clicks += 1;

    mysqli_query($connection, "update image_info set number_of_clicks = $number_of_clicks where filename = '$filename'");
    mysqli_close($connection);
    
    return [$number_of_clicks, $alt, $title];
}





