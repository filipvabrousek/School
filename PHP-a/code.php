<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dokument bez názvu</title>
</head>

<body>
<ul>
<li>
<a href = "index.php?sekce=hlavnistrana">Hlavni strana</a>
<a href = "index.php?sekce=formular">Formular</a>
</li>	
	
</ul>




<?php

$sekce = "hlavnistrana";
		
if (isset($_REQUEST["sekce"])){ // fiedl of values with index
	$sekce = $_REQUEST["sekce"];	
}

	
if ($sekce=="hlavnistrana"){
	print("<h1>Uvodni strana</h1>");
}

if($sekce=="formular"){
	if (isset($_REQUEST["send"])){
	print("NAME: ".$_REQUEST["myname"]."<br>");
	}
	
	
	?>
	<h1>Formular</h1>
	
	<form action = "index.php" method = "get">
	<input type="text" name="myname">
	<input type="submit" name="send" value="Send data">
	<input type="hidden" name="sekce" value="formular">
	</form>
	
	
	
	
	<?php
}
	
	
	
	
	
	
	
	
	
	
	/*
	print("Hello today is: ".date("j. m. Y G: i: s"));	
	//header("Refresh:0");
	
	$number = 2;
	
	print(" Number is ".$number);
	
	if (date("l") == "Friday"){
		print(" Finally!");
		
		if (date("G") == "14" && date("G.i") < "06") {
		print(" It is not yet 14:05");
		
	}
		
	}
	
	for ($i = 0; $i < 100; $i++){
		print($i."<br>");
		
	}
	
		while($i < 100){
		
		
	}
	
	*/
	
	
	
// 10:59 - begin
?>


</body>
</html>