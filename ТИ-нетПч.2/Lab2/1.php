<?php
echo "<b> task 1 </b> <br>";

$a = random_int(-100, 100);
$b = random_int(-100, 100);

if ($a >= 0 & $b >= 0) {
    echo "a = $a" . "\t" . "b = $b" . '<br/>';
    echo "$a - $b = " . $a - $b . '<br/>';
} elseif ($a < 0 & $b < 0) {
    echo "a = $a" . "\t" . "b = $b" . '<br/>';
    echo "$a - $b = " . $a * $b . '<br/>';
} elseif (($a < 0 & $b >= 0) | ($a >= 0 & $b < 0)) {
    echo "a = $a" . "\t" . "b = $b" . '<br/>';
    echo "$a - $b = " . $a + $b . '<br/>';
}
