<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Skoro iDes</title>
</head>

<body>
<h1>Noviny</h1>	
<?php
	
$servername = "localhost";
$username = "root";
$password = "mysql";
$db = "renome";
// Create connection
$conn = mysqli_connect($servername, $username, $password,$db);
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error());
}
//echo "Connected successfully";	
mysqli_query($conn,"SET CHARACTER SET utf8");	
	
if (isset($_REQUEST["id"])){
	$id = $_REQUEST["id"];
}else{
	$id = "";
}
    
    
if (isset($_REQUEST["cathegory"])){
    $cat = $_REQUEST["cathegory"];
}
if (isset($_REQUEST["aktualnistrana"])){
	$aktualnistrana = $_REQUEST["aktualnistrana"];
}else{
	$aktualnistrana = 1;
}
	
$zaznamunastranu = 5;
	
if ($id == ""){	
	
	$sql = "SELECT ";
	$sql = $sql."count(idtarticle) as pocetzaznamu ";
	$sql = $sql."FROM renome_tarticle ra ";
	
	
	//print("<p>".$sql."</p>");
	
	$result = mysqli_query($conn, $sql);	
	
	$row = mysqli_fetch_assoc($result);
	
	$pocetzaznamu = $row["pocetzaznamu"];
	
	$stran = ceil($pocetzaznamu/$zaznamunastranu);
	
	print("<p>".$pocetzaznamu." / ".$zaznamunastranu." / ".$stran."</p>");
	
	for($i=1;$i<=$stran;$i++){
		print("<a href=\"noviny.php?aktualnistrana=".$i."\">".$i."</a> ");
	}	
	
	$sql = "SELECT ";
	$sql = $sql."ra.idtarticle, ra.heading, ra.viewedcount, ra.descr, rr.surname, rr.name ";
	$sql = $sql."FROM renome_tarticle ra ";
	$sql = $sql."LEFT JOIN renome_treporter rr ON rr.idcreporter = ra.idcreporter ";	
	$sql = $sql."LIMIT ".(($aktualnistrana-1)*$zaznamunastranu).", ".$zaznamunastranu;	
	
	print("<p>".$sql."</p>");
	
	$result = mysqli_query($conn, $sql);	
	if (mysqli_num_rows($result) > 0) {
		while($row = mysqli_fetch_assoc($result)) {
			print("<h2 id=\"c".$row["idtarticle"]."\">");
			print("<a href=\"noviny.php?id=".$row["idtarticle"]."&aktualnistrana=".$aktualnistrana."\">");
			print($row["heading"]."</a></h2>");
			if ($row["name"]<>""){
				print("<p>".$row["name"]." ".$row["surname"]."</p>");
			}
            
            if ($row["viewedcount"]<>""){
				print("<p>".$row["viewedcount"]."</p>");
			}
            
            
			print("<div><p>".$row["descr"]."</p></div>");
		}
	}
    
    
    
    for($i=1;$i<=$stran;$i++){
		print("<a href=\"noviny.php?aktualnistrana=".$i."\">".$i."</a> ");
	}
    
    
  
// STEP 1 --------------------------------------------------------------------------------------------------------
    $sqlo = "SELECT name, idccathegory FROM renome_ccathegory"; //   $k = 2;          WHERE idccathegory = ".$k;
    print("<p>".$sql."</p>");
    $resulto = mysqli_query($conn, $sqlo);	
	if (mysqli_num_rows($resulto) > 0) {
		while($row = mysqli_fetch_assoc($resulto)) {
			// print("<h2 style='color: green'>".$row["name"]."</h2>");
            print("<a style='color: green' href ='noviny.php?cathegory=".$row["idccathegory"]."'>".$row["name"]."</a><br>");
        }
    } 
}
    
    
// STEP 2 --------------------------------------------------------------------------------------------------------
// cat is defined ABOVE in $_REQUEST["cat"]
    
if ($cat != "") {
    
    $stop = 0;
    
    $sqln = "SELECT heading, text, viewedcount FROM renome_tarticle WHERE idccathegory = ".$cat;
   // $sqln = $sqln."LIMIT 5";
    $result = mysqli_query($conn, $sqln);	
	
      print("<script>document.querySelector('body').innerHTML = ''</script>");
	if (mysqli_num_rows($result) > 0) {
		while($row = mysqli_fetch_assoc($result)) {
          
            if ($stop < 1){
                
            
            print("<a href=\"noviny.php?aktualnistrana=".$aktualnistrana ."\">zpet na seznam</a>");
            print("<h2>".$row["heading"]."</h2>");
            print("<p>".$row["text"]."</p>");
                
            print("<h2 style='color: green'>".Zobrazuji." ".další." ".články." ".z." ".kategorie.":</h2>");
                $stop += 1;
            } else {
                if ($stop < 4){
                    
                print("<a href=\"noviny.php?&aktualnistrana=".$aktualnistrana."\">".$row[heading]." (".$row[viewedcount].")</a><br>");
                // print("<h2>".$row["heading"]."</h2>");
                $stop += 1;
                }
                
            }
           
            // http://127.0.0.1/noviny/noviny.php?cathegory=14
          
          // 1 - 3 články ze stejné kategorie, ketré jsou nejčtenější
            
        }
        
       
        
      }
    
  /*   $array = array();
        while($row = $result->fetch_assoc()){
            $array[] = $row; 
        }
        print(sizeof($array));
    
   while($row = mysqli_fetch_assoc($result)){
                   print("<h2>".$row["text"]."</h2>");
   }*/
        
       /* for ($i = 0; i < count($array); $i++){
           // print("".$row["text"]."");
            print($i + ", ");
        }*/
   }
    
    
    
    // T2
    
    
if ($id != ""){//zobrazeni konktretniho clanku
	$sql = "SELECT idtarticle, heading, text FROM renome_tarticle WHERE idtarticle = ".$id;
	//print($sql);
	
	$result = mysqli_query($conn, $sql);	
	
	if (mysqli_num_rows($result) > 0) {
		while($row = mysqli_fetch_assoc($result)) {
			print("<a href=\"noviny.php?aktualnistrana=".$aktualnistrana."#c".$row["idtarticle"]."\">zpet na seznam</a>");
			print("<h2>".$row["heading"]."</h2>");
			print("<div><p>".$row["text"]."</p></div>");
		}
	}		
}
	
mysqli_close($conn);	
	
?>	
	
</body>
</html>
