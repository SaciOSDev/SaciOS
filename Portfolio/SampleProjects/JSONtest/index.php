<?php 

// How to use this script
// ------------------------------------------------------------------------
// Required: Use the 'q' value to specify what table we want to query from
// Ex: index.php?q=[table_name]
// 
// Optional: Use the 'id' value to specify a unique record id
// Ex: index.php?q=[table_name]&id=[num]
//
// Optional: Use the 'a' value to specify an action
// ACTIONS:
// 		DELETE: d, del, delete
//		INSERT or UPDATE: i, a, u, s, insert, add, update save
// Ex: index.php?q=[table_name]&id=[num]&a=d
// Ex: index.php?q=[table_name]&a=s
// NOTE: When inserting, updating, or saving data you must POST the object
// in json format in the body of the HTTP request.
// ------------------------------------------------------------------------

// Include the database connection information
include("db_connect_info.php");

// Pull in our GET parameters
$queryType = htmlspecialchars($_GET["q"]);
if ($queryType=="") $queryType = htmlspecialchars($_GET["query"]);
$action = htmlspecialchars($_GET["a"]);
if ($action=="") $action = htmlspecialchars($_GET["action"]);
$id = htmlspecialchars($_GET["id"]);

// Get the header Content-type.
header('Cache-Control: no-cache, must-revalidate');
//header('Expires: Mon, 26 Jul 1997 05:00:00 GMT'.);
header('Content-type: application/json; charset=utf-8');

// First create the query to pull our data we need.
if (isset($queryType)) {
	if (isset($action) && ($action == "d" || $action == "del" || $action == "delete")) {
		// We have a delete request
		$sql = "DELETE FROM ".$queryType;
		if (isset($id) && $id>0) {
			$sql = $sql." WHERE id = ".$id;
		}
		// Now run our deelte query with the database.
		$result = mysql_query($sql);
		$json["success"] = $result;
	} else if (isset($action) && 
		($action == "u" || $action == "a" || $action == "s" || $action == "i" ||
		$action == "update" || $action == "add" || $action == "save" || $action == "insert")) {
		// First, setup a failed success
		$success = FALSE;
		// We have an add/update request
		$postJson = json_decode(file_get_contents("php://input"), true);
		if ($postJson) {
			// Now check to see if this record exists.
			if (isset($postJson["id"])) {
				$shouldInsert = FALSE;
				$sql = "SELECT * FROM ".$queryType." WHERE id = ".$postJson["id"];
				$results = mysql_query($sql);
				// Verify that we have results to display...
				if ($results) {
					while ($row = mysql_fetch_assoc($results)) {
						if ($row["id"]==$postJson["id"]) {
							$shouldInsert = TRUE;
						}
					}
					// Clear up the DB of results
					mysql_free_result($results);
				}
				// If we have a row, try to update it...
				if ($shouldInsert) {					
					$sql = "UPDATE ".$queryType;
					$keys = array_keys($postJson);
					$count = 0;
					foreach($keys as &$key) {
						if ($key!="id") {
							if ($count==0) {
								$sql .= " SET ".$key."='".$postJson[$key]."'";							
							} else {
								$sql .= ", ".$key."='".$postJson[$key]."'";
							}
							$count++;
						}
					}
					$sql .= " WHERE id = ".$postJson["id"];
					// Now execute the sql
					$result = mysql_query($sql);
					$success = $result;
				}
			}
			// If we have not updated a record, aka $json["success"] == TRUE,
			// add the data as a new record.
			if (!$success && !$shouldInsert) {
				$sql = "INSERT INTO ".$queryType;
				$keys = array_keys($postJson);
				$count = 0;
				foreach($keys as &$key) {
					if ($key!="id") {
						if ($count==0) {
							$sql .= " (".$key;
						} else {
							$sql .= ", ".$key;
						}
						$count++;
					}
				}
				$sql .= ") VALUES";
				$count = 0;
				foreach($keys as &$key) {
					if ($key!="id") {
						if ($count==0) {
							$sql .= " ('".$postJson[$key]."'";
						} else {
							$sql .= ", '".$postJson[$key]."'";
						}
						$count++;
					}
				}
				$sql .= ")";
				// Now execute the sql
				$result = mysql_query($sql);
				$success = $result;
			}	
		}
		$json["success"] = $success;
	} else {
		// An action was not sent, so we assume the user wants to select/get data
		$sql = "SELECT * FROM ".$queryType;
		if (isset($id) && $id>0) {
			$sql = $sql." WHERE id = ".$id;
		}
		// Now query the database for our data.
		$results = mysql_query($sql);
		// Verify that we have results to display...
		if ($results) {
			$count = 0;
			// Loop through all the results and display them in json format
			while ($row = mysql_fetch_assoc($results)) {
				$json[$count++] = $row;
			}
			// Clear up the DB of results
			mysql_free_result($results);
		}
	}
}

// Create a response object to return to the client.
if (isset($json)) {
	$response["results"] = $json;
//	if (isset($sql) && $sql!="") $response["sql"] = $sql;
}
//if (isset($queryType) && $queryType!="") $response["table"] = $queryType;
//if (isset($id) && $id!="") $response["id"] = $id;

// Now, actually return the response object
if (isset($response)) {
	echo json_encode($response);
}

// Don't forget to close our DB connections
mysql_close($con);

echo "\r\n";

?>