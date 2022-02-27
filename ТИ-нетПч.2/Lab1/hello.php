<?php

echo "<b> task 0 </b> <br>";

echo 'Hello World';
echo "<br>" . "<br>";

echo "<b> task 1 </b> <br>";

// Declare variables
$name = "Andrei"; // string
$age = 28; // integer
$isMale = true; // bool
$height = 1.75; // float
$children = null; // null
const MARK = 10; // const

// Print the variables and their types. 
echo $name . ' - ' . gettype($name) . '<br>';
echo $age . ' - ' . gettype($age) . '<br>';
echo $isMale . ' - ' . gettype($isMale) . '<br>';
echo $height . ' - ' . gettype($height) . '<br>';
echo $children . ' - ' . gettype($children) . '<br>';

// const
echo MARK . ' - ' . gettype(MARK) . '<br>';

// PHP built-in
echo SORT_ASC . '<br>';

echo "<br>";
echo "<b> task 2 </b> <br>";
// Task 2 Print the variables and their types in double quotes. 
echo "$name" . '<br>';
echo "$age" . '<br>';
echo "$isMale" . '<br>';
echo "$height"  . '<br>';
echo "$children" . '<br>';
echo "MARK" . '<br>';


echo "<b> task 3 </b> <br>";

// Task 3 Print the variables and their types in single quotes. 
echo '$name' . '<br>';
echo '$age' . '<br>';
echo '$isMale' . '<br>';
echo '$height'  . '<br>';
echo '$children' . '<br>';
echo '$MARK' . '<br>';

echo "<br>";
// task 4
echo "<b> task 4 </b> <br>";
$a = "Выведите на экран любое четверостишие. Для каждой новой строки используйте отдельный оператор echo.\n ";
$b = "Каждая строчка должна быть отдельной строковой переменной. Также необходимо использовать переводы строки.\n";
$c = "После четверостишия поставьте инициалы автора и сделайте их подчёркнутыми.\n";
$d = "Someone A.P.";
echo nl2br($a . $b . $c . $d);

// ! The nl2br() function inserts HTML line breaks (<br> or <br />) in front of each newline (\n) in a string.

echo "<br>";
echo "<br>";

// task 5
echo "<b> task 5 </b> <br>";
echo nl2br("Выведите на экран любое четверостишие. Для каждой новой строки используйте отдельный оператор echo.
Каждая строчка должна быть отдельной строковой переменной. Также необходимо использовать переводы строки.
После четверостишия поставьте инициалы автора и сделайте их подчёркнутыми.
<u> Someone A.P. </u>");

echo "<br>";
echo "<br>";

// task 6
echo "<b> task 6 </b> <br>";
echo 10 + "20 приветов" . '<br>'; 
echo 5 + NULL . '<br>'; 
echo $age + $height . '<br>';

echo "<br>";


// task 7
echo "<b> task 7 </b> <br>";
$a = (false xor false);
$b = (true xor true);
$c = (false xor true);
$d = (true xor false);
var_dump($a,$b,$c,$d);

echo "<br>";
echo "<br>";


// task 8
echo "<b> task 8 </b> <br>";

$x = 10;
$y = 15;
echo "$x, $y" . '<br>';

// var 1

list($x,$y) = array($y,$x);
echo "$x, $y" . '<br>';

// var 2

$x = $x + $y; $y = $x - $y; $x = $x - $y;
echo "$x, $y" . '<br>';