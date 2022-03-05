<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Lab 6</title>
    <link rel="stylesheet" href="style.css">
</head>
<h1> Images </h1>

<body>

    <?php
    $folder_path = 'img/smaller/'; //image's folder path

    $num_files = glob($folder_path . "*.{JPG,jpg,gif,png,bmp}", GLOB_BRACE);

    $folder = opendir($folder_path);

    if ($num_files > 0) {
        while (false !== ($file = readdir($folder))) {
            $file_path = $folder_path . $file;
            $orig_path = "img/original/" . $file;
            $extension = strtolower(pathinfo($file, PATHINFO_EXTENSION));
            if ($extension == 'jpg' || $extension == 'png' || $extension == 'jpeg') {
    ?>
                <a target="_blank" href="<?php echo "./photo.php?name=" . $file; ?>"><img src="<?php echo $file_path; ?>" /> </a>
                </a>
    <?php
            }
        }
    } else {
        echo "the folder was empty !";
    }
    closedir($folder);
    ?>

    <form action="upload.php" method="post" enctype="multipart/form-data">
        Select image to upload:
        <input type="file" accept="image/*" name="fileToUpload" id="fileToUpload" required>
        <input type="submit" value="Upload Image" name="submit">
    </form>

</body>

</html>