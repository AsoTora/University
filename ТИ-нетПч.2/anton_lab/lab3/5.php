<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
    <title>Document</title>
</head>
<body>
    <?php
        $regions = array(
            "Минская область" => array("Жодино", "Держинск", "Борисов", "Крупки"),
            "Брестская область" => array("Брест", "Пинск", "Кобрин"),
            "Гомельская область" => array("Гомель", "Мозырь", "Речица", "Корма"),
            "Могилевская область" => array("Могилев", "Бобруйск", "Шклов", "Кричев"),
            "Витебская область" => array("Витебск", "Орша", "Полоцк", "Коханово"),
            "Гродненская область" => array("Гродно","Лида","Новогрудок", "Кореличи")
        );

        foreach ($regions as $region => $cities) {
            echo "$region :</br>";
            foreach ($cities as $city) {
                if (strpos($city, 'К') === 0)
                {
                    echo "$city ";
                }
            }
            echo "</br>";
        }
    ?>
</body>
</html>