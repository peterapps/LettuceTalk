<?php
	date_default_timezone_set("America/New_York");
	function clock($t){
		return date('g:i A', $t);
	}
	function redirect($str){
		header('Location: ' . $str);
		die();
	}
	function dbConn(){
		$conn = new mysqli('127.0.0.1', 'root', 'Peter8', 'lettuce');
		if ($conn->connect_error){
			die('Connection failed: ' . $conn->connect_error);
		} else return $conn;
	}
	function meta(){
		readfile('./helpers/meta.php');
	}
	function showHeader(){
		include('./helpers/header.php');
	}
?>