<div class="header">
	<h1>
		<a href="/">
			<img height="32" src="/img/icon.png" />
			LettuceTalk
		</a>
	</h1>
	<?php
		if (isset($_SESSION['username'])){
			echo '<div class="logout"><a href="/logout.php"><button>Log out</button></a></div>';
		}
	?>
</div>