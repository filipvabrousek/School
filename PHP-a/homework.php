<?php 
//VYPSAT NAHORU JAKY JE POCET ZAMESTNANCU
//require("library.php");

$sekce = "hlavnistrana";
if (isset($_REQUEST["sekce"])){
	$sekce = $_REQUEST["sekce"];		
}

switch ($sekce):
    case "hlavnistrana":
        $nazevstranky = "hlavnistrana";
        break;
    case "formular":
        $nazevstranky = "formular";
        break;
    case "vyber-produktu":
        $nazevstranky = "vyber si svuj produkt";
        break;
	case "zamestnanci":
        $nazevstranky = "zamestnanci";
        break;
    default:
        $nazevstranky = "hlavnistrana";
endswitch;

// vlozhlavickustranky($nazevstranky);

// substr("111222333", 0, -6)
?>

<body>

<ul>
	<li><a href="index.php?sekce=hlavnistrana">hlavni strana</a></li>	
	<li><a href="index.php?sekce=formular">formular</a></li>
	<li><a href="index.php?sekce=vyber-produktu">Vyber si svuj produkt</a></li>
	<li><a href="index.php?sekce=zamestnanci">zamestnanci</a></li>
</ul>	

<?php

if($sekce=="zamestnanci"){
	print("<h1>Zamestnanci</h1>");
	
	$filename = 'zamestnanci.csv';
	
    echo "The file $filename exists";
} else {
    echo "The file $filename does not exist";
}
	print("<br>");
	
	if (file_exists($filename)) {
		$soubor = fopen($filename, "r");
		$htmltabulka="";
		$cisloradku = 0;
		$pocetzamestnancu = 0;
	while(!feof($soubor))
		{
			$cisloradku++;
			$radek = fgets($soubor,5000);//5 000 - radek nacte max 5000 znaku
			
			if($cisloradku>=3)
			{
				
				
				if(trim($radek)<>"")
				{
					list($jmeno,$prijmeni,$titul,$email,$telefon,$fotografie,$zkratka)=	explode(";", $radek);	
					if($radek==3)//nefunguje!!!
						{
							$htmltabulka = $htmltabulka."<head><tr><th>.$jmeno</th>".$prijmeni."</th></tr><td>.$titul</td></head>"; //proc tu nemusi byt print???? print("<head>")
						}						
					else
                        {
				     $htmltabulka = $htmltabulka."<tr><td>";
                        if (trim($titul)<>""){
                            $htmltabulka = htmltabulka.$titul."&nbsp;";
                        }
                        
                        $htmltabulka = $htmltabulka."<head><tr><th>.$jmeno</th>".$prijmeni."</th></tr><td>.$telefon</td></head>"; 
                       // .$titul."&nbsp".""."</td></tr>";
							$pocetzamestnancu++;
                        
                        echo substr($telefon, 0, 3);
						}
                    
                    // klikací emaily (úkol)
                    
                    /*HDMI*/
				}
				
			}
			
			
		
	}
		
	
		if($htmltabulka<>"")
		{
		    print("Pocet zamestnancu je: ".$pocetzamestnancu);
		    print("<table border = \"1\">");
			print($htmltabulka);
			print("</table>");
		}
		
	fclose($soubor);
	
}


	
if($sekce=="hlavnistrana"){
	print("<h1>Uvodni strana</h1>");
	
}


if($sekce=="formular"){
	
	if (isset($_REQUEST["odeslat"])){//prisla data z formulare? Byl odeslan?
		$jmeno = $_REQUEST["jmeno"];
		if ($jmeno==""){
			print("NEBYLO VYPLNENO JMENO...");
		}
	}
	
	?>
	<h1>Formular</h1>
	
	<form action="index.php" method="get">
	<label for="jmeno">Jméno:* </label><input type="text" name="jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>"><br>
	<label for="prijmeni">Příjmení: </label><input type="text" name="prijmeni" value="Mikláš"><br>
	<input type="radio">	
		
	<input type="submit" name="odeslat" value="Odešli data">
		
	<input type="hidden" name="sekce" value="formular">
	</form>
	
	<?php
}
	if($sekce=="vyber-produktu"){
	
	if (isset($_REQUEST["odeslat"])){//prisla data z formulare? Byl odeslan?
		$jmeno = $_REQUEST["jmeno"];
		$prijmeni = $_REQUEST["prijmeni"];
		$email = $_REQUEST["email"];
		$heslo = $_REQUEST["heslo"];
		$telefon = $_REQUEST["telefon"];
		if ($jmeno==""){
			print("NEBYLO VYPLNENO JMENO...");
		}
	}
	
	?>
	<h1>Vyber si svůj produkt</h1>
	
	<form action="index.php" method="get">
	<label for="jmeno">Jméno: </label><input type="text" name="jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>"><br> <!--}else{print("Vypln tohle pole, jo?")-->
	<label for="prijmeni">Příjmení: </label><input type="text" name="prijmeni" value="<?php  if (isset($prijmeni)){print($prijmeni);}?>"><br>
	<label for="email">E-mail: </label><input type="email" name="email" value="<?php  if (isset($email)){print($email);}?>"><br>
	<label for="heslo">Heslo: </label><input type="password" name="heslo" value="<?php  if (isset($heslo)){print($heslo);}?>"><br>
	<label for="telefon">Telefon: </label><input type="tel" name="telefon" value="<?php  if (isset($telefon)){print($telefon);}?>"><br>
	Pohlaví:<br>
	<input type="radio" name="gender" value="zena" checked>Žena<br>
	<input type="radio" name="gender" value="muz">Muž<br>
	<input type="radio" name="gender" value="jine">Jiné<br>
	Výrobky:<br>
	<input type="radio" name="vyrobek" value="behx32" checked>Behringer x32, 44 000,-<br>
	<input type="radio" name="vyrobek" value="midasm32">Midas M32, 100 000,-<br>
	<input type="radio" name="vyrobek" value="scvi1">Soundcraft Vi1, 200 00,-<br>
		
		
	<input type="submit" name="odeslat" value="Odešli data">
		
	<input type="hidden" name="sekce" value="vyber-produktu">
	</form>
	
	<?php
}
	

	
?>
	
</body>
</html>
