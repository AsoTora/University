<?php
echo "<b> task 3 </b> <br>";

$a = random_int(-100, 100);
$b = random_int(-100, 100);

function Plus($x, $y)
{
    return ($x + $y);
}

function Minus($x, $y)
{
    return ($x - $y);
}

function Mult($x, $y)
{
    return ($x * $y);
}

function Div($x, $y)
{
    return ($x / $y);
}

echo $a . ' + ' . $b . ' = ' . Plus($a, $b) . '<br/>';
echo $a . ' - ' . $b . ' = ' . Minus($a, $b) . '<br/>';
echo $a . ' * ' . $b . ' = ' . Mult($a, $b) . '<br/>';
echo $a . ' / ' . $b . ' = ' . Div($a, $b) . '<br/>';

echo '<br>';


// task 4
function mathOperation($arg1, $arg2, $operation)
{
    switch ($operation) {
        case 'plus':
            return Plus($arg1, $arg2);
        case 'minus':
            return Minus($arg1, $arg2);
        case 'mult':
            return Mult($arg1, $arg2);
        case 'div':
            return Div($arg1, $arg2);
        default:
            echo "unknown";
            return ("error");
    }
}

$operation = $_POST['operation'];
echo 'a = ' . $a . '<br/>';
echo 'b = ' . $b . '<br/>';
echo 'operation = ' . $operation . '<br/>';
echo ' answer = ' . mathOperation($a, $b, $operation);
