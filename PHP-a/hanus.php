
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>1-formular-ukol</title>
<style>

*{
	padding:0;
	margin:0;
}

body{
	
	font-family:"Helvetica", "sans-serif", "Arial";
	text-align: center;
	background-color: #F5F5F5;
}

h1{
	font-family: "DejaVu Sans", "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size: 4rem;
	padding: 4rem 8rem 4rem 8 rem;
	border-top: solid 3px;
	border-bottom: solid 3px;
	text-align: center;
	background-color: #ffcce0;
	color: #cc0052;
}

h2{
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
	font-size: 1,5rem;
	color: black;
	text-align: center;
}

form{
  background-color:#ffe6f0;
  max-width: 360px;
  margin: 1% auto auto auto;
  padding: 10% 2% 2% 2%;
  text-align: left;
}
.textform{
  margin: 0 0 15px;
  padding: 15px;
  text-align: left;
}

.button {
  font-family: "Arial", "Helvetica", "sans-serif";
  font-size: 1rem;
  text-transform: uppercase;
  background-color:  #ff99c2;
  width: 50%;
  padding: 2%;
  color:black;
}

.nazev{
   padding: 0 0 1%;
}

#chybi{

	border: 1px solid #cc0052;
}
 

  

</style>

</head>

<body>

<h1>Vyber si svuj produkt</h1>

