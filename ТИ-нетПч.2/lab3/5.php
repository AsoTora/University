
<?php
echo "<b> Task 5 </b> <br>";

$obl = array(
  "Московская область" => array("Москва", "Зеленоград", "Клин"),
  "Ленинградская область" => array("Санкт-Петербург", "Всеволожск", "Павловск", "Кронштадт"),
  "Аму́рская о́бласть " => array("Белогорск", "город Свободный", "город Шимановск")
);

foreach ($obl as $i => $cities) {
  echo ("<b>$i</b>" . "<ul>"
  );
  foreach ($cities as $city) {
    if (str_starts_with($city, 'К')) {
      echo ("<li>$city</li>");
    }
  }
  echo ("</ul>");
}
