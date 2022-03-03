<?php
echo "<b> Task 2 </b> <br>";
$i = 0;
do {
    if ($i % 2 == 0)
        echo $i . " - это четное число <br/>";
    else
        echo $i . " - это нечетное число <br/>";
    if ($i == 0)
        echo $i . " - это ноль <br/>";

    $i++;
} while ($i <= 10);