<?php
$nepovzn = "";
$chyby = "";
$chyby = "";
$chybnapole = array();
	
	if (isset($_REQUEST["odeslat"])){ //prisla data z formulare? Byl odeslan?
		
	    $povoleneznaky = "abcdefghijklmnopkqrstuvwxyz-";
	    
	    $jmeno = trim($_REQUEST["jmeno"]);				    		
		if ($jmeno=="")
		{
				$chyby = $chyby. "<li><p class=\"chyba\"> Nebylo korektne vyplneno jmeno</></li>";
				$chybnapole[] = "jmeno";
		}
		else
		{
		    
			       
				       if(strlen($jmeno)>1)
				       {
					           for($i=0;$i<strlen($jmeno);$i++ )
					           {
						          if(strpos($povoleneznaky, $jmeno[$i])===false)
						          {
						              $nepovzn=$nepovzn.$jmeno[$i]. ", ";	
						          }												              						          
					           }
					           if(!$nepovzn=="")
					           {
					               $chyby = $chyby. "<li><p class=\"chyba\"> Nebylo korektne vyplneno jmeno</></li>";
					               $chybnapole[] = "jmeno";
					           }
				        }
				    else
				    {
					$chyby = $chyby. "<li><p class=\"chyba2\"> Jmeno musi mit delku alespon 2 znaky</></li>";
					$chybnapole[] = "jmeno";
				    					
				    }
		}
	
			
		$prijmeni = trim($_REQUEST["prijmeni"]);
		if ($prijmeni=="")
		{
		    $chyby = $chyby. "<li><p class=\"chyba\"> Nebylo korektne vyplneno prijmeni</></li>";
		    $chybnapole[] = "prijmeni";
		}
		else
		{
		    
		    if(strlen($prijmeni)>1)
		    {
		        for($i=0;$i<strlen($prijmeni);$i++ )
		        {
		            if(strpos($povoleneznaky, $prijmeni[$i])===false)
		            {
		                $nepovzn=$nepovzn.$prijmeni[$i]. ", ";
		            }		            		            
		        }
		        if(!$nepovzn=="")
		        {
		            $chyby = $chyby. "<li><p class=\"chyba\"> Nebylo korektne vyplneno prijmeni</></li>";
		            $chybnapole[] = "prijmeni";
		        }
		    }
		    else
		    {
		        $chyby = $chyby. "<li><p class=\"chyba2\"> Prijmeni musi mit delku alespon 2 znaky</></li>";
		        $chybnapole[] = "prijmeni";
		        
		    }
		}
    
								
			$email = $_REQUEST["email"];
			if ($email==""){
				$chyby = $chyby. "<li><p class=\"chyba\"> Nebyl korektne vyplnen e-mail</></li>";
				$chybnapole[] = "email";
			}				
			$heslo = $_REQUEST["heslo"];
			if ($heslo==""){
				$chyby = $chyby. "<li><p class=\"chyba\"> Nebylo korektne vyplneno heslo</></li>";
				$chybnapole[] = "heslo";
			}		
			$telefon = $_REQUEST["telefon"];
			if ($telefon==""){
				$chyby = $chyby. "<li><p class=\"chyba\"> Nebyl korektne vyplnen telefon</></li>";
				$chybnapole[] = "telefon";
			}
			if(isset($_REQUEST["podminky"]))
			{   
			    	    
			}
			else
			{
			    $chyby = $chyby. "<li><p class=\"chyba\"> Prosim odsouhlaste licencni podminky</></li>";
			}
			
			
			
	}
			
		
		
			
		if (!$chyby == "" )
		{
				print("<h2>Byly nalezeny nasledujici chyby: </h2>");
				print("<ul>".$chyby."</ul");
				if (!$nepovzn == "" )
				{
				    print( "<p class=\"chyba2\"> Nasledujici znaky u jmena a prijmeni jsou zakazany: </>".$nepovzn);
				}
		}
			
	
	?>
	
	
	<form action="formular-ukol-1.php" method="get">
	<input class= "textform" type="text" name="jmeno" placeholder="Jmeno" value="<?php  if (isset($jmeno)){print($jmeno);}?>" id="<?php if(in_array("jmeno",$chybnapole)){print("chybi");}?>" ><br>
	<input class= "textform" type="text" name="prijmeni" placeholder="Prijmeni" value="<?php  if (isset($prijmeni)){print($prijmeni);}?>"id="<?php if(in_array("prijmeni",$chybnapole)){print("chybi");}?>"><br>
	<input class= "textform" type="email" name="email" placeholder="E-mail"value="<?php  if (isset($email)){print($email);}?>"id="<?php if(in_array("email",$chybnapole)){print("chybi");}?>"><br>
	<input class= "textform" type="password" name="heslo" placeholder="Heslo" value="<?php  if (isset($heslo)){print($heslo);}?>"id="<?php if(in_array("heslo",$chybnapole)){print("chybi");}?>"><br>
	<input class= "textform" type="tel" name="telefon" placeholder="Telefon" value="<?php  if (isset($telefon)){print($telefon);}?>"id="<?php if(in_array("telefon",$chybnapole)){print("chybi");}?>"><br>
	
	<label for="pohlavi"><div class="nazev">Pohlavi:</div></label><select class= "textform" name="pohlavi"><br>
																<option value="muz">muz</option>
																<option value="zena">zena</option>
																<option value="jine">jine</option>
																	</select>
																	  <br>
																	  
	
	<div class="nazev">Vyrobky:</div>
	<input class="radio" type="radio" name="vyrobek" value="behx32" <?php if (isset($_REQUEST["odeslat"])){$vyrobek = $_REQUEST["vyrobek"]; if($vyrobek=="behx32"){print"checked = \"checked\"";}}else{print("checked");}?>  >Behringer x32, 44 000,-<br>
	<input class="radio" type="radio" name="vyrobek" value="midasm32" <?php if (isset($_REQUEST["odeslat"])){$vyrobek = $_REQUEST["vyrobek"]; if($vyrobek=="midasm32"){print"checked = \"checked\"";}}?>>Midas M32, 100 000,-<br>
	<input class="radio" type="radio" name="vyrobek" value="scvi1" <?php if (isset($_REQUEST["odeslat"])){$vyrobek = $_REQUEST["vyrobek"]; if($vyrobek=="scvi1"){print"checked = \"checked\"";}}?>>Soundcraft Vi1, 200 00,-<br><br>

	<div class="chyba">Souhlasim s licencnimi podminkami</div>
	<input class="checkbox" type="checkbox" name="podminky" value="souhlaspodminky" <?php if (isset($_REQUEST["podminky"])){$podminky = $_REQUEST["podminky"]; if($podminky=="souhlaspodminky"){print"checked = \"checked\"";}}?>	<br><br>	
	<input type="submit" name="odeslat" value="Odeslat" class="button">		
	
	</form>
	

	
</body>
</html>
