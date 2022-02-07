<?php
echo "<b> task 6 </b> <br>";


$hours = date("H");
$minutes = date("i");

function timeTask($hours, $minutes)
{
    $HourSymbolsCount = $hours % 10;
    if ($HourSymbolsCount == 0 | $HourSymbolsCount >= 5 | in_array($hours % 100, range(11, 19))) {
        echo $hours . ' часов ';
    } elseif (in_array($HourSymbolsCount, range(2, 4))) {
        echo $hours . ' часа ';
    } elseif ($HourSymbolsCount == 1) {
        echo $hours . ' час ';
    }

    $MinuteSymbolsCount = $minutes % 10;
    if ($MinuteSymbolsCount == 0 | $MinuteSymbolsCount >= 5 | in_array($minutes % 100, range(11, 19))) {
        echo $minutes . ' минут ';
    } elseif ($MinuteSymbolsCount == 1) {
        echo $minutes . ' минута ';
    } elseif (in_array($MinuteSymbolsCount, range(2, 4))) {
        echo $minutes . ' минуты ';
    }
    return (1);
}

timeTask($hours, $minutes);
