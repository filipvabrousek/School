<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dokument bez názvu</title>
</head>

<body>

<ul>
	<li><a href="index.php?sekce=hlavnistrana">hlavni strana</a></li>	
	<li><a href="index.php?sekce=formular">formular</a></li>	
</ul>	

<?php

$sekce = "hlavnistrana";

if (isset($_REQUEST["sekce"])){
	$sekce = $_REQUEST["sekce"];		
}
	
if($sekce=="hlavnistrana"){
	print("<h1>Uvodni strana</h1>");
	
}


if($sekce=="formular"){
	
	if (isset($_REQUEST["odeslat"])){//prisla data z formulare? Byl odeslan?
		$jmeno = $_REQUEST["jmeno"];
		if ($jmeno==""){
			print("NEBYLO VYPLNENO JMENO..."."<br>");
		}
		
		$surname = $_REQUEST["surname"];
		if ($surname==""){
			print("NEBYLO VYPLNENO PRIJIMENI..."."<br>");
		}
		
		$password = $_REQUEST["password"];
		if ($password==""){
			print("NEBYLO NALEZENO HESLO"."<br>");
		}
		
		
		
		$email = $_REQUEST["email"];
		if ($email==""){
			print("NEBYL VYPLNEN EMAIL"."<br>");
		}
		
		$phone = $_REQUEST["phone"];
		if ($phone==""){
			print("NEBYLO VYPLNENO TELEFONNÍ ČÍSLO"."<br>");
		}
		
			$gender = $_REQUEST["gender"];
		if ($gender==""){
			print("NEBYLO VYPLNENO POHLAVÍ");
		}
		
		
				$selectv = $_REQUEST["selectv"];
		if ($selectv==""){
			print("je potřeba vybrat minimálně 1 produkt.");
		}
		
		
	}
	
	?>
	<h1>Formular</h1>
	
	<form action="index.php" method="get">
	<label for="jmeno">Jméno:* </label><input type="text" name="jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>"><br>
	<label for="surname">Příjmení: </label><input type="text" name="surname" value="<?php  if (isset($surname)){print($surname);}?>"><br>
			
			<label for="password">Password:* </label><input type="password" name="password" value="<?php  if (isset($password)){print($password);}?>"><br>
			<label for="email">Email:* </label><input type="email" name="email" value="<?php  if (isset($email)){print($email);}?>"><br>
			<label for="gender">Pohlaví:* </label><input type="text" name="gender" value="<?php  if (isset($gender)){print($gender);}?>"><br>
		<label for="phone">Telefon:* </label><input type="text" name="phone" value="<?php  if (isset($phone)){print($phone);}?>"><br> 
		
		  <input type="radio" checked="checked" name="gender">
		
		<label for="select">Select:</label>
		
		<select name = "select">
			<option name = "selectv" value = "<?php  if (isset($selectv)){print($selectv);}?>">Select at least one element.</option>
		<option name = "selectv" value = "iPhone Xs">iPhone Xs</option>
		<option name = "selectv" value = "iPhone Xs Max">iPhone Xs Max</option>
		<option name = "selectv" value = "iPhone Xr">iPhone Xr</option>
		
		</select>
		<br>
		<checkbox  name = "check" value = "Souhlasím s podmínkami užití."></checkbox>
		<!--
Jméno, prijimeni, email
heslo, telefon, pohlavi

-->
	<label for = "radio">Man</label>
	<input type="radio" name = "radio">	
		</label>
	
	<label for = "radio">Woman</label>
	<input type="radio" name = "radio">	
		</label>
	
	<br>
	<input type="submit" name="odeslat" value="Odešli data">
		
	<input type="hidden" name="sekce" value="formular">
	</form>
	
	<?php
}
	

	
?>
	
</body>
</html>
