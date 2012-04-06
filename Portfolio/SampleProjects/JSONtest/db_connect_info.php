<?php

// Create varaibles for authentication to the DB
$DB_SERVER 		= "mysql.XXXXXX.com";
$DB_USERNAME 	= "XXXXXX";
$DB_PASSWORD 	= "XXXXXX";
$DB_NAME	 	= "XXXXXX";

// Make a MySQL Connection
$con = mysql_connect($DB_SERVER, $DB_USERNAME, $DB_PASSWORD) or die(mysql_error());
mysql_select_db($DB_NAME) or die(mysql_error());

?>