<?php
    function update_number_of_clicks($filename)
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
?>