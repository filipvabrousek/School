<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dokument bez názvu</title>
</head>
	<style> 
input[type=text] {
    width: 10%;
    padding: 12px 20px;
    margin: 8px 0;
    box-sizing: border-box;
    border: none;
    background-color: #3CBC8D;
    color: white;
}
</style>
</style>

<body>

<ul>
	<li><a href="index.php?sekce=hlavnistrana">Hlavní strana</a></li>	
	<li><a href="index.php?sekce=formular">Formulář</a></li>	
</ul>	
<br>
<?php

$sekce = "hlavnistrana";

if (isset($_REQUEST["sekce"])){
	$sekce = $_REQUEST["sekce"];		
}
	
if($sekce=="hlavnistrana"){
	print("<h1>Uvodní strana</h1>");
	
}


if($sekce=="formular"){
	
	if (isset($_REQUEST["odeslat"])){
			
			$chyby = ""; $jmenoErr = ""; $prijmeniErr = ""; $emailErr = ""; $podminkyErr = ""; $pohlaviErr = "";
			$chybnapole = array(); //konstruktor pole
		    $jmeno = trim($_REQUEST["jmeno"]);
		    $povoleneznaky = "qwertzuiopasdfghjklyxcvbnm";
		
			$jmeno = $_REQUEST["jmeno"];
		    print("Jméno: ".$_REQUEST["jmeno"]."<br>");
			if ($jmeno==""){
		
				$jmenoErr = "*Toto pole je povinné";
				$chyby = $chyby."<p>Nebylo korektne vyplneno jmeno!</p>";
				$chybnapole[] = "jmeno"; //do indexu nic nedame, automaticky se tam jako prvni priradi jmeno a dalsi prvky za to
			}else{
				if(strlen($jmeno)>1){
					for($i=0;$i<strlen($jmeno);$i++){
						if(strpos($povoleneznaky, $jmeno[$i]) === false)
						print("NEPOVOLENY ZNAK".$jmeno[$i]."<br>");
						}
					}
				else{
					$chyby = $chyby."<p>Jmeno musi mit delku alespon 2 znaky!</p>";
				    $chybnapole[] = "jmeno";
				}
			}
			$prijmeni = $_REQUEST["prijmeni"];
		    print("Příjmení: ".$_REQUEST["prijmeni"]."<br>");
		    if ($prijmeni==""){
				$prijmeniErr = "*Toto pole je povinné";
			    $chyby = $chyby."<p>Nebylo korektne vyplneno prijmeni!</p>";
				$chybnapole[] = "prijmeni";
		    }
			$email = $_REQUEST["email"];
		    print("Email: ".$_REQUEST["email"]."<br>");
			if ($email==""){
				$emailErr = "*Toto pole je povinné";
				$chyby = $chyby."<p>Nebylo korektne vyplnen email!</p>";
				$chybnapole[] = "email";
			}
		if (isset($_REQUEST["gender"])){
			$pohlavi = $_REQUEST["gender"];
		    print("Pohlaví: ".$_REQUEST["gender"]."<br>");
			if ($pohlavi==""){
				$pohlaviErr = "*Toto pole je povinné";
				$chyby = $chyby."<p>Musíte vyplnit pohlaví!</p>";
				$chybnapole[] = "gender";
		}
		    
			}
		if (isset($_REQUEST["podminky"])){
			$podminky = $_REQUEST["podminky"];
			if ($podminky==""){
				$podminkyErr = "*Toto pole je povinné";
				$chyby = $chyby."<p>Musíte souhlasit se smluvními podmínkami!</p>";
				$chybnapole[] = "podminky";
			}
		}
			if(!$chyby == "");{
			   print("<h2>Byly nalezeny tyto chyby: </h2>");
			   print($chyby);
		    }
			
			for($i = 0; $i < count($chybnapole); $i++){
				//print($chybnapole[$i].","); //vypise nam to chyby/nevyplnene pole formulare za sebou (vypis pole)
			}
		 }
	}
	
	?>
	<h1>Formulář</h1>
	
	<form action="index.php" method="get">
	<!--JMENO (RESENI, KDYZ NENI JMENO ZADANO viz nahore, radek 38-41)-->
	<div
	<?php
		//kdyz je name daneho elementu v $chybnapole pritomen, tak jej oznac
		if (isset($_REQUEST["odeslat"]))
		{
			if(in_array("jmeno", $chybnapole)){
			print("class=\"warning\"");
		    }
		}
		
	?>
	>	
	<label for="jmeno">Jméno: </label><input type="text" name="jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>">
	<span class="warning" style="color: #CB1A1D"><?php if (isset($_REQUEST["odeslat"])){print $jmenoErr;}?></span><br>
	</div>
	<!--PRIJMENI (RESENI, KDYZ NENI PRIJMENI ZADANO viz nahore, radek 45-48)-->	
	<div
	<?php
		//kdyz je name daneho elementu v $chybnapole pritomen, tak jej oznac
		if (isset($_REQUEST["odeslat"]))
		{
			if(in_array("prijmeni", $chybnapole)){
			print("class=\"warning\"");
		    }
		}
		
	?>
	>
	<label for="prijmeni">Příjmení: </label><input type="text" name="prijmeni" value="<?php  if (isset($prijmeni)){print($prijmeni);}?>">
	<span class="warning" style="color: #CB1A1D"><?php if (isset($_REQUEST["odeslat"])){print $prijmeniErr;}?></span><br>
	</div>
	<!--EMAIL (RESENI, KDYZ NENI EMAIL ZADAN viz nahore radek 52-55)-->	
	<div
	<?php
		//kdyz je name daneho elementu v $chybnapole pritomen, tak jej oznac
		if (isset($_REQUEST["odeslat"]))
		{
			if(in_array("email", $chybnapole)){//MUSIM DORESIT, VYHAZUJE CHYBU
			print("class=\"warning\"");
		    }
		}
		
	?>
	>
	<label for="email">Email: </label><input type="text" name="email" placeholder="example@gmail.com" value="<?php  if (isset($email)){print($email);}?>"/>
	<span class="warning" style="color: #CB1A1D"><?php if (isset($_REQUEST["odeslat"])){print $emailErr;}?></span><br>
	</div>
	<!--VYBER POHLAVI-->	
		
	<label for="pohlavi">zadejte své pohlaví: </label><br>
	<input type="radio" name="gender" value="muž">Muž<br>
	<input type="radio" name="gender" value="žena">Žena<br>
	<input type="radio" name="gender" value="neuvedeno">Jiné
	<span class="warning" style="color: #CB1A1D"><?php if (isset($_REQUEST["odeslat"])){print $pohlaviErr;}?></span>	
	<br>
	<!--VYBER POLOZEK-->
<p>Vyberte jednu dárkovou položku registrace:</p>
	<label for="polozka1">klíčenka: </label><input type="checkbox" name="polozka" value="klicenka"><br>
	<label for="polozka2">hrnek: </label><input type="checkbox" name="polozka" value="hrnek"><br>
	<label for="polozka3">náramek: </label><input type="checkbox" name="polozka" value="naramek"><br>
	<!--SMLUVNI PODMINKY - POTVRZENI-->	
	<label for="podminky">Souhlasím se smluvními podmínkami pro registraci </label><input type="checkbox" name="podminky" value="souhlas">
	<span class="warning" style="color: #AC0B0D"><?php if (isset($_REQUEST["odeslat"])){print $podminkyErr;}?></span><br><br>
		
	<input type="submit" name="odeslat" value="Odeslat data">	
	<input type="hidden" name="sekce" value="formular">
	</form>
	
	<?php
	
	
?>
	
</body>
</html>
