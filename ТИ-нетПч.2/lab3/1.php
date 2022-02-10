<?php
echo "<b> Task 1 </b> <br>";

$n = 100;
$i = 0;
while ($i <= $n) {
    if ($i % 3 == 0) {
        echo "$i<br/>";
        $i++;
    } else
        $i++;
}
