<?php
	session_start();
	include './helpers/includes.php';
	session_unset();
	redirect('/login.php');
?>