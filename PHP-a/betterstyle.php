<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Formulář</title>
    
 <style>
    
     * {
         margin: 0;
         padding: 0;
         font-family: Arial, sans-serif;
     }
     
     .info {
         margin: 1em;
     }
     
    input[type="text"],input[type="email"], input[type="password"], input[type="number"]  {
        padding: 0.3em;
      font-size: 1em;
        border-color: 3px solid green;
        margin-bottom: 1em;
        
        height: 2em;
    }
    
    select {
        margin-bottom: 1em;
    }
    
    input[type="submit"]{
    margin-top: 1em;
    background: #1abc9c;
    color: white;
    padding: 0.6em;
    font-weight: bold;
    border: none;
    width: 20em;
    }
    
   
     
     .marko{
         border: 6px solid red;
         border-color: red;
     }
     
     .greeny {
         border: 6px solid green;
         border-color: green;
     }
     
     input[type="checkbox"] {
        padding-left: 30px;
     }
    
     
     h1 {
         color: #1abc9c;
         font-family: sans-serif;
     }
     
     .err {
         font-weight: bold;
         color: red;
     }
     
     .notice {
         font-weight: bold;
         color: orange;
     }
     
     .info {
         color: black;
     }
     
     span {
         font-weight: bold;
         color: red;
     }
     
     #wrapper {
         display: flex;
         width: 20em;
         justify-content: center;
         flex-direction: column;
         margin-left: auto;
         margin-right: auto;
         
     }
</style>
   
    
    
</head>

<body>

<!--
<ul>
    <li><a href="filip.php?sekce=hlavnistrana">hlavni strana</a></li>    
    <li><a href="filip.php?sekce=formular">formular</a></li>    
</ul>    
--->
    
    
    
