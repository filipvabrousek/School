<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Formulář</title>
</head>

<body>

<ul>
	<li><a href="filip.php?sekce=hlavnistrana">hlavni strana</a></li>	
	<li><a href="filip.php?sekce=formular">formular</a></li>	
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
        
         $nameerr = "";  $surnameerr = "";  $passworderr = ""; $emailerr = ""; $phoneerr = ""; $gendererr = ""; $termserr = ""; 
        
        
		$jmeno = $_REQUEST["jmeno"];
		if ($jmeno==""){
			print("NEBYLO VYPLNENO JMENO..."."<br>");
            $nameerr = "NEBYLO VYPLNĚNO JMÉNO";
		}
		
		$surname = $_REQUEST["surname"];
		if ($surname==""){
			print("NEBYLO VYPLNENO PRIJIMENI..."."<br>");
            $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
		}
		
		$password = $_REQUEST["password"];
		if ($password==""){
			print("NEBYLO VYPLNENO HESLO"."<br>");
            $passworderr = "NEBYLO VYPLNĚNO HESLO";
		}
		
		
		
		$email = $_REQUEST["email"];
		if ($email==""){
			print("NEBYL VYPLNEN EMAIL"."<br>");
             $emailerr = "NEBYLO VYPLNĚN EMAIL";
		}
		
		$phone = $_REQUEST["phone"];
		if ($phone==""){
			print("NEBYLO VYPLNENO TELEFONNÍ ČÍSLO"."<br>");
             $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
		}
		
        $gender = $_REQUEST["gender"];
		if ($gender==""){
			print("NEBYLO VYPLNENO POHLAVÍ");
             $gendererr = "NEBYLO VYPLNĚNO POHLAVÍ";
		}
		
		
        $terms = $_REQUEST["terms"];
		if ($terms==""){
			print("MUSÍTE SOUHLASIT S PODMÍNKAMI");
             $termserr = "MUSÍTE SOUHLASIT S PODMÍNKAMI";
		}
		
	}
	
	?>
	<h1>Formular</h1>
	
	<form action="filip.php" method="get">
	<label for="jmeno">Jméno:* </label><input type="text" name="jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>">
        <span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $nameerr; }?></span><br>
	<label for="surname">Příjmení: </label>
   
    <input type="text" name="surname" value="<?php  if (isset($surname)){print($surname);}?>">
    <span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $surnameerr; }?></span><br>
        
    <label for="password">Password:* </label><input type="password" name="password" value="<?php if (isset($password)){print($password);}?>">
    <span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $passworderr; }?></span><br>
        
        
        
			<label for="email">Email:* </label><input type="email" name="email" value="<?php if (isset($email)){print($email);}?>"><span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $emailerr; }?></span><br>
        
			<label for="gender">Pohlaví:* </label><input type="text" name="gender" value="<?php if (isset($gender)){print($gender);}?>"><span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $gendererr; }?></span><br>
        
        <!--if (isset($_REQUEST["odeslat"]))-->
		<label for="phone">Telefon:* </label><input type="text" name="phone" value="<?php if (isset($phone)){print($phone);}?>"><span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $phoneerr; }?></span> <!--<br> --->
		
		<!---  <input type="radio" checked="checked" name="gender"> --->
		<span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $gendererr; }?></span><br>
		<label for="select">Select:</label>
		
		<select name = "select">

		<option name = "selectv" value = "iPhone Xs">iPhone Xs</option>
		<option name = "selectv" value = "iPhone Xs Max">iPhone Xs Max</option>
		<option name = "selectv" value = "iPhone Xr">iPhone Xr</option>
		
		</select>
		<br>
       
		<!--
Jméno, prijimeni, email
heslo, telefon, pohlavi

-->
	<label for = "radio">Man</label>
	<input type="radio" name = "radio" checked = "checked">	
		</label>
	
	<label for = "radio">Woman</label>
	<input type="radio" name = "radio">	
		</label>
	
	<br>
    
    
     <label for = "terms">Souhlasím s podmínkami užití.</label>
		<input type = "checkbox" name = "terms" value = "<?php if (isset($terms)){print($terms);}?>">
    <span style="color: red"> <?php if (isset($_REQUEST["odeslat"])){ print $termserr; }?></span> <!--<br> --->
        <br>
    
	<input type="submit" name="odeslat" value="Odešli data">
		
	<input type="hidden" name="sekce" value="formular">
	</form>
	
	<?php
}
	

	
?>
	
</body>
</html>
