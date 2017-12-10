<?php
	session_start();
	include './includes.php';
	if (isset($_SESSION['username'])){
		$username = $_SESSION['username'];
		$members = json_decode($_POST['members'], true);
		array_push($members, $username);
		$name = $_POST['name'];
		$t = time();
		$conn = dbConn();
		$id = $conn->query('SELECT ID from chat')->num_rows;
		$conn->query('INSERT INTO chat VALUES(' .
			$id . ', "' . implode('!#, ', $members) . '!#", "' . $t . '", "' . $name . '")');
		$conn->query('INSERT INTO messages VALUES(' . $id . ', "Created chat", "' . $t . '", "' . $username . '")');
		if (!(array_search('BotRoccoli', $members) === FALSE)){
			//BotRoccoli is in the chat
			$conn->query('INSERT INTO messages VALUES(' . $id . ', "To learn how to use BotRoccoli, type \"!help\"", "'
				. $t . '", "BotRoccoli")');
		}
		echo 'true';
	} else {
		echo 'false';
	}
?>