<?php
// Check if image file is a actual image or fake image
if (isset($_POST["submit"])) {
    $target_dir = "img/original/";
    $target_file = $target_dir . basename($_FILES["fileToUpload"]["name"]);
    
    $resised_dir = "img/smaller/";
    $resised_file = $resised_dir . basename($_FILES["fileToUpload"]["name"]);

    $finfo = finfo_open(FILEINFO_MIME_TYPE);
    $mimetype = finfo_file($finfo, $_FILES['fileToUpload']['tmp_name']);

    var_dump($mimetype);
    var_dump($_POST);
    

    // check file type
    $formats = array("image/jpg", "image/jpeg", "image/png");
    if (!in_array($mimetype, $formats)) {
        echo "<script>
                alert('Filetype Not supported');
                window.location.href='index.php';
                </script>";
        exit();
    }
    // check file size
    if ($_FILES['fileToUpload']['size'] / (1024*1024) >= 10) {
        echo "<script>
                alert('File to huge!');
                window.location.href='index.php';
                </script>";
        exit();
    }

    // Check if file already exists
    if (file_exists($target_file)) {
        echo "<script>
        alert('Sorry, file not uploaded.');
        window.location.href='index.php';
        </script>";
        exit();
    }

    // save resised copy
    resize($_FILES["fileToUpload"]["tmp_name"], $resised_file, 150, 150);

    // save original
    if (move_uploaded_file($_FILES["fileToUpload"]["tmp_name"], $target_file)) {
        echo "<script>
        alert('File has been uploaded');
        window.location.href='index.php';
        </script>";
    } else {
        echo "Sorry, there was an error uploading your file.";
    }

    finfo_close($finfo);
} else {
    header("Location: index.php");
}

function resize($originalFile, $targetFile, $newwidth, $newheight)
{
    $info = getimagesize($originalFile);
    $mime = $info['mime'];

    switch ($mime) {
        case 'image/jpeg':
            $image_create_func = 'imagecreatefromjpeg';
            $image_save_func = 'imagejpeg';
            break;

        case 'image/jpg':
            $image_create_func = 'imagecreatefromjpeg';
            $image_save_func = 'imagejpeg';
            break;

        case 'image/png':
            $image_create_func = 'imagecreatefrompng';
            $image_save_func = 'imagepng';
            break;

        default:
            throw new Exception('Unknown image type.');
            break;
    }

    try {
        $img = $image_create_func($originalFile);
        list($width, $height) = getimagesize($originalFile);
        $tmp = imagecreatetruecolor($newwidth, $newheight);
        imagecopyresampled($tmp, $img, 0, 0, 0, 0, $newwidth, $newheight, $width, $height);

        if (file_exists($targetFile)) {
            unlink($targetFile);
        }
        $image_save_func($tmp, "$targetFile");
    } catch (Exception $e) {
        $message=$e->getMessage();
        echo "<script>
        alert('$message');
        window.location.href='index.php';
        </script>";
    }
}

?>


<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 6</title>
    <link rel="stylesheet" href="style.css">
</head>
<h1> Upload </h1>

<body>
</body>

</html>