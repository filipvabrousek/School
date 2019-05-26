# PHP

```html
<form action = "index.php">
<input type="text" name="inp">    
<input type="submit">
</form>
```

```php
<? echo $_GET["inp"] ?>
```

## 20
+ data ze souborů

```php
$name = "data/file.txt";

if (file_exists($name)){
    $file = fopen($name, "r");
    if ($file){
        while(!feof($file)){
            $line = fgets($file, 3000);
            print($line);
            print("<br>");
        }
    }
}
```



```php
function square($x){
    echo("Res".($x * $x));
}

square(6);

$f = explode(".", "12.23.24");
echo($f);
strtoupper("Filip");
trim("  Filip");
```


# SQL
```sql
SELECT * FROM renome_ccathegory WHERE idccathegory = 2 ORDER BY viewedcount ASC
SELECT * FROM renome_tarticle WHERE viewedcount > 10 ORDER BY viewedcount ASC
SELECT * FROM renome_ccathegory JOIN renome_tarticle ON viewedcount > 20
```



```php
<?php

$servername = "localhost";
$username = "root";
$password = "mysql";
$db = "renome";
    
$conn = mysqli_connect("localhost", "root", "mysql", "renome");
    
if (!$conn){
    die("Connection failed ".mysqli_connect_error());
}
    
mysqli_query($conn, "SET CHARACTER SET utf8");
    
$sql = "SELECT name, idccathegory FROM renome_ccathegory";
$res = mysqli_query($conn, $sql);
    
if (mysqli_num_rows($res) > 0) {
    while ($row = mysqli_fetch_assoc($res)){
        print("<a style='color: green' href ='novinyb.php?cathegory=".$row["idccathegory"]."'>".$row["name"]."</a><br>");
    }
}
    

if isset($_REQUEST["cathegory"]){
    print("<p></p>");
}
    
mysqli_close($conn);
    
    
    /*
    
    if ($cat != "") {
    
    $stop = 0;
    
    $sqln = "SELECT heading, text, viewedcount, idtarticle FROM renome_tarticle WHERE idccathegory = ".$cat;
    $sqln = $sqln." ORDER BY viewedcount DESC";
    $sqln = $sqln." LIMIT 4";
    $result = mysqli_query($conn, $sqln);	
	
      print("<script>document.querySelector('body').innerHTML = ''</script>");
    
	if (mysqli_num_rows($result) > 0) {
		while($row = mysqli_fetch_assoc($result)) {
        
          print("<h2>".$row["heading"]."</h2>");
    */
?>	
...
```



# PHP Function

```php
echo "<br>";
echo date(l);  //FRIDAY
echo "<br>";
echo pi();
echo "<br>";
echo abs(-2);

```
