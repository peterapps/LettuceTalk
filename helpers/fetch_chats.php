<?php
	session_start();
	include './includes.php';
	if (isset($_SESSION['username'])){
		//The members column of the table chat is like: peter!#, vinay!#, zach!#
		$username = $_SESSION['username'];
		$conn = dbConn();
		$result = $conn->query('SELECT ID, name, members, latest FROM chat WHERE members LIKE "%' . $username . '!#%" ORDER BY latest DESC');
		$arr = [];
		while($row = $result->fetch_assoc()){
			$id = $row['ID'];
			$a = array('id' => $id, 'name' => $row['name']);
			$raw = $row['members'];
			$raw = substr($raw, 0, -2);
			$usernames = explode("!#, ", $raw);
			$members = [];
			foreach($usernames as $user){
				if ($user != $username){
					$fullname = $conn->query('SELECT fullname FROM accounts WHERE username="' . $user . '"')->fetch_assoc()['fullname'];
					array_push($members, $fullname);
				}
			}
			$a['members'] = $members;
			$latest = $conn->query('SELECT user, message FROM messages WHERE chat_id=' . $id . ' ORDER BY timestamp DESC LIMIT 1')->fetch_assoc();
			$from = $latest['user'];
			if ($username == $from) $from = 'Me';
			else $from = $conn->query('SELECT fullname FROM accounts WHERE username="' . $from . '"')->fetch_assoc()['fullname'];
			$txt = $latest['message'];
			if (strlen($txt) > 25) $txt = substr($txt, 0, 25) . '...';
			$a['latest'] = array(
				'from' => $from,
				'text' => $txt,
				'time' => clock($row['latest'])
			);
			array_push($arr, $a);
		}
		echo json_encode($arr);
	} else {
		echo 'false';
	}
?>