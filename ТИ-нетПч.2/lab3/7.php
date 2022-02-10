<?php
echo "<b> Task 7 </b> <br>";

function replace($string) {
    $conv= array(' ' => '_');
    return strtr($string, $conv); # https://www.php.net/manual/en/function.strtr.php
}

print(replace("Напишите функцию, которая заменяет в строке пробелы на подчеркивания и возвращает видоизмененную строчку."));
