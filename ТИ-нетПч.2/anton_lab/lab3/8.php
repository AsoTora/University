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
        function translit($string)
        {
            $alphabet = array(
                "а" => "a",
                "б" => "b",
                "в" => "v",
                "г" => "g",
                "д" => "d",
                "е" => "e",
                "ё" => "yo",
                "ж" => "zh",
                "з" => "z",
                "и" => "i",
                "й" => "j",
                "к" => "k",
                "л" => "l",
                "м" => "m",
                "н" => "n",
                "о" => "o",
                "п" => "p",
                "р" => "r",
                "с" => "s",
                "т" => "t",
                "у" => "u",
                "ф" => "f",
                "х" => "h",
                "ц" => "c",
                "ч" => "ch",
                "ш" => "sh",
                "щ" => "shch",
                "ъ" => '"',
                "ы" => "y",
                "ь" => "'",
                "э" => "e",
                "ю" => "yu",
                "я" => "ya"
            );

            $string = str_replace(" ", "_", $string);

            return strtr($string, $alphabet);    
        }

        $word = "гвоздь розетка";

        echo $word." -> ".translit("$word");
    ?>
</body>
</html>