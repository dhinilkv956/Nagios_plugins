<?php
shell_exec("/var/www/html/bandwidth_report/bandwidth.sh");
header('Location: http://10.10.10.10/bandwidth_report/file/');
?>
