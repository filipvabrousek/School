<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dokument bez názvu</title>
</head>

<body>

/*
- ziskat jmeno souboru	
*/
<?php
	
	$polevky = array("polevka1", "polevka2");
	$polevkynazvy = array("super polevka 1", "super polevka 2");
	$polevkyceny = array("59", "99");
	$jidla = array("jidlo1", "jidlo2", "jidlo3", "jidlo4");
	$jidlapopisy = array("popis super jidla 1", "popis super jidla 2","popis super jidla 3","popis super jidla 4");
	$jidlaceny = array("259", "399", "299", "563");	
	
	
	if (isset($_REQUEST["odeslat"])){
		$cenajidel = 0;
		$pocetjidel = 0;
		$prehledjidel = "";
		$pocetosob = $_REQUEST["pocetosob"];
		if($pocetosob<1){
			print("Sorry");
		}
		else{
			for($i=0; $i<count($jidla);$i++){
				$jidlo = "jidla".$i;
				$prehledjidel = $prehledjidel."<p>".$jidla[$i].": ".$jidlapopisy[$i]."(".$jidlaceny[$i]."&nbsp;Kč) - ".$_REQUEST[$jidlo]."</p>";
				$cenajidel = $cenajidel + ($jidlaceny[$i]*$_REQUEST[$jidlo]);
				$pocetjidel = $pocetjidel + $_REQUEST[$jidlo];
			}
			if ($pocetosob == $pocetjidel){
				print($prehledjidel);
				print("<h1>CELKOVA CENA JE ASI: ".$cenajidel."</h1>");
			}else{
				print("Nesedi pocet osob...");
			}
		}

	}
	
?>
	
<form action="degust.php" method="get">
<fieldset>
<legend>Pocet osob:</legend>
<input type="number" name="pocetosob" value="0">	
</fieldset>

<fieldset>
 <legend>Polévky:</legend>	
<select name="polevky">
	<?php
	for($i=0; $i<count($polevky);$i++){
		print("<option value=\"".$polevky[$i]."\">".$polevkynazvy[$i]." (".$polevkyceny[$i]."&nbsp;Kč)</option>");
	}
	?>
</select>
</fieldset>

<fieldset>
 <legend>Jidla:</legend>	
	<?php
	for($i=0; $i<count($jidla);$i++){
		print("<p><input type=\"number\" name=\"jidla".$i."\" value=\"0\"> ".$jidla[$i]." (".$jidlaceny[$i]."&nbsp;Kč)</p>");
	}
	?>
</select>
</fieldset>


<input type="submit" name="odeslat">
	
</form>	
</body>
</html>
