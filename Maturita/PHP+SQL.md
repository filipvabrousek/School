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


# SQL

```php
< ? php

$servername = "localhost";
$username = "root";
$password = "mysql";
$db = "renome";

// Create connection
$conn = mysqli_connect($servername, $username, $password, $db);

// Check connection
if (!$conn) {
	die("Connection failed: ".mysqli_connect_error());
}

mysqli_query($conn, "SET CHARACTER SET utf8");

if (isset($_REQUEST["id"])) {
	$id = $_REQUEST["id"];
} else {
	$id = "";
}

$sqlo = "SELECT name, idccathegory FROM renome_ccathegory";
print("<p>".$sql."</p>");
$resulto = mysqli_query($conn, $sqlo);

if (mysqli_num_rows($resulto) > 0) {
	while ($row = mysqli_fetch_assoc($resulto)) {
		print("<a style='color: green' href ='noviny.php?cathegory=".$row["idccathegory"].
			"'>".$row["name"].
			"</a><br>");
	}
}

...
```
