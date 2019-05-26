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
    
$conn = mysqli_connect("localhost", "root", "mysql", "renome");
mysqli_query($conn, "SET CHARACTER SET utf8");
    
$res = mysqli_query($conn, "SELECT name, idccathegory FROM renome_ccathegory");
    
    
if (mysqli_num_rows($res) > 0) {
    while ($row = mysqli_fetch_assoc($res)){
        print("<a style='color: green' href ='novinyb.php?cathegory=".$row["idccathegory"]."'>".$row["name"]."</a><br>");
    }
}
    

$cat = $_REQUEST["cathegory"];
if (isset($cat)){
    
    $sqln = "SELECT heading FROM renome_tarticle WHERE idccathegory = ".$cat;
    $pres = mysqli_query($conn, $sqln);

    while ($row = mysqli_fetch_assoc($pres)){
        print("<p>".$row["heading"]."</p>");
    }
}
    
mysqli_close($conn);
?>	
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
