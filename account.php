<?php
	session_start();
	include './helpers/includes.php';
	if (!isset($_SESSION['username'])){
		redirect('/login.php');
	}
	$username = $_SESSION['username'];
	$conn = dbConn();
	$result = $conn->query('SELECT fullname, logins FROM accounts WHERE username="' . $username . '"');
	$row = $result->fetch_assoc();
?>
<!DOCTYPE html>
<html>
<head>
	<title>My Account | LettuceTalk</title>
	<?php meta(); ?>
</head>
<body>
	<?php showHeader(); ?>
	<h2>Welcome, <?php echo $row['fullname']; ?></h2>
	<p>You have logged in <?php echo $row['logins']; ?> times.</p>
</body>
</html>