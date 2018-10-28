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
     
     body {
         background: orange;
         filter: blur(80);
     }
     
     .info {
         margin: 1em;
         color: white;
         font-weight: bold;
     }
     
    input[type="text"],input[type="email"], input[type="password"], input[type="number"]  {
        padding: 0.3em;
        font-size: 1em;
        border-color: 3px solid green;
        margin-bottom: 1em;
        height: 2em;
    }
    
    select {
        appearance: none;
        padding: 1em;
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
    
   
    .marko {
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
    
     #background {
       /*  background: #000000;
         opacity: 0.5;
         
          print(" <input  type=\"text\" name= \"food\" placeholder=\".$foodnames[$i]. 
         value="<?php if (isset($foodnames[$i])){print($foodnames[$i]);}?>">);
         */
     }
     
     h1 {
         color: #ffffff;
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
     
     .title {
         text-align: center;
         margin-bottom: 1em;
         font-size: 3em;
     }
     
     
     .food-title{
         color: white;
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
    
    if (isset($_REQUEST["send"])) { //prisla data z formulare? Byl odeslan?
        
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
        
        
        $foodids = array("f1", "f2");
        $foodnames = array("KUŘECÍ ŘÍZEK", "HOVĚZÍ");
        $foodprices = array("200", "300");
        
        
        $soups = array("soup1", "soup2");
        $soupnames = array("hovězí", "telecí");
        $soupsprices = array("120", "130");
        $recipes = array("Maso nakrájíme na plátky. ...
Do tří hlubokých talířů si připravíme: hladkou mouku; dvě nevařená vajíčka bez skořápky + mléko + špetka soli + trocha pepře - to vše pořádně promícháme; strouhanka.
Maso obalíme v prvním talíři, pak v druhém a nakonec ve třetím.", "ff", "jj");
        
        
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
        
        
        
          /*------------------------ PEOPLE COUNT ------------------------ */
        $peoplecount = trim($_REQUEST["peoplecount"]); // remove whitespace
         if ($peoplecount == "") {
        } 
        
        
        
        $foodprice = 0;
        $foodcount = 0;
        $summary = "";
        
        
        if ($peoplecount < 1){
            print("<h1>Nedostatečný počet lidí</h1>"); 
        } else {
            for ($i = 0; $i<count($foodids); $i++){
                $food = $foodids[$i];
               $summary = $summary."<p>".$foodnames[$i]."<p>";
                $foodprice = $foodprice + ($foodprices[$i] * $_REQUEST[$food]);
                $foodcount = $peoplecount + $_REQUEST[$food];
                
                
             
              /*  echo $peoplecount;
                echo "<br>";
                echo "<h1>prices</h1>";
                echo $foodprices[$i];*/
            }
            
            if ($foodcount == $peoplecount){
                print($summary);
                print("<h1>Hurá, celková cena je asi: ".$foodprice."</h1>");
            } else {
                print("<h1>Nesedí počet osob</h1>");
            }
        }
    }
    
?>
   <h1 class="title">U Filipa</h1>
    
    <form action="filip-fixed.php" method="get">
   
<div id="background">
<section id="wrapper">     
 <!-----------------------------JMÉNO----------------------------->        

   <h1>Osobní údaje</h1>    
<label for="name">Počet lidí (musí odpovídat počtu jídel) </label>
<input type="number" name = "peoplecount" value="<?php  if (isset($peoplecount)){print($peoplecount);}?>" >
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
        
    
<!---
FUNCTION TO DETERMINE A PHONE NUMBER
-->   

<h1>Hlavní jídlo</h1>

  <?php
     for ($i = 0; $i < count($foodnames); $i++){
         print("<h3 class=\"food-title\">".$foodnames[$i]." $foodprices[$i] Kč</h3>");
         print("<input type=\"number\" name=".$foodids[$i]." value=\"0\" ".$foodnames[$i]."/>");
       
         
    }
    
    ?>
     

        <br><br>
     
        
        <h1>Polévky</h1>
    <select name="soup">
    <option value="žádná">-- vyberte polévku</option> 
   
    <?php 
    for ($i = 0; $i < count($soups); $i++){
        print(" <option value=\"".soups[$i]."\">".$soupnames[$i]." $soupsprices[$i] Kč </option> ");
    }
        
        ?>    
   
    </select>
        
<label>Chci dezert (30 Kč)</label>  

<input type="checkbox" name="terms" value=" terms">
    
    
    
        <br>
    
    <input type="submit" name="send" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    
        </section>
        </div>

    <?php
}
?>
   
</body>
</html>
