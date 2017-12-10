<?php
	session_start();
	include './helpers/includes.php';
	if (isset($_SESSION['username'])){
		redirect('/account.php');
	}
	$err = '';
	if (isset($_POST['reg-username']) && isset($_POST['reg-password']) && isset($_POST['fullname'])){
		//Try to register
		$username = $_POST['reg-username'];
		$password = $_POST['reg-password'];
		$fullname = $_POST['fullname'];
		if (strlen($username) == 0){
			$err = 'You must enter a username.';
		}
		elseif (strlen($password) == 0){
			$err = 'You must enter a password.';
		}
		elseif (strlen($fullname) == 0){
			$err = 'You must enter your name.';
		}
		//Good! They entered in all the inputs
		else {
			$conn = dbConn();
			$result = $conn->query('SELECT username FROM accounts WHERE username="' . $username . '")');
			if ($result->num_rows > 0){
				$err = 'That username is taken.';
			}
			//Good! The username isn't taken
			else {
				$hash = password_hash($password, PASSWORD_DEFAULT);
				$sql = 'INSERT INTO accounts (username, password, fullname, logins)' .
					'VALUES ("' . $username . '", "' . $hash . '", "' . $fullname . '", 1)';
				if ($conn->query($sql) === TRUE){
					//Successfully registered!
					$_SESSION['username'] = $username;
					redirect('/index.php');
				} else {
					$err = 'There was an error registering with "' . $sql . '": ' . $conn->error;
				}
			}
		}
	}
	if (isset($_POST['log-username']) && isset($_POST['log-password'])){
		//Try to login
		$username = $_POST['log-username'];
		$password = $_POST['log-password'];
		if (strlen($username) == 0){
			$err = 'You must enter a username.';
		}
		elseif (strlen($password) == 0){
			$err = 'You must enter a password.';
		}
		else {
			$conn = dbConn();
			$result = $conn->query('SELECT password, logins FROM accounts WHERE username="' . $username . '"');
			if ($result->num_rows == 0){
				$err = 'The username is incorrect';
			}
			else {
				$row = $result->fetch_assoc();
				if (password_verify($password, $row['password'])){
					$logins = $row['logins'] + 1;
					$conn->query('UPDATE accounts SET logins=' . $logins . ' WHERE username="' . $username . '"');
					$_SESSION['username'] = $username;
					redirect('/index.php');
				} else {
					$err = 'The password is incorrect.';
				}
			}
		}
	}
?>
<!DOCTYPE html>
<html>
<head>
	<title>Login | LettuceTalk</title>
	<?php meta(); ?>
</head>
<body>
	<?php showHeader(); ?>
	<?php
		if (strlen($err) > 0){
			echo '<p class="error">' . $err . '</p>';
		}
	?>
	<div class="centered">
		<table id="loginTable">
			<tbody>
				<tr>
					<td>
						<form action="" method="post">
							<h2>Login</h2>
							<div class="group">
								<input type="text" id="log-username" name="log-username" required="required" <?php
									if(isset($_POST['username'])) echo 'value="' . $_POST['username'] . '"';
								?>/>
								<label for="log-username">Username</label>
								<div class="bar"></div>
							</div>
							<div class="group">
								<input type="password" id="log-password" name="log-password" required="required" <?php
									if(isset($_POST['password'])) echo 'value="' . $_POST['password'] . '"';
								?>/>
								<label for="log-password">Password</label>
								<div class="bar"></div>
							</div>
							<input type="submit" class="submit" value="Log in" />
						</form>
					</td>
					<td>
						<form action="" method="post">
							<h2>Register</h2>
							<div class="group">
								<input type="text" id="reg-username" name="reg-username" required="required" <?php
									if(isset($_POST['username'])) echo 'value="' . $_POST['username'] . '"';
								?>/>
								<label for="reg-username">Username</label>
								<div class="bar"></div>
							</div>
							<div class="group">
								<input type="password" id="reg-password" name="reg-password" required="required" <?php
									if(isset($_POST['password'])) echo 'value="' . $_POST['password'] . '"';
								?>/>
								<label for="reg-password">Password</label>
								<div class="bar"></div>
							</div>
							<div class="group">
								<input type="text" id="fullname" name="fullname" required="required" <?php
									if(isset($_POST['fullname'])) echo 'value="' . $_POST['fullname'] . '"';
								?>/>
								<label for="fullname">Full name</label>
								<div class="bar"></div>
							</div>
							<input type="submit" class="submit" value="Register" />
						</form>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>