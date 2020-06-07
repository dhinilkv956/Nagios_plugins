<?php
shell_exec("/var/www/html/report/script.sh");
header('Location: http://10.10.10.10/report/phpmail.php');
?>

