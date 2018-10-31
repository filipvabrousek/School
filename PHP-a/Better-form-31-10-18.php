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
     	/*background: url("https://d2v9y0dukr6mq2.cloudfront.net/video/thumbnail/BRDf5QkViozx5sck/heavenly-tropical-island-background_rmmmmsln__F0000.png");
     	background-blend-mode: hard-light; */
         background: #ecf0f1;
     }

     .info {
     	margin: 1em;
     	color: #1abc9c;
     	font-weight: bold;
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
     }

     .greeny {
     	border: 6px solid green;
     	border-color: green;
     }

     input[type="checkbox"] {
     	padding-left: 30px;
     }

     #background {
     	opacity: 1.0;
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
        margin-top: 1em;
        
     }

     .food-title {
     	color: white;
     }
    
    .white {
        color: white;
        text-align: center;
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
    
    h2 {
        color: white;
    }
</style>
   
    
    
</head>
<?php
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
        "hovězí"
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

   <h1 class="white">Osobní údaje</h1>    
<br>
<label for="name">Počet lidí (musí odpovídat počtu jídel) </label>
<input type="number" name = "peoplecount" value="<?php
    if (isset($peoplecount)) {
        print($peoplecount);
    }
?>" >
   <br>       
        
        
        
<!-----------------------------JMÉNO----------------------------->        
<label for="name">Jméno:* </label>
<input type="text" name="name" placeholder="Enter name" value="<?php
    if (isset($name)) {
        print($name);
    }
?>" >
   <br>
        
<!-----------------------------PŘIJÍMENÍ----------------------------->      
<label for="surname">Přijímení:* </label>
<input type="text" name="surname" placeholder="Enter surname" value="<?php
    if (isset($surname)) {
        print($surname);
    }
?>" >
   <br>
        
        

 <!-----------------------------EMAIL NEBO TEL. Č----------------------------->   
<label for="email">E-mail:* </label>
 <input type="text" name="email" placeholder="Enter email" value="<?php
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
    <input type="text" pattern = "[0-9]{3} [0-9]{3} [0-9]{3}" name="phone" placeholder="Enter your phone number" value="<?php
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

<h1 class="white">Hlavní jídlo</h1>
<br>
  <?php
    for ($i = 0; $i < count($foodnames); $i++) {
        print("<h3 class=\"food-title\">" . $foodnames[$i] . " $foodprices[$i] Kč</h3>");
        print("<input type=\"number\" name=" . $foodshorts[$i] . " value=\"0\"/>");
        //    print("<p><input type=\"number\" name=\"foodnames".$i."\" value=\"0\"> ".$foodnames[$i]." (".$foodprices[$i]."&nbsp;Kč)</p>");    
        
    }
    
?>
    

        <br><br>
     
        
        <h1 class="white">Polévky</h1>
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

    /* $recipes = array("Maso nakrájíme na plátky. ...
    Do tří hlubokých talířů si připravíme: hladkou mouku; dvě nevařená vajíčka bez skořápky + mléko + špetka soli + trocha pepře - to vše pořádně promícháme; strouhanka.
    Maso obalíme v prvním talíři, pak v druhém a nakonec ve třetím.", "ff", "jj");
    */
    
    if (isset($_REQUEST["send"])) { //prisla data z formulare? Byl odeslan?
        
        
        
        /*------------------------ SOUP ------------------------ */
        $soup = $_REQUEST["soup"];
        if ($soup == "") {
            
        } else {
            print("<p class=\"info\">Vybrali jste " . $soup . " polévku. </p>");
        }
        
        if (isset($_REQUEST["terms"])) {
            print("<p class=\"info\">Dezert: Ano</p>");
        } else {
            // print("<p class=\"err\">Musíte souhlasit s podmínkami </p>"); 
            print("<p class=\"info\">Dezert: Ne</p>");
        }
        
        
        
        /*------------------------ NAME ------------------------ */
        $name = trim($_REQUEST["name"]); // remove whitespace
        if ($name == "") {
        } else {
            print("<p class=\"info\">Jméno: " . $name . "</p>");
        }
        
        
        /*------------------------SURNAME ------------------------ */
        $surname = trim($_REQUEST["surname"]); // remove whitespace
        if ($surname == "") {
        } else {
            print("<p class=\"info\">Přijímení: " . $surname . "</p>");
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
            if ($email != "") {
                print("<p class=\"info\">Zadali jste e-mail: " . $email . "</p>");
            }
            
            if ($phone != "") {
                print("<p class=\"info\">Zadali jste telefonní číslo: " . $phone . "</p>");
            }
            
        }
        
        
        
        /*------------------------ PEOPLE COUNT ------------------------ */
        $peoplecount = trim($_REQUEST["peoplecount"]); // remove whitespace
        
        
        
        
        $foodprice = 0;
        $foodcount = 0;
        $summary   = "<h2 class=\"info\">Objednávka: </h2>";
        
        
        if ($peoplecount < 1) {
            print("<h1>Nedostatečný počet lidí</h1>");
        } else {
            
            
            
            
            
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
                
                /*  echo $peoplecount;
                echo "<br>";
                echo "<h1>prices</h1>";
                echo $foodprices[$i];*/
            }
            
            if ($foodcount == $peoplecount) {
                print($summary);
                print("<h1>Celková cena je: " . $foodprice . " Kč</h1>");
                print("<button>Odeslat do databáze</button>");
            } else {
                print("<h1>Nesedí počet osob</h1>");
            }
        }
    }
}
    
?>
    </div>
</body>
</html>
