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
</style>
   
    
    
</head>

<body>

<ul>
    <li><a href="filip.php?sekce=hlavnistrana">hlavni strana</a></li>    
    <li><a href="filip.php?sekce=formular">formular</a></li>    
</ul>    

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
        
        $name = trim($_REQUEST["name"]); // remove whitespace
        $characters = "qwertzuioplkjhgfdsayxcvbnmQWERTZUIOPLKJHGFDSAMNBVCXYěščřžýáíéĚŠČŘŽÝÁÍÉ ";
        
        if ($name == "") {
            print("<p class=\"err\">NEBYLO VYPLNENO JMENO...</p>"."<br>");
            $nameerr = "NEBYLO VYPLNĚNO JMÉNO";
             $errors[] = "name";
        } else {
            
            
            if (strlen($name) > 2) {
                // namelenerr = "NEDOSTATEČNÁ DÉLKA JMÉNA";
                for ($i = 0; $i<strlen($name); $i++){
                   // print(($i + 1).". ".$name[$i]."<br>");
                    $pos = strpos($characters, $name[$i]); 
                        
                    if ($pos === false) {
                         print("Jméno nesmí obsahovat znak: ".$name[$i]."<br>");
                    } 
                }
            } else {
                print("<p class=\"notice\">Jméno má nedostatčnou délku (musí mít minimálně 2 znaky)");
            }
        }
        
          $surname = trim($_REQUEST["surname"]); // remove whitespace
         if ($surname == "") {
            print("<p class=\"err\">NEBYLO VYPLNENO PŘIJÍMENÍ...</p>"."<br>");
            $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
             $errors[] = "surname";
        } else {
            
            
            if (strlen($surname) > 2) {
                // namelenerr = "NEDOSTATEČNÁ DÉLKA JMÉNA";
                for ($i = 0; $i<strlen($surname); $i++){
                   // print(($i + 1).". ".$name[$i]."<br>");
                    $pos = strpos($characters, $surname[$i]); 
                        
                    if ($pos === false) {
                        // print("Přijímení nesmí obsahovat znak: ".$surname[$i]."<br>");
                        print("<p class=\"notice\">Přijímení nesmí obsahovat znak: ".$surname[$i]."<br>");
                    } 
                }
            } else {
                print("<p class=\"notice\">Přijímení má nedostatčnou délku (musí mít minimálně 2 znaky)");
            }
        }
        
        
        
        
        /*
        $surname = $_REQUEST["surname"];
        if ($surname == "") {
            print("<p class=\"err\">NEBYLO VYPLNENO PRIJIMENI...</p>");
            $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
            $errors[] = "surname";
        }*/
        
        
        
        
        
        
        
        
        $password = $_REQUEST["password"];
        if ($password == "") {
            print("<p class=\"err\">NEBYLO VYPLNENO HESLO...</p>");
            $passworderr = "NEBYLO VYPLNĚNO HESLO";
              $errors[] = "password";
        }
        
        
        
        $email = $_REQUEST["email"];
        if ($email == "") {
             print("<p class=\"err\">NEBYL VYPLNEN EMAIL...</p>");
            $emailerr = "NEBYLO VYPLNĚN EMAIL";
             $errors[] = "email";
        }
        
        $phone = $_REQUEST["phone"];
        if ($phone == "") {
             print("<p class=\"err\">NEBYLO VYPLNĚNO TELEFONÍ ČÍSLO...</p>");
            $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
              $errors[] = "phone";
        }
        
        $gender = $_REQUEST["radio-gender"];
        if ($gender == "") {
            print("<p class=\"err\">NEBYLO VYPLNĚNO POHLAVÍ...</p>");
            $gendererr = "NEBYLO VYPLNĚNO POHLAVÍ";
              $errors[] = "radio-gender";
        }
        
        
        $terms = $_REQUEST["terms"];
        if ($terms == "") {
            print("<p class=\"err\">MUSÍTE SOUHLASIT S PODMÍNKAMI...</p>");
            $termserr = "MUSÍTE SOUHLASIT S PODMÍNKAMI";
              $errors[] = "terms";
        }
        
            $product = $_REQUEST["product"];
        if ($product == "") {
            print("<p class=\"err\">MUSÍTE VYBRAT ALESPOŇ 1 PRODUKT...</p>");
            $termserr = "MUSÍTE VYBRAT ALESPOŇ 1 PRODUKT";
              $errors[] = "product";
        }
        
    }
    