<?php
$sekce = "formular";
if (isset($_REQUEST["sekce"])) {
    $sekce = $_REQUEST["sekce"];
}
if ($sekce == "hlavnistrana") {
    print("<h1 style=\"color: \"green\"; \"text-align: \"center\">Uvodni strana</h1>");
    
}
if ($sekce == "formular") {
    
    if (isset($_REQUEST["odeslat"])) { //prisla data z formulare? Byl odeslan?
        
        $nameerr     = "";
        $surnameerr  = "";
        $passworderr = "";
        $emailerr    = "";
        $phoneerr    = "";
        $gendererr   = "";
        $termserr    = "";
        $errors = array();
        $namelenerr = "";
        $product = "";
        $anumber = "";
        $dessert = "";
        $soup = "";
        $soupprice = 0;
        $addsoup = 0;
        
        /*------------------------ SOUP ------------------------ */
        $soup = $_REQUEST["soup"];
        if ($soup == ""){
            
        } else {
         print("<p class=\"info\">Vybrali jste polévku ".$soup."</p>"); 
        }
        
        if (isset($_REQUEST["terms"])){
             print("<p class=\"info\">Dezert: Ano</p>"); 
        } else {
            // print("<p class=\"err\">Musíte souhlasit s podmínkami </p>"); 
             print("<p class=\"info\">Dezert: Ne</p>"); 
        }
        
        /*------------------------ PEOPLE COUNT ------------------------ */
        $peoplecount = trim($_REQUEST["peoplecount"]); // remove whitespace
         if ($peoplecount == "") {
        } 
        
          /*------------------------ DESSERT ------------------------ 
        $dessert = trim($_REQUEST["dessert"]); // remove whitespace
         if ($dessert == "") {
        } 
        */
          /*------------------------ NAME ------------------------ */
          $name = trim($_REQUEST["name"]); // remove whitespace
         if ($name == "") {
        } else {
             print("<p class=\"info\">Jméno: ".$name."</p>");
         }
        
        
          /*------------------------SURNAME ------------------------ */
         $surname = trim($_REQUEST["surname"]); // remove whitespace
         if ($surname == "") {
         } else {
             print("<p class=\"info\">Přijímení: ".$surname."</p>");
         }
        
        
         /*-------------------------------EMAIL OR PHONE ------------------------------ */
        $email = $_REQUEST["email"];
        $phone = $_REQUEST["phone"];
        if ($email == "" && $phone == "") {
             print("<p class=\"err\">MUSÍTE VYPLNIT EMAIL NEBO TELEFONNÍ ČÍSLO...</p>");
            $emailerr = "NEBYLO VYPLNĚN EMAIL";
             $errors[] = "email";
          //  $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
            $errors[] = "phone";    
        } else {
            if ($email != ""){
                 print("<p class=\"info\">Zadali jste email: ".$email."</p>");
            } 
            
            if ($phone != ""){
                 print("<p class=\"info\">Zadali jste telefonní číslo: ".$phone."</p>");
            }
           
        }
        
      
        
        $anumber = intval($_REQUEST["anumber"]); // remove whitespace
        $bnumber = intval($_REQUEST["bnumber"]); // remove whitespace
        $cnumber = intval($_REQUEST["cnumber"]); // remove whitespace
            $soup = $_REQUEST["soup"];
         if ($anumber == "" && $bnumber == "" && $cnumber = "") {
        } else {
             print("<p class=\"info\">Počet kuřecích řízků ".$anumber."</p>");
             print("<p class=\"info\">Počet párků v rohlíku ".$bnumber."</p>");
             print("<p class=\"info\">Počet palačinek ".$cnumber."</p>");
             
             
        if ($soup == "kuřecí"){
            $soupprice = 90;
        } else if ($soup == "hovězí") {
             $soupprice = 100;
        } else if ($soup == "telecí"){
             $soupprice = 110;
        }
          print("<p class=\"info\">Byla vybrána polévka v ceně ".$soupprice."</p>");
             
             
             
             if ($soup != "none"){
                 $addsoup = 1;
             }
             
            $foodsum = $anumber + $bnumber + $cnumber + ($addsoup * $peoplecount);
             
             if (isset($_REQUEST["terms"])){
                 $foodsum += ($peoplecount * 30);
             }
             
             
            $groupMoney = ($anumber * 120) + ($bnumber * 30) + ($cnumber * 100) + ($peoplecount * $soupprice);
            /*
            řízek: 120kč
            párek: 30kč
            palačinka: 100kč
            */
             
             
            if ($foodsum >= $peoplecount){
                print("<p class=\"info\">Počet jídel (".$foodsum.") <span>JE DOSTATEČNÝ</span> pro ".$peoplecount." lidí </p>");
                 print("<p class=\"info\">Celková cena za <span>".$peoplecount."</span> lidí a za <span>".$foodsum."</span> jídel, je <span>".$groupMoney." Kč</span></p>");
            } else {
                print("<p class=\"info\">Počet jídel (".$foodsum.") <span> JE NEDOSTATEČNÝ </span> pro ".$peoplecount." lidí </p>");
                
                  print("<p class=\"info\">Celková cena za <span>".$peoplecount."</span> lidí a za <span>".$foodsum."</span> jídel, je <span>".$groupMoney." Kč</span></p>");
            }
         }
        
    }
    
?>
   <h1>Formulář</h1>
    
    <form action="filip-fixed.php" method="get">
   
        
<section id="wrapper">     
 <!-----------------------------JMÉNO----------------------------->        

   <h1>Osobní údaje</h1>    
<label for="name">Počet lidí (musí odpovídat počtu jídel) </label>
<input type="number" name="peoplecount" placeholder="Enter number of food" value="<?php  if (isset($peoplecount)){print($peoplecount);}?>" >
   <br>       
        
        
        
<!-----------------------------JMÉNO----------------------------->        
<label for="name">Jméno:* </label>
<input type="text" name="name" placeholder="Enter name" value="<?php  if (isset($name)){print($name);}?>" >
   <br>
        
<!-----------------------------PŘIJÍMENÍ----------------------------->      
<label for="surname">Přijímení:* </label>
<input type="text" name="surname" placeholder="Enter surname" value="<?php  if (isset($surname)){print($surname);}?>" >
   <br>
        
        

 <!-----------------------------EMAIL NEBO TEL. Č----------------------------->   
<label for="email">Email:* </label>
 <input type="text" name="email" placeholder="Enter email" value="<?php if (isset($email)){print($email);}?>" class="<?php if(in_array("email",$errors)){print("marko");}?>" >
<br>
 
<label for="phone">Telefon:* </label>
    <input type="text" pattern = "[0-9]{3} [0-9]{3} [0-9]{3}" name="phone" placeholder="Enter your phone number" value="<?php if (isset($phone)){print($phone);}?>" class="<?php if(in_array("phone",$errors)) {print("marko");}?>" >
<br>
        
       
<!-----------------------------HLAVNÍ JÍDLO----------------------------->       
        
 <h1>Hlavní jídla</h1>
<label for = "terms">Počet kuřecích řízků: (120 Kč) </label>        
<input type = "number" name="anumber" value = "<?php if (isset($anumber)){print($anumber);}?>">
<br>
     
        
<label for = "terms">Počet párků v rohlíku: (30 Kč) </label>        
<input type = "number" name="bnumber" value = "<?php if (isset($bnumber)){print($bnumber);}?>">
<br>
     
        
<label for = "terms">Počet palačinek (100 Kč) </label>        
<input type = "number" name="cnumber" value = "<?php if (isset($cnumber)){print($cnumber);}?>">
<br>
     
        

        
    
        

        
        
        
        
        
        
        
        
   <!--     // print("<p class=\"err\">NEBYLO VYPLNENO PŘIJÍMENÍ...</p>"."<br>");
          //  $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
          //  $errors[] = "surname";
        -->
        <br><br>
     
        
        <h1>Polévky</h1>
    <select name="soup">
    <option value="žádná">-- vyberte polévku</option> 
    <option value="kuřecí">kuřecí polévka (90 Kč)</option> 
    <option value="hovězí">hovězí polévka (100 Kč)</option> 
    <option value="telecí">telecí polévka (110 Kč)</option> 
    
    </select>
        
<label>Chci dezert (30 Kč)</label>  

<input type="checkbox" name="terms" value=" terms">
    
    
    
        <br>
    
    <input type="submit" name="odeslat" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    
        </section>


    <?php
}
?>
   
</body>
</html>
