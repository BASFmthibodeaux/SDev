<?php
function connect_database ($database) {
    $link = mysql_connect("127.0.0.1", "root", "root")
        or die("<error>Could not connect</error>");
    mysql_select_db($database) or die("Could not select database");
    return $link;
}

?>
