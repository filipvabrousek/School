<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Skoro iDes</title>
<style type ="text/css">
body{font-family:Liberation-Sans, Helvetica, Arial, sans-serif;}
*{padding: 0; margin: 0;}
/*Hlavní grid*/
body{display:grid; grid-template-columns:1fr 950px 1fr;background-color: #8a92ff;}
header{grid-column:1/4; display:grid; grid-template-columns:1fr 950px 1fr;background-color: #c2c6ff; z-index:1;}
main{grid-column:2/3;background-color:white;box-shadow: 0 0 500px 200px white; padding:1rem 6rem;}
footer{grid-column:1/4;}
/*Odkazy*/
a:link{text-decoration:none;color:black;border: none; outline:none;}
a:visited{text-decoration:none;color: #5a5a5a;border: none; outline:none;}
a:hover{text-decoration:none;color:#242424;border: none; outline:none;}
a:active{text-decoration:none;color:white;border: none; outline:none;}
/*Header*/
header h1{grid-column:1/4; background-color: #8a92ff; text-align:center;/*box-shadow: 0 0 10px 5px #505166;*/}/*nadpis noviny*/
ul{list-style:none;}
header ul{grid-column:2/3;}/*seznam kategorií v nadpisu*/
ul .kateg{display:inline-block; padding:0.5rem 1rem;}/*jednotlivé kategorie se zobrazí vedle sebe*/
/*Main*/
.kateg{text-align:right; color: #383a5d; font-style:italic;}/*obecný styl pro název kategorie (vedle jednotlivých článků)*/
h3.kateg{text-align:center; margin:2rem 1rem 2rem 1rem;}/*nadpis v případě zobraszení strany jen z dané kategorie*/
.seznamstran{text-align:center; margin:1rem;}
h4{margin:2rem; text-align:center;}/*vymoženost*/
h2{margin:2rem 0 0 0;}/*nadpis článků*/
.tlacitkouvod{text-align:center;/* background-color:#e6e7ff; box-shadow: 0 0 10px 5px #505166; */padding:0.5rem; margin:1rem;font-size:1.2rem;}
.dolnicara{margin:2rem 0 0 0;}
</style>
</head>

<body>
<header>
	<h1>Noviny</h1>
<?php
error_reporting(E_ALL); // bude křičet při problémech - zakomentovat na konec

$servername = "localhost";
$username = "root";
$password =  "";
$db	= "renome";//ke které databázi se chci připojit

// Create connection
$conn = mysqli_connect($servername, $username, $password, $db);

// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
//echo "Connected successfully";
	
mysqli_query($conn,"SET CHARACTER SET utf8");//nastaví, aby tam fungovala čeština a přepne to z cp1250
	
if(isset($_REQUEST["id"])){//tady není $ !!!
	$id = $_REQUEST["id"];// id je celkové pořadí: c celk. poř., slouží k označení nadpisu, na který se má posunout v rámci strany 
}else{																	//je to nastavené, jen když jsme předtím byli na nějakém článku
	$id = "";
}	
	

if(isset($_REQUEST["aktualnistrana"])){//aktuální strana se nastaví na něco - to je vybraná strana, na kterou se kliklo v odkazu
	$aktualnistrana = $_REQUEST["aktualnistrana"];
}else{
	$aktualnistrana = 1;//jinak je aktuální strana 1
}	//print("aktualni strana: ". $aktualnistrana);
	
$zaznamunastranu= 5;	//kolik chceme zobrazit článků na jedné straně

//******Klikání na kategorie***********//nahoře seznam kategorií
$sql = "SELECT ";
$sql = $sql."name, idccathegory ";//budu pak chtít vypsat jméno kategorie a předat její id 
$sql = $sql."FROM renome_ccathegory ";

$result = mysqli_query($conn, $sql);
	if(mysqli_num_rows($result) > 0)//přišel aspoň 1 řádek
	{
		print("<ul>");
		while($row = mysqli_fetch_assoc($result)){
			if(($row["name"])=="www.gjszlin.cz"){print("<li class=\"kateg\"><a href=\"https://www.gjszlin.cz\">".$row["name"]."</a></li>");}//při kliknutí na odkaz na stránku školy, který vypadá, že přesně tohle se stane, se to přemístí na stránku školy
			else if(($row["name"])=="Hlavní stránka"){print("<li class=\"kateg\"><a href=\"noviny.php?\">".$row["name"]."</a></li>");}
			else{//povede to na úvod - pokud se ale hlavní stránka přejmenuje, úspěšně to přestane fungovat :)
			print("<li class=\"kateg\"><a href=\"noviny.php?kategorie=".$row["idccathegory"]."\">".$row["name"]."</a></li>");}//odkazy na kategorie
		}
		print("</ul>");
	}

if(isset($_REQUEST["kategorie"])){
	$kategorie = $_REQUEST["kategorie"];
}else{
	$kategorie = "";
}

print("</header>");//ukončení hlavičky
print("<main>");

//*******TLAČÍTKO ÚVOD***
print("<a href=\"noviny.php?\"><p class=\"tlacitkouvod\">Úvod</p></a>");//jednoduše pošle na první stranu a zapomene vše, kategorie automaticky zmizí, stránka a článek taky

//***** KOLIK JE TAM ZÁZNAMŮ (celkem) ******
if($kategorie==""){//ošetřit, aby uživatel nezadal divnou kategorii?
    $sql = "SELECT ";//musí mezera
    $sql = $sql."count(idtarticle) as pocetzaznamu ";//spočítá kolik je celkem záznamů - vrátí číslo - uloží ho do sloupce pocetzaznamu
    $sql = $sql."FROM renome_tarticle ra ";
}else{
    $sql = "SELECT ";//musí mezera
	$sql = $sql."count(idtarticle) as pocetzaznamu ";//spočítá kolik je celkem záznamů - vrátí číslo - uloží ho do sloupce pocetzaznamu
	$sql = $sql."FROM renome_tarticle ra ";
	$sql = $sql."INNER JOIN renome_ccathegory rc ON rc.idccathegory = ra.idccathegory ";
	$sql = $sql."WHERE rc.idccathegory = ".$kategorie;//když zadá divnou kategorii, tak mi to nevadí, protože ji nemám v seznamu||nic se mi nezobrazí
}
	
//print($sql);// - pro jistotu tiskne sql, jestli tam není chyba
$result = mysqli_query($conn, $sql);
	
$row = mysqli_fetch_assoc($result);//asociativní pole, které má ten řádek tabulky
	
$pocetzaznamu = $row ["pocetzaznamu"];//beru hodnotu ve sloupečku počet záznamů
//***** UŽ VÍME, KOLIK JE TAM ZÁZNAMŮ ******
	
if($id==""){//když se nic nechtělo
	//****NADPIS KATEGORIE */
	if($kategorie<>""){
		$sql = "SELECT ";//musí mezera
		$sql = $sql."name, idccathegory ";
		$sql = $sql."FROM renome_ccathegory rc ";
		$sql = $sql."WHERE rc.idccathegory =  ".$kategorie;
	
		$result = mysqli_query($conn, $sql);
		if(mysqli_num_rows($result) > 0)//přišel aspoň 1 řádek - když by nepřišel, zadaná kategorie byla divná
		{
			while($row = mysqli_fetch_assoc($result)){
				print("<h3 class=\"kateg\">".$row["name"]."</h3>");
			}
		}
	}	

	//*****STRÁNKOVÁNÍ */
	//$pocetzaznamu = mysqli_num_rows($result);?? - to by spočítalo jenom počet záznamů v tom, co zrovna chceme - tedy 5
	$stran = ceil($pocetzaznamu/$zaznamunastranu);//zaokrouhlí to nahoru, kolik celkem stran
	
	//print("<p>".$pocetzaznamu." zaznamu / ".$zaznamunastranu." na stranu / ".$stran." stran</p>");//kontrolní výpis
	
	//******Odkazy na jednotlivé strany */
	if($stran>1){//je to nutné jen tehdy, když je tam víc stran než 1
		print("<div class=\"seznamstran\">");
		for($i=1;$i<=$stran;$i++)
		{
			print("<a href=\"noviny.php?aktualnistrana=".$i);
			if($kategorie<>""){print("&kategorie=".$kategorie);}//udrží si kategorii po kliknutí na stranu
			print("\">".$i." </a>");//klikací odkaz na kliknutí na stránku
		}	//($strana-1)*$zaznamunastranu
		print("</div>");
		print("<hr>");
	}

    
    
    // SQL QUERY
	//****TO HLAVNÍ SQL ****/
	$sql = "SELECT ";//musí mezera
	$sql = $sql."ra.idtarticle, ra.heading, ra.descr, rr.surname, rr.name as rr_name, rc.name as rc_name, rc.idccathegory ";//už to ví aliasy, které budou přiřazeny později ve stejném příkazu
	$sql = $sql."FROM renome_tarticle ra ";																//idccathegory potřebuju na klikací odkaz kategorie vedle článku
	$sql = $sql."LEFT JOIN renome_treporter rr ON rr.idcreporter = ra.idcreporter ";
	$sql = $sql."LEFT JOIN renome_ccathegory rc ON rc.idccathegory = ra.idccathegory ";
	if($kategorie<>""){$sql = $sql."WHERE ra.idccathegory = ".$kategorie." ";}//když je nějaká kategorie, tak se vybere jenom tato
	$sql = $sql."LIMIT ".(($aktualnistrana-1)*$zaznamunastranu).", ".$zaznamunastranu;//co vybere - od kterého záznamu začít (čís. od 0), kolik záznamů
	
    
  
	//print("<p>".$sql."<p>");//pro kontrolu
	$result = mysqli_query($conn, $sql); // tbulka
	


	if(mysqli_num_rows($result) > 0)//přišel aspoň 1 řádek
	{
		$poradiclanku=($aktualnistrana-1)*$zaznamunastranu-1;//nastavuju pořadí článku na výchozí hodnotu před projitím strany, čísluju od 0 (vymoženost)
        
        // PROJíT RESULT 
		while($row = mysqli_fetch_assoc($result)){//vyrobí z něj pole
			$poradiclanku++;//vymoženost
			print("<h2 id=\"c".$row["idtarticle"]."\">");//c-třída článek, každý nadpis má identifikátor
			print("<a href=\"noviny.php?id=".$row["idtarticle"]."&aktualnistrana=".$aktualnistrana);//předávám id článku a aktuální stranu
			if($kategorie<>""){print("&kategorie=".$kategorie);}//když je určená kategorie, musí se předat
			print("&poradiclanku=".$poradiclanku);//vymoženost	
			print("&zaznamunastranu=".$zaznamunastranu);//vymoženost - zároveň to dodává nové možnosti uživatelského nastavení počtu záznamů na stranu			
			print("\">");
			print($row["heading"]."</a></h2>");//to vše se stane, když se klikne na nadpis článku
			//echo "<!--".print_r($row,true)."-->\n";//kontrola, co je v row
			if($row["rr_name"]<>""){//ty názvy sloupců byly moc stejné, tak se to muselo pro tento dotaz přejmenovat přes as
				print("<p>".$row["rr_name"]." ".$row["surname"]."</p>");
			}
			if($row["rc_name"]<>""){//napíše jméno kategorie
				print("<p class=\"kateg\"><a href=\"noviny.php?kategorie=".$row["idccathegory"]."\">".$row["rc_name"]."</a></p>");//a taky odkaz na kategorii
			}
			print("<div><p>".$row["descr"]."</p></div>");//vypíše popis
		}
	}
	//seznam stran ještě dole, ať se nemusí rolovat znovu nahoru
	if($stran>1){//je to nutné jen tehdy, když je tam víc stran než 1
		print("<hr class=\"dolnicara\">");
		print("<div class=\"seznamstran\">");
		for($i=1;$i<=$stran;$i++)
		{
			print("<a href=\"noviny.php?aktualnistrana=".$i);
			if($kategorie<>""){print("&kategorie=".$kategorie);}//udrží si kategorii po kliknutí na stranu
			print("\">".$i." </a>");//klikací odkaz na kliknutí na stránku
		}	//($strana-1)*$zaznamunastranu
		print("</div>");
	}

}else{//konkrétní článek se zobrazí
	$sql = "SELECT idtarticle, heading, text FROM renome_tarticle WHERE idtarticle = ".$id;//přilepíme k tomu to číslo, které přišlo (kliklo se na něj na nadpis)
	
	$result = mysqli_query($conn, $sql);

	if($pocetzaznamu > 0)
	{
		while($row = mysqli_fetch_assoc($result)){
			//TLAČÍTKO ZPĚT
			print("<a class=\"tlacitkouvod\" href=\"noviny.php?aktualnistrana=".$aktualnistrana);
			if($kategorie<>""){print("&kategorie=".$kategorie);}//když je určená kategorie, musí se předat - vrátí se to zpět na přehled pouze dané kategorie
			print("#c".$row["idtarticle"]."\">Zpět na seznam</a>");//pošle zpět - na danou stranu a náležitě nízko
			//SAMOTNÝ VÝPIS NADPISU A TEXTU
			print("<h2>".$row["heading"]."</h2>");
			print("<div>".$row["text"]."</div>");
		}
	}
	
	//VYMOŽENOST: kliknutí na další článek podle toho jak je mám momentálně seřazené
	if(isset($_REQUEST["poradiclanku"])){//toto tady asi musí být - tahám si pořadí článku z requestu
		$poradiclanku=$_REQUEST["poradiclanku"];
	}else{
		$poradiclanku="";//asi - nevím, co to udělá, pak s tím něco počítám
	}

	if(isset($_REQUEST["zaznamunastranu"])){
		$zaznamunastranu=$_REQUEST["zaznamunastranu"];
	}else{
		$zaznamunastranu="";
	}

	$sql = "SELECT ";//musí mezera
	$sql = $sql."ra.idtarticle, ra.heading ";//stačí nám zjistit id toho následujícího článku a nadpis! - když ho tam chci napsat
	$sql = $sql."FROM renome_tarticle ra ";
	$sql = $sql."LEFT JOIN renome_ccathegory rc ON rc.idccathegory = ra.idccathegory ";
	if($kategorie<>""){$sql = $sql."WHERE ra.idccathegory = ".$kategorie." ";}//když je nějaká kategorie, tak se vybere jenom tato - to je důležité!
	$sql = $sql."LIMIT ".($poradiclanku+1).", 1";//vybere jenom ten jeden následující článek //zhroutí se to, když přesáhne počet vybraných článků??
	
	//print("<p>".$sql."<p>");//pro kontrolu
	$result = mysqli_query($conn, $sql);

	if(mysqli_num_rows($result) > 0)//přišel aspoň 1 řádek
	{
		$poradiclanku++;//musí se to předávat i když se klikne touto cestou
		while($row = mysqli_fetch_assoc($result)){//vyrobí z něj pole
			print("<h4> Následující článek: ");
			print("<a href=\"noviny.php?id=".$row["idtarticle"]);			
			if($poradiclanku==$aktualnistrana*$zaznamunastranu){print("&aktualnistrana=".($aktualnistrana+1));}//když je poslední, aktuální strana se změní přechodem na další článek
			else{print("&aktualnistrana=".$aktualnistrana);}//to je ten odkaz, předávají se opět nezbytné věci 
			if($kategorie<>""){print("&kategorie=".$kategorie);}//když je určená kategorie, musí se předat											
			print("&poradiclanku=".$poradiclanku);//předávám aktuální pořadí článku
			print("&zaznamunastranu=".$zaznamunastranu);//musím si to předat, jinak pak nebude z čeho počítat, jestli je poslední
			print("\">");
			print($row["heading"]."</a></h4>");
		}
	}
	//KONEC VYMOŽENOSTI	
}
	
print("</main>");

mysqli_close($conn);	
?>
	
</body>
</html>
