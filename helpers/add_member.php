<?php
	session_start();
	include './includes.php';
	if (isset($_SESSION['username'])){
		$username = $_SESSION['username'];
		$t = time();
		$member = $_POST['member'];
		$id = $_POST['chat_id'];
		$conn = dbConn();
		$members = $conn->query('SELECT members FROM chat WHERE ID=' . $id)->fetch_assoc()['members'];
		$members .= ', ' . $member . '!#';
		$conn->query('UPDATE chat SET members="' . $members . '" WHERE ID=' . $id);
		$name = $conn->query('SELECT fullname FROM accounts WHERE username="' . $member . '"')->fetch_assoc()['fullname'];
		$conn->query('INSERT INTO messages VALUES(' . $id . ', "Added ' . $name . ' to the chat", "' . $t . '", "' . $username . '")');
		echo 'true';
	} else {
		echo 'false';
	}
?>