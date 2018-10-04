<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Formulář</title>
    
 <style>
    
    /*POD TO NAPSAT NEVYPLNĚNO + OZNAČIT POLE !!!!! */
    input[type="text"],input[type="email"], input[type="password"]  {
        padding: 0.3em;
        border-radius: 6px;
        border-color: #1abc9c;
        margin-bottom: 1em;
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
    
    .new {
        margin: 2em;
        border: red 1px solid;
    }
     
     #marko{
         border: 6px solid red;
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
    print("<h1>Uvodni strana</h1>");
    
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
        
        $name = trim($_REQUEST["name"]); // remove whitespace
        $characters = "qwertzuioplkjhgfdsayxcvbnm";
        
        if ($name == "") {
            print("NEBYLO VYPLNENO JMENO..." . "<br>");
            $nameerr = "NEBYLO VYPLNĚNO JMÉNO";
             $errors[] = "name";
        } else {
            
            
            if (strlen($name) > 2) {
                // namelenerr = "NEDOSTATEČNÁ DÉLKA JMÉNA";
                for ($i = 0; $i<strlen($name); $i++){
                   // print(($i + 1).". ".$name[$i]."<br>");
                    $pos = strpos($characters, $name[$i]); 
                        
                    if ($pos === false) {
                        
                    } else {
                       print("NEPOVOLENÝ ZNAK: ".$name[$i]."<br>");
                    }
                }
            }
        }
        
        $surname = $_REQUEST["surname"];
        if ($surname == "") {
            print("NEBYLO VYPLNENO PRIJIMENI..." . "<br>");
            $surnameerr = "NEBYLO VYPLNĚNO PŘIJÍMENÍ";
            $errors[] = "surname";
        }
        
        $password = $_REQUEST["password"];
        if ($password == "") {
            print("NEBYLO VYPLNENO HESLO" . "<br>");
            $passworderr = "NEBYLO VYPLNĚNO HESLO";
              $errors[] = "password";
        }
        
        
        
        $email = $_REQUEST["email"];
        if ($email == "") {
            print("NEBYL VYPLNEN EMAIL" . "<br>");
            $emailerr = "NEBYLO VYPLNĚN EMAIL";
             $chybnapole[] = "email";
        }
        
        $phone = $_REQUEST["phone"];
        if ($phone == "") {
            print("NEBYLO VYPLNENO TELEFONNÍ ČÍSLO" . "<br>");
            $phoneerr = "NEBYLO VYPLNĚNO MOBILNÍ ČÍSLO";
              $errors[] = "phone";
        }
        
        $gender = $_REQUEST["gender"];
        if ($gender == "") {
            print("NEBYLO VYPLNENO POHLAVÍ");
            $gendererr = "NEBYLO VYPLNĚNO POHLAVÍ";
              $errors[] = "gender";
        }
        
        
        $terms = $_REQUEST["terms"];
        if ($terms == "") {
            print("MUSÍTE SOUHLASIT S PODMÍNKAMI");
            $termserr = "MUSÍTE SOUHLASIT S PODMÍNKAMI";
              $errors[] = "terms";
        }
        
    }
    
?>
   <h1>Formular</h1>
    
    <form action="filip.php" method="get">
    <label for="name">Jméno:* </label>
<input class= "txt" type="text" name="name" placeholder="Name" value="<?php  if (isset($name)){print($name);}?>" id="<?php if(in_array("name",$errors)){print("marko");}?>" >
   <br>
        
    <label for="password">Password:* </label><input type="password" name="password" value="<?php
    if (isset($password)) {
        print($password);
    }
?>">
  <br>
        
        
        
            <label for="email">Email:* </label><input type="email" name="email" value="<?php
    if (isset($email)) {
        print($email);
    }
?>"><br>
        
            <label for="gender">Pohlaví:* </label><input type="text" name="gender" value="<?php
    if (isset($gender)) {
        print($gender);
    }
?>"><br>
        
        <!--if (isset($_REQUEST["odeslat"]))-->
        <label for="phone">Telefon:* </label><input type="text" name="phone" value="<?php
    if (isset($phone)) {
        print($phone);
    }
?>"> <!--<br> --->
        
        
       <br>
        <label for="select">Select:</label>
        
        <label for = "radio">iPhone XS</label>
    <input type="radio" name = "radio" checked = "checked">
        <br>
     <label for = "radio">iPhone Xs Max</label>
    <input type="radio" name = "radio" checked = "checked">
        <br>
     <label for = "radio">iPhone Xc</label>
    <input type="radio" name = "radio" checked = "checked">
        
        <br>
       
    <label for = "radio">Man</label>
    <input type="radio" name = "radio" checked = "checked">    
        </label>
    
    <label for = "radio">Woman</label>
    <input type="radio" name = "radio">    
        </label>
    
    <br>
    
    
     <label for = "terms">Souhlasím s podmínkami užití.</label>
        <input type = "checkbox" name = "terms" value = "<?php
    if (isset($terms)) {
        print($terms);
    }
?>">
    <span style="color: red"> <?php
    if (isset($_REQUEST["odeslat"])) {
        print $termserr;
    }
?></span> 
        <br>
    
    <input type="submit" name="odeslat" value="Odešli data">
        
    <input type="hidden" name="sekce" value="formular">
    </form>
    



    <?php
}
?>
   
</body>
</html>
