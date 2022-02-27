<?php
echo "<b> task 5 </b> <br>";

function power($val, $pow)
{
  if ($pow == 0) {
    return 1;
  }
  if ($pow < 0) {
    return power(1 / $val, -$pow);
  }
  return $val * power($val, $pow - 1);
}

$val = random_int(-10, 10);
$pow = random_int(-10, 10);

echo 'val = ' . $val . '<br/>';
echo 'pow = ' . $pow . '<br/>';
echo 'answer = ' . power($val, $pow);
