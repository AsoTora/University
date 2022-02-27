<?php

// function save_page()
// {
//     // check for first visit to any page, initialize
//     isset($_SESSION['current_page']) || $_SESSION['current_page'] = '';

//     // check if current page != previously recorded page    
//     if ($_SERVER['SCRIPT_NAME'] != $_SESSION['current_page']) {

//         // check and update previous
//         $_SESSION['last_visited'] = isset($_SESSION['current_page']) ? $_SESSION['current_page'] : '';
//         $_SESSION['current_page'] = $_SERVER['SCRIPT_NAME'];
//     }
// }

function page_check()
{
    session_start([
        'cookie_lifetime' => time() + 360,
    ]);

    // Check if the user is logged in already or not.
    if (empty($_SESSION['logged_in'])) {
        header("Location: index.php");
    }else{
        setcookie("last_visited", $_SERVER['REQUEST_URI']);
    }
}