?>
   <h1>Formulář</h1>
    
    <form action="filip.php" method="get">
    <label for="name">Jméno:* </label>
<input type="text" name="name" placeholder="Enter name" value="<?php  if (isset($name)){print($name);}?>" class="<?php if(in_array("name", $errors)){print("marko");}?>" >
   <br>
        
        
    <label for="name">Přijímení:* </label>
<input type="text" name="surname" placeholder="Enter surname" value="<?php  if (isset($surname)){print($surname);}?>" class="<?php if(in_array("surname",$errors)){print("marko");}?>" >
   <br>
        
        
    <label for="password">Heslo:* </label>
<input type="password" name="password" placeholder="Enter password" value="<?php if (isset($password)){print($password);}?>" class="<?php if(in_array("password",$errors)){print("marko"); }?>" >
   <br>
         
        
<label for="email">Email:* </label>
 <input type="text" name="email" placeholder="Enter email" value="<?php if (isset($email)){print($email);}?>" class="<?php if(in_array("email",$errors)){print("marko");}?>" >
<br>
        


        
        <!--if (isset($_REQUEST["odeslat"]))-->
    <label for="phone">Telefon:* </label>
    <input type="text" name="phone" placeholder="Enter your phone number" value="<?php if (isset($phone)){print($phone);}?>" class="<?php if(in_array("phone",$errors)) {print("marko");}?>" >
<br>
        
        <label for="select">Select your product:</label>
        <br>
        <label for = "radio" name = "radio">iPhone XS</label>
    <input type="radio" name = "product" value="iPhone XS" <?php if (isset($product)) {$product = $_REQUEST["product"]; if($product == "iPhoneXS"){print "checked = \"checked\"";}} else {print("checked");}?>>
      <br>
         <label for = "radio" name = "radio">iPhone XS Max</label>
    <input type="radio" name = "product" value="iPhone XS Max" <?php if (isset($product)) {$product = $_REQUEST["product"]; if($product == "iPhoneXS Max"){print "checked = \"checked\"";}} else {print("checked");}?>>
     <br>
        
        <label for = "radio" name = "radio">iPhone Xr</label>
    <input type="radio" name = "product" value="iPhone Xr" <?php if (isset($product)) {$product = $_REQUEST["product"]; if($product == "iPhoneXr"){print "checked = \"checked\"";}} else {print("checked");}?>>
        
    <br>
   <!--     <br>
     <label for = "radio">iPhone Xs Max</label>
    <input type="radio" name = "radio" >
        <br>
     <label for = "radio">iPhone Xc</label>
    <input type="radio" name = "radio" >
        -->
        <br><br>
     
        
        
        
     <label for="select">Select your gender:</label>
    <br>
    <label for = "radio">Man</label>
    <input type="radio" name = "radio-gender">    
        </label>
    
    <label for = "radio">Woman</label>
    <input type="radio" name = "radio-gender">    
        </label>
    
    <br>
    <br>
    
    <label for = "terms">Souhlasím s podmínkami</label>
 <input type="checkbox" name="terms" value=" terms" <?php if (isset($REQUEST["terms"])){$terms = $_REQUEST["terms"]; if ($terms == "agreed"){print"checked = \"checked\"";}}?>
<br>
    
    
        <br>
    
    <input type="submit" name="odeslat" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    



    <?php
}
    
   // Homework - http://localhost/php-homew/index.php
?>
   
</body>
</html>
