<?php	$con = pg_connect("host=localhost dbname=pv user=postgres password=postgres"); 
if (!$con) {
	echo "Err1";
	exit; //database connection error, exit
}
?>