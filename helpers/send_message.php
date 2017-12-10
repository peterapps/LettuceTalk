<?php
	session_start();
	include './includes.php';
	function escape($str){
		return str_replace('"', '\\"', $str);
	}
	if (isset($_SESSION['username']) && strlen($_POST['text']) > 0){
		$username = $_SESSION['username'];
		$chat_id = $_POST['chat_id'];
		$txt = $_POST['text'];
		$t = time();
		$conn = dbConn();
		//See if BotRoccoli has a response
		$botReply = '';
		$log = [];
		if ($conn->query('SELECT id FROM chat WHERE ID=' . $chat_id . ' AND members LIKE "%BotRoccoli!#%"')->num_rows > 0){
			//BotRoccoli is in the chat
			$fullname = $conn->query('SELECT fullname FROM accounts WHERE username="' . $username . '"')->fetch_assoc()['fullname'];
			$userResults = $conn->query('SELECT message FROM messages WHERE user="' . $username . '" AND chat_id=' .
				$chat_id . ' ORDER BY timestamp DESC LIMIT 1');
			$lastFromUser = '';
			if ($userResults->num_rows > 0) $lastFromUser = $userResults->fetch_assoc()['message'];
			$botResults = $conn->query('SELECT message FROM messages WHERE user="BotRoccoli" AND chat_id=' .
				$chat_id . ' ORDER BY timestamp DESC LIMIT 1');
			$lastFromBot = '';
			if ($botResults->num_rows > 0) $lastFromBot = $botResults->fetch_assoc()['message'];
			$cmd = './chatbot.py "' . escape($username) . '" "' . escape($fullname)
				. '" "' . escape($txt) . '" "' . escape($lastFromUser) . '" "' . escape($lastFromBot) . '"';
			$botReply = shell_exec($cmd);
			array_push($log, $cmd);
			array_push($log, $botReply);
		}
		//Enter user's response
		$conn->query('INSERT INTO messages VALUES('
			. $chat_id . ', "' . $txt . '", "' . $t . '", "' . $username . '")');
		$conn->query('UPDATE chat SET latest="' . $t . '" WHERE ID=' . $chat_id);
		//Now enter in BotRoccoli's reply
		if (strlen($botReply) > 0){
			$sql = 'INSERT INTO messages VALUES(' . $chat_id . ', "' . $botReply . '", "' . time() . '", "BotRoccoli")';
			$conn->query($sql);
			array_push($log, $sql);
			file_put_contents('./botLog.txt', implode('\r\n', $log));
		}
		echo 'true';
	} else {
		echo 'false';
	}
?>