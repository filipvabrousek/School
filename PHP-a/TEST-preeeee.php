<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Formulář</title>
    
 <style>
    
    input[type="text"],input[type="email"], input[type="password"]  {
        padding: 0.3em;
        border-radius: 6px;
        border-color: 3px solid green;
        margin-bottom: 1em;
        width: 13em;
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
         color: blue;
     }
     
     span {
         font-weight: bold;
         color: red;
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
$sekce = "hlavnistrana";
if (isset($_REQUEST["sekce"])) {
    $sekce = $_REQUEST["sekce"];
}
if ($sekce == "hlavnistrana") {
    print("<h1 style=\"color: \"green\">Uvodni strana</h1>");
    
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
        
        
           $peoplecount = trim($_REQUEST["peoplecount"]); // remove whitespace
         if ($peoplecount == "") {
           // print("<p class=\"err\">NEBYLO VYPLNENO PŘIJÍMENÍ...</p>"."<br>");
          //  $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
          //  $errors[] = "surname";
        } 
        
        
          $name = trim($_REQUEST["name"]); // remove whitespace
         if ($name == "") {
           // print("<p class=\"err\">NEBYLO VYPLNENO JMÉNO...</p>"."<br>");
           // $surnameerr = "NEBYLO VYPLNĚNO JMÉNO";
           // $errors[] = "name";
        } else {
             print("<p class=\"info\">Jméno: ".$name."</p>");
         }
        
        
         $surname = trim($_REQUEST["surname"]); // remove whitespace
         if ($surname == "") {
           // print("<p class=\"err\">NEBYLO VYPLNENO PŘIJÍMENÍ...</p>"."<br>");
          //  $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
          //  $errors[] = "surname";
        } else {
             print("<p class=\"info\">Přijímení: ".$surname."</p>");
         }
        
        

        
        $email = $_REQUEST["email"];
        $phone = $_REQUEST["phone"];
        if ($email == "" && $phone == "") {
             print("<p class=\"err\">MUSÍTE VYPLNIT EMAIL NEBO TELEFONNÍ ČÍSLO...</p>");
            $emailerr = "NEBYLO VYPLNĚN EMAIL";
             $errors[] = "email";
           //  print("<p class=\"err\">NEBYLO VYPLNĚNO TELEFONÍ ČÍSLO...</p>");
            $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
            $errors[] = "phone";
            
            
            
            
            
        } else {
            if ($email != ""){
                 print("<p class=\"info\">Zadali jste email: ".$email."</p>");
            } 
            
            if ($phone != ""){
                 print("<p class=\"info\">Zadali jste telefonní číslo: ".$phone."</p>");
            }
           
        }
        
        
       /* if ($phone == "") {
            print("<p class=\"err\">NEBYLO VYPLNĚNO TELEFONÍ ČÍSLO...</p>");
            $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
            $errors[] = "phone";
        }*/
        
        $anumber = $_REQUEST["anumber"]; // remove whitespace
        $bnumber = $_REQUEST["bnumber"]; // remove whitespace
        $cnumber = $_REQUEST["cnumber"]; // remove whitespace
         if ($anumber == "" && $bnumber == "" && $cnumber = "") {
           // print("<p class=\"err\">NEBYLO VYPLNENO PŘIJÍMENÍ...</p>"."<br>");
          //  $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
          //  $errors[] = "surname";
        } else {
             
             
             print("<p class=\"info\">Počet kuřecích řízků ".$anumber."</p>");
                print("<p class=\"info\">Počet párků v rohlíku ".$bnumber."</p>");
                print("<p class=\"info\">Počet palačinek ".$cnumber."</p>");
             
            $foodsum = $anumber + $bnumber + $cnumber;
           
             
             $groupMoney = $peoplecount * ($anumber + $bnumber + $cnumber);
            /*
            řízek: 120kč
            párek: 30kč
            palačinka: 100kč
            */
             
             
            if ($foodsum == $peoplecount){
                print("<p class=\"info\">Počet lidí (".$peoplecount.") <span>ODPOVÍDÁ</span> počtu jídel (".$foodsum.")</p>");
                 print("<p class=\"info\">Celková cena za <span>".$peoplecount."</span> lidí a za <span>".$foodsum."</span> jídel, je <span>".$groupMoney."</span></p>");
            } else {
                print("<p class=\"info\">Počet lidí (".$peoplecount.") <span>NEODPOVÍDÁ</span> počtu jídel (".$foodsum.")</p>");
            }
         }
        
    }
    
?>
   <h1>Formulář</h1>
    
    <form action="filip.php" method="get">
   
        
        
 <!-----------------------------JMÉNO----------------------------->        
<label for="name">Počet lidí (musí odpovídat počtu jídel) </label>
<input type="number" name="peoplecount" placeholder="Enter number of food" value="<?php  if (isset($peoplecount)){print($peoplecount);}?>" class="<?php if(in_array("peoplecount", $errors)){print("marko");}?>" >
   <br>       
        
        
        
<!-----------------------------JMÉNO----------------------------->        
<label for="name">Jméno:* </label>
<input type="text" name="name" placeholder="Enter name" value="<?php  if (isset($name)){print($name);}?>" class="<?php if(in_array("name", $errors)){print("marko");}?>" >
   <br>
        
<!-----------------------------PŘIJÍMENÍ----------------------------->      
<label for="surname">Přijímení:* </label>
<input type="text" name="surname" placeholder="Enter surname" value="<?php  if (isset($surname)){print($surname);}?>" class="<?php if(in_array("surname",$errors)){print("marko");}?>" >
   <br>
        
        

 <!-----------------------------EMAIL NEBO TEL. Č----------------------------->   
<label for="email">Email:* </label>
 <input type="text" name="email" placeholder="Enter email" value="<?php if (isset($email)){print($email);}?>" class="<?php if(in_array("email",$errors)){print("marko");}?>" >
<br>
 
<label for="phone">Telefon:* </label>
    <input type="text" name="phone" placeholder="Enter your phone number" value="<?php if (isset($phone)){print($phone);}?>" class="<?php if(in_array("phone",$errors)) {print("marko");}?>" >
<br>
        
       
<!-----------------------------HLAVNÍ JÍDLO----------------------------->       
        
 
<label for = "terms">Počet kuřecích řízků: (120 Kč) </label>        
<input type = "number" name="anumber" value = "<?php if (isset($anumber)){print($anumber);}?>">
<br>
     
        
<label for = "terms">Počet párků v rohlíku: (30 Kč) </label>        
<input type = "number" name="bnumber" value = "<?php if (isset($bnumber)){print($bnumber);}?>">
<br>
     
        
<label for = "terms">Počet palačinek (100 Kč) </label>        
<input type = "number" name="cnumber" value = "<?php if (isset($cnumber)){print($cnumber);}?>">
<br>
     
        

        
    
        

        
        
        
        
        
        
        
        
   <!--     <br>
     <label for = "radio">iPhone Xs Max</label>
    <input type="radio" name = "radio" >
        <br>
     <label for = "radio">iPhone Xc</label>
    <input type="radio" name = "radio" >
        -->
        <br><br>
     
        
        
    <select name="soup">
    <option value="13">kuřecí polévka</option> 
<option value="20">hovězí polévka</option> 
    <option value="30">telecí polévka</option> 
    
        
    </select>
        
<label>Chci dezert</label>  
<input type="checkbox" name="terms" value=" terms" <?php if (isset($REQUEST["dessert"])){$terms = $_REQUEST["dessert"]; if ($terms == "agreed"){print"checked = \"checked\"";}}?>
       
       
        
   
    
    
    
    
   
    
    
        <br>
    
    <input type="submit" name="odeslat" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    



    <?php
}
?>
   
</body>
</html>
