<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Dokument bez názvu</title>
</head>

    
<style>
    
    * {
        margin: 0;
        padding: 0;
        font-family: Arial, sans-serif;
    }
    
    body {
        background: url("http://dreamlife.cz/wp-content/uploads/2015/08/restaurant-hd-wallpaper-for-desktop-background-download-restaurant-images.jpg");
    }
    
    fieldset {
        border: none;
    }
    
    input {
        margin: 1em;
        padding: 0.2em;
        font-size: 1em;
        border-radius: 6px;
        
        border-color: #e67e22;
 
        
    }
    
    
    select {
    background: #d6d6d6;
  	font-weight: bold;
  	padding: 1.5em 1em 1.5em 1em;
  	width: 20em;
  	-webkit-appearance: none;
  	-moz-appearance: none;
  	appearance: none;

    margin: 2em;
    margin-left: calc(100vw / 2 - 10em);
  	background: url(https://i.imgur.com/rzODlvQ.jpg) 96% / 15% no-repeat #ffffff;
  
    }
    
    #wrapper{
        width: 100%;
        background: white;
        opacity: 0.8;
    }
    
    #center {
        display: flex;
        width: 100%;
        justify-content: center;
        align-items: center;
        
        
        
    }
    
    legend {
        text-align: center;
        font-size: 2em;
        font-weight: bold;

    
    }
    
</style>    
    

<body>

/*
- ziskat jmeno souboru	
*/
<?php
	$polevky = array("polevka1", "polevka2");
	$polevkynazvy = array("super polevka 1", "super polevka 2");
	$polevkyceny = array("59", "99");
	$jidla = array("jidlo1", "jidlo2", "jidlo3", "jidlo4");
	$jidlanazvy = array("super jidlo 1", "super jidlo 2","super jidlo 3","super jidlo 4");
	$jidlaceny = array("259", "399", "299", "563");	
    $descriptions = array(" Polévka bývá označována jako lék – česnečka nebo jednoduchý silný masový vývar jsou doporučovány při chřipce nebo při kocovině.", "Mezitím si v hrníčku rozšleháme vejce se špetkou soli, lžičkou oleje a asi 2 lžícemi hladké mouky a vše umícháme vidličkou do hladkého těstíčka. Až se začne rajská polévka vařit, vykrajujeme do ní lžičkou malé nočky. Nakonec podle chuti, pokud je protlak moc kyselý, rajskou polévku trochu ocukrujeme nebo přidáme trochu kečupu.")
?>
	
<form action="degust.php" method="get">
<fieldset>
 <legend>Polévky:</legend>	
<select name="polevky">
	<?php
	for($i=0; $i<count($polevky);$i++){
		print("<option value=\"".$polevky[$i]."\">".$polevkynazvy[$i]." (".$polevkyceny[$i]."&nbsp;Kč)</option>");
        print("<p>".descriptions[$i]."</p>");
	}
	?>
</select>
</fieldset>

<div id="wrapper">
<div id="center">
<fieldset>
 <legend>Jidla:</legend>	
	<?php
	for($i=0; $i<count($jidla);$i++){
		print("<p><input type=\"number\" name=\"jidla".$i."\" value=\"0\"> ".$jidlanazvy[$i]." (".$jidlaceny[$i]."&nbsp;Kč)</p>");
	}
	?>
</select>
</fieldset>
    </div>
    </div>
</form>	
</body>
</html>
