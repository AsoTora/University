<?php
    function update_alt_and_title($filename, $alt, $title)
    {
        $connection = mysqli_connect(getenv("MYSQL_HOST"), getenv("MYSQL_USER"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_DB"));
        
        mysqli_query($connection, "update image_info set alt = '$alt', title = '$title' where filename = '$filename'");
        mysqli_close($connection);
    }

    function get_alt_and_title($filename)
    {
        $connection = mysqli_connect(getenv("MYSQL_HOST"), getenv("MYSQL_USER"), getenv("MYSQL_PASSWORD"), getenv("MYSQL_DB"));

        $result = mysqli_query($connection, "select * from image_info where filename = '$filename'");
        $row = mysqli_fetch_assoc($result);

        $alt = $row["alt"];
        $title = $row["title"];

        mysqli_close($connection);

        return [$alt, $title];
    }
?>