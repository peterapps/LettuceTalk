<?php
	session_start();
	include './includes.php';
	if (isset($_SESSION['username'])){
		//The members column of the table chat is like: peter!#, vinay!#, zach!#
		$chat_id = $_POST['chat'];
		$conn = dbConn();
		$sql = 'SELECT message, timestamp, user FROM messages WHERE chat_id=' . $chat_id . ' ORDER BY timestamp ASC';
		$result = $conn->query($sql);
		$arr = [];
		while($row = $result->fetch_assoc()){
			$txt = $row['message'];
			$txt = preg_replace('/\b(?:(http(s?):\/\/)|(?=www\.))(\S+)/is','<a href="http$2://$3" target="_blank">$1$3</a>',$txt); 
			$a = array('text' => $txt, 'from' => $row['user']);
			$a['fullname'] = $conn->query('SELECT fullname FROM accounts WHERE username="' . $row['user'] . '"')->fetch_assoc()['fullname'];
			$a['time'] = clock($row['timestamp']);
			array_push($arr, $a);
		}
		echo json_encode($arr);
	} else {
		echo 'false';
	}
?>