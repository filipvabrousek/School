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
    
    .top {
        margin-top: 2em;
        
    }
    
    .reset {
        margin-bottom: 1em;
    }
    
     body {
     	background: white;
         background-size: 100%;
     	background-blend-mode: hard-light; 
        
     }
     .info {
     	margin: 1em;
     	/*color: #e74c3c;*/
         color: #fff;
     	font-weight: bold;
         text-align: center;
     }
     input[type="text"], input[type="email"], input[type="password"], input[type="number"] {
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
     input[type="submit"] {
     	margin-top: 1em;
     	background: white;
     	color: #e74c3c;
     	padding: 0.6em;
        font-size: 1em;
     	font-weight: bold;
     	border: none;
     	width: 20em;
     }
     .marko {
     	border: 6px solid red;
     	border-color: red;
         background: blue;
     }
     .greeny {
     	border: 6px solid green;
     	border-color: green;
     }
     input[type="checkbox"] {
     	padding-left: 30px;
     }
     #background {
     	opacity: 0.88;
     	background: #e74c3c;
     }
     label {
     	font-weight: bold;
     	color: white;
     }
     h1 {
     	color: #e74c3c;
     	font-family: sans-serif;
     }
     .err {
     	font-weight: bold;
     	color: red;
         text-align: center;
         padding: 1em;
     }
     .notice {
     	font-weight: bold;
     	color: orange;
     }
     span {
     	font-weight: bold;
     	color: red;
     }
    
    .frame {
        border: 2px solid red;
        background: #e74c3c;
        color: white;
    }
    
    .frame > * {
        color: white;
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
        margin-top: 1em;

         color:#e74c3c;
     }
     .food-title {
     	color: white;
     }
    
    img {
        
       width: 70vw;
        margin-left: calc(100vw / 2 - 35vw);
        
    }
    
    .white {
        color: #e74c3c;
        text-align: center;
        font-size: 1.5em;
    }
    
    
    
    
    
     select {
     	background: #d6d6d6;
     	font-weight: bold;
     	padding: 1em 0.5em 1em 0.5em;
     	width: 20em;
     	-webkit-appearance: none;
     	-moz-appearance: none;
     	appearance: none;
     	text-align-last: center;
     	margin: 2em;
     	font-size: 0.8em;
     	/* margin-left: calc(100vw / 2 - 10em); */
     	background: url(https://i.imgur.com/rzODlvQ.jpg) 96% / 15% no-repeat #ffffff;
     }
    
    
     #float {
     	float: left;
     } 
    
    .info {
        color: #e74c3c;
    }
    
    h2 {
        color: white;
    }
    
    .wh {
        color: white;
        text-align: center;
    }
</style>
    
    
</head>
<?php
    

    
$show = True;    

$sekce = "formular";
if (isset($_REQUEST["sekce"])) {
    $sekce = $_REQUEST["sekce"];
}
if ($sekce == "hlavnistrana") {
    print("<h1 style=\"color: \"green\"; \"text-align: \"center\">Uvodni strana</h1>");
}
    
    
    
    
if ($sekce == "formular") {
    
    $nameerr     = "";
    $surnameerr  = "";
    $passworderr = "";
    $emailerr    = "";
    $phoneerr    = "";
    $gendererr   = "";
    $termserr    = "";
    $errors      = array();
    $namelenerr  = "";
    $product     = "";
    $anumber     = "";
    $dessert     = "";
    $soup        = "";
    $soupprice   = 0;
    $addsoup     = 0;
    
    
    //  $foodids = array("f1", "f2");
    $foodnames  = array(
        "Kuřecí řízek",
        "Hovězí"
    );
    $foodshorts = array(
        "chicken",
        "pork"
    );
    $foodprices = array(
        "200",
        "300"
    );
    
    
    $soups = array(
        "soup1",
        "soup2"
    );
    $soupnames   = array(
        "hovězí",
        "telecí"
    );
    $soupsprices = array(
        "120",
        "130"
    );
    ?>
<body>

<!--
<ul>
    <li><a href="filip.php?sekce=hlavnistrana">hlavni strana</a></li>    
    <li><a href="filip.php?sekce=formular">formular</a></li>    
</ul>    
--->
    
    
    

 
<div id="backimg">
    
<h1 class="title">U Filipa</h1>
    
    <form action="filip-fixed.php" method="get">
   
<div id="background">
<section id="wrapper">     
 <!-----------------------------JMÉNO----------------------------->        

   <h1 class="wh top">Osobní údaje</h1>    
<br>
<label for="name">Počet lidí (musí odpovídat počtu jídel) </label>
<input type="number" placeholder="Počet lidí" name = "peoplecount" value="<?php
    if (isset($peoplecount)) {
        print($peoplecount);
    }
?>" >
   <br>       
        
    
    

        
<!-----------------------------JMÉNO----------------------------->        
<label for="name">Jméno:* </label>
<input type="text" name="name" placeholder="Jméno" value="<?php
    if (isset($name)) {
        print($name);
    }
?>" >
   <br>
        
<!-----------------------------PŘIJÍMENÍ----------------------------->      
<label for="surname">Přijímení:* </label>
<input type="text" name="surname" placeholder="Přijímení" value="<?php
    if (isset($surname)) {
        print($surname);
    }
?>" >
   <br>
        
        

 <!-----------------------------EMAIL NEBO TEL. Č----------------------------->   
<label for="email">E-mail:* </label>
 <input type="text" name="email" placeholder="E-mail" value="<?php
    if (isset($email)) {
        print($email);
    }
?>" class="<?php
    if (in_array("email", $errors)) {
        print("marko");
    }
?>" >
<br>
 
<label for="phone">Telefon:* </label>
    <input type="text" pattern = "[0-9]{3} [0-9]{3} [0-9]{3}" name="phone" placeholder="123 456 789" value="<?php
    if (isset($phone)) {
        print($phone);
    }
?>" class="<?php
    if (in_array("phone", $errors)) {
        print("marko");
    }
?>" >
<br>
        
       
<!-----------------------------HLAVNÍ JÍDLO----------------------------->       
        
    
<!---
FUNCTION TO DETERMINE A PHONE NUMBER
-->   

<h1 class="wh">Hlavní jídlo</h1>
<br>
    
    
  <?php
    
    
    
    
    
    
    for ($i = 0; $i < count($foodnames); $i++) {
        print("<h3 class=\"food-title\">" . $foodnames[$i] . " $foodprices[$i] Kč</h3>");
        print("<input type=\"number\" name=" . $foodshorts[$i] . " value=\"0\"/>");
        //    print("<p><input type=\"number\" name=\"foodnames".$i."\" value=\"0\"> ".$foodnames[$i]." (".$foodprices[$i]."&nbsp;Kč)</p>");    
        
    }
    
    
?>
    

        <br><br>
     
        
        <h1 class="wh">Polévky</h1>
    <select name="soup">
    <option value="žádnou">-- vyberte polévku</option> 
   
    <?php
    for ($i = 0; $i < count($soups); $i++) {
        print(" <option value=\"" . $soupnames[$i] . "\">" . $soupnames[$i] . " $soupsprices[$i] Kč </option> ");
    }
    
?>    
   
    </select>
        
<div id="float">
<label>Chci dezert (30 Kč)</label>  

<input type="checkbox" name="terms" value=" terms">
    </div>
    
    
        <br>
    
    <input type="submit" class="reset" name="send" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    </section>
        
    <script>
    document.querySelector("form").addEventListener("submit", function(e){
        let r = document.querySelector("#background");
        r.style.display = "none";
        console.log("Back is " + r);
        console.warning("And just like that, it was gone");
    });
        
    </script>
        </div>

   <?php
  
       $allow = true;
    
    if (isset($_REQUEST["send"])) { //prisla data z formulare? Byl odeslan?
 
        $sekce = "fsummary";
   
    }
}
    

    
if ($sekce == "fsummary"){
    
      
        
        
        
        /*------------------------ PEOPLE COUNT ------------------------ */
        $peoplecount = trim($_REQUEST["peoplecount"]); // remove whitespace
        
        $foodprice = 0;
        $foodcount = 0;
        $summary   = "<div class=\"frame\"><h2 class=\"info wh\">Objednávka: </h2>";
        
        
        if ($peoplecount < 1) {
            print("<p class='err'>Nedostatečný počet lidí</h1>");
            $allow = false;
        }  
    
      $soup = $_REQUEST["soup"];
     if ($soup == "") {
            print("<p class='err'>Nebyla vyplněna polévka</p>");
     }
    
   
    
     $email = $_REQUEST["email"];
    $phone = $_REQUEST["phone"];
     if ($email == "" && $phone == "") {
            print("<p class='err'>Musíte vyplnit email nebo telefonní číslo.</p>");
         
         $errors[] = "email";
         $errors[] = "phone";
     }
    
        $name = $_REQUEST["name"];
     if ($name == "") {
            print("<p class='err'>Nebylo vyplněno jméno.</p>");
     }
    
        $surname = $_REQUEST["surname"];
     if ($surname == "") {
            print("<p class='err'>Nebylo vyplněno přijímení.</p>");
     }
    
    
  /*  
    $foodcount = trim($_REQUEST["foodcount"]);
    echo $foodcount;
    echo "HI";
    echo $peoplecount;
 if ($foodcount != $peoplecount){
     print("<p class='err'>Nedostatečný počet lidí .$peoplecount. Pro .$foodcount. jídel.</p>");
 }
    
    */
    
              
         $peoplecount = trim($_REQUEST["peoplecount"]); // remove wh
            for ($i = 0; $i < count($foodnames); $i++) {
                $food      = $foodshorts[$i];
                $foodcount = $foodcount + $_REQUEST[$food];
                
    
            }
    
     
 if ($foodcount < $peoplecount){
     print("<p class='err'>Nedostatečný počet lidí (".$peoplecount.") Pro ".$foodcount." jídel </p>");
 }
    
    if ($peoplecount > 1 && $email != "" && $soup != "" && (email != "" || phone != "") && ($foodcount == $peoplecount)){
     print("<script>");
        print("document.querySelector('form').style.display = 'none'");
        print("</script>");   
        
        
        print("<img src='https://o.aolcdn.com/images/dims3/GLOB/crop/5760x2880+0+480/resize/630x315!/format/jpg/quality/85/http%3A%2F%2Fo.aolcdn.com%2Fhss%2Fstorage%2Fmidas%2F1e6a11c0ceb369bee739518f2618916d%2F205881769%2Fhealth-food-for-fitness-picture-id855098134'>");

//     strip_tags("<form></form>");
          /*------------------------ SOUP ------------------------ */
       
             //  $allow = true;
       // }
  
        
        
        
        /*------------------------ NAME ------------------------ */
        $name = trim($_REQUEST["name"]); // remove whitespace
        if ($name == "") {
             $allow = false;
        } else {
            print("<p class=\"info\">Jméno: " . $name . "</p>");
            // $allow = true;
        }
        
        
        /*------------------------SURNAME ------------------------ */
        $surname = trim($_REQUEST["surname"]); // remove whitespace
        if ($surname == "") {
            $allow = false;
        } else {
            print("<p class=\"info\">Přijímení: " . $surname . "</p>");
           // $allow = true;
        }
        
        /*-------------------------------EMAIL OR PHONE ------------------------------ */
        $email = $_REQUEST["email"];
        $phone = $_REQUEST["phone"];
        if ($email == "" && $phone == "") {
            print("<p class=\"err\">Musíte vyplnit email nebo telefonní číslo</p>");
            $emailerr = "NEBYLO VYPLNĚN EMAIL";
            $errors[] = "email";
            //  $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
            $errors[] = "phone";
           
            
            
        } else {
            if ($email != "") {
                print("<p class=\"info\">Zadali jste e-mail: " . $email . "</p>");
               //  $allow = true;
            } else {
                $allow = false;
            }
            
            if ($phone != "") {
                
                print("<p class=\"info\">Zadali jste telefonní číslo: " . $phone . "</p>");
               //  $allow = true;
            }  else {
                 $allow = false;
            }
           
            
        }
        
           
         $peoplecount = trim($_REQUEST["peoplecount"]); // remove wh
            for ($i = 0; $i < count($foodnames); $i++) {
                $food      = $foodshorts[$i];
                $summary   = $summary . "<p class=\"info wh\">" . $foodnames[$i] . "</p>";
                $foodprice = $foodprice + ($foodprices[$i] * $_REQUEST[$food]);
                
                
                if ($soup == "kuřecí") {
                    $foodprice = $foodprice + $peoplecount * 120;
                }
                
                if ($soup == "hovězí") {
                    $foodprice = $foodprice + $peoplecount * 130;
                }
                
                if (isset($_REQUEST["terms"])) {
                    $foodprice = $foodprice + $peoplecount * 30; // dezert
                }
                
                
                $foodcount = $foodcount + $_REQUEST[$food];
                
               
            }
        
        
            
           print($summary);
      
         $soup = $_REQUEST["soup"];
       /* if ($soup == "") {
               $allow = false;
        } else {*/
            print("<p class=\"info wh\">".$soup." polévka</p>");
              
              
        if (isset($_REQUEST["terms"])) {
            print("<p class=\"info wh\">Dezert: Ano</p>");
        } else {
            // print("<p class=\"err\">Musíte souhlasit s podmínkami </p>"); 
            print("<p class=\"info wh\">Dezert: Ne</p>");
        }
          print("</div>");
          print("</div>");
        
        
        
        print("<h1 class=\"white top\">Celková cena za ". $foodcount ." jídel je " . $foodprice . " Kč</h1>");
                print("<button class=\"reset\">Odeslat do databáze</button>");
        
        
        $sekce = "fsummary";
    }
    
    
    
    // ::::::::::::: There are ::::::::::::::::
    
        
        
}
    
    
   if ($_REQUEST["sekce"] == "fsummary") {
       print("<h1>All clear.$summary.</h1>");
   }
  
    
  
    
    
    
    
    

    
  /*  
 if ($_REQUEST["sekce"] == "fsummary") {  // check if alllow == true
        
         $peoplecount = trim($_REQUEST["peoplecount"]); // remove wh
            for ($i = 0; $i < count($foodnames); $i++) {
                $food      = $foodshorts[$i];
                $summary   = $summary . "<li class=\"info\">" . $foodnames[$i] . "</li>";
                $foodprice = $foodprice + ($foodprices[$i] * $_REQUEST[$food]);
                
                
                if ($soup == "kuřecí") {
                    $foodprice = $foodprice + $peoplecount * 120;
                }
                
                if ($soup == "hovězí") {
                    $foodprice = $foodprice + $peoplecount * 130;
                }
                
                if (isset($_REQUEST["terms"])) {
                    $foodprice = $foodprice + $peoplecount * 30; // dezert
                }
                
                
                $foodcount = $foodcount + $_REQUEST[$food];
                
               
            }
            
            if ($foodcount == $peoplecount) {
                print($summary);
                print("<h1 class=\"white\">Celková cena je: " . $foodprice . " Kč</h1>");
                print("<button class=\"reset\">Odeslat do databáze</button>");
            } else {
                print("<h1>Nesedí počet osob</h1>");
            }
        
        print("Foodcount ".$foodcount);
        print("Peoplecount ".$peoplecount);
        
      print("<script>");
      //  print("alert('Wow');");
        print("document.querySelector('form').style.display = 'none'");
   
        print("</script>");
        
             
    }
    
    
    */
    
    
    
    
    
    
    
    
    
    
    
    
?>
    </div>
</body>
</html>
