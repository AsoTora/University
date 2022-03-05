<?php
    $edit_controller_path = '~/controllers/edit_controller.php';
    include($edit_controller_path);
?>

<!DOCTYPE html>
<html lang="ru">
    <head>
        <link href="../../../style.css" rel="stylesheet">
        <link href="../style.css" rel="stylesheet">
        <title>Редактирование</title>
    </head>
    <body>
        <div class="container">
            <form method="post">
                <table>
                    <tr>
                        <td><label for="alt-input">alt</label></td>
                        <td><input id="alt-input" class="login-form-input" type="text" name="alt" autocomplete="off" value="<?php echo $alt; ?>" /></td>
                    </tr>
                    <tr>
                        <td><label for="title-input">title</label></td>
                        <td><input id="title-input" class="login-form-input" type="text" name="title" autocomplete="off" value="<?php echo $title; ?>" /></td>
                    </tr>
                </table>
                <div class="login-form-submit-container">
                    <input class="login-form-submit" type="submit" value="Сохранить" />
                </div>
            </form><br>
            <div>
                <a href="photo.php?filename=<?php echo $filename; ?>"">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-box-arrow-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M6 12.5a.5.5 0 0 0 .5.5h8a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5h-8a.5.5 0 0 0-.5.5v2a.5.5 0 0 1-1 0v-2A1.5 1.5 0 0 1 6.5 2h8A1.5 1.5 0 0 1 16 3.5v9a1.5 1.5 0 0 1-1.5 1.5h-8A1.5 1.5 0 0 1 5 12.5v-2a.5.5 0 0 1 1 0v2z"/>
                        <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/>
                    </svg>
                    Вернуться к фотографии
                </a>
            </div>
        </div>
    </body>
</html>