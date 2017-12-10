<?php
	session_start();
	include './helpers/includes.php';
	if (!isset($_SESSION['username'])){
		redirect('/login.php');
	}
	$username = $_SESSION['username'];
	$conn = dbConn();
	$row = $conn->query('SELECT fullname FROM accounts WHERE username="' . $username . '"')->fetch_assoc();
?>
<!DOCTYPE html>
<html>
<head>
	<title>Home | LettuceTalk</title>
	<?php meta(); ?>
	<link rel="stylesheet" type="text/css" href="/css/index.css" />
	<?php
		echo '<script type="text/javascript">var username = "' . $username . '";</script>';
	?>
	<script type="text/javascript" src="/js/chat.js"></script>
</head>
<body>
	<div class="everything">
		<?php showHeader(); ?>
		<h2>Welcome, <a href="/account.php"><?php echo $row['fullname']; ?></a></h2>
	</div>
	<table id="table">
		<thead>
			<tr>
				<th style="width:25%;">
					<button id="newchat">New chat</button>&nbsp;&nbsp;
					My Chats
				</th>
				<th style="width:75%;" id="members">
					<button id="addmember" onclick="addMember()">Add member</button>&nbsp;&nbsp;
					Chat members
				</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<table class="chat">
						<tbody>
							<!--This is where the list of your chats go-->
						</tbody>
					</table>
				</td>
				<td>
					<table class="messages">
						<tr>
							<td>
								<table id="msgbody">
									<tbody id="msgbodybody">
										<!--This is where your messages from the selected chat go-->
									</tbody>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<div id="msgfoot">
									<form id="send" action="" method="post">
										<input type="text" id="message" placeholder="Type a message..." name="message" />
										<input type="submit" value="Send" class="send"/>
									</form>
								</div>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
</body>
</html>