<?php
$host='CONT_MYSQL_SP';
$port=3346;
$bd='SP_AP';
$user='root';
$pass='1160439';

$conn=mysqli_connect($host, $user, $pass, $bd, $port) or die ('Hubo un error en la conexion de la base de datos: '.mysqli_connect_error());

$query="UPDATE TB_ESTUDIANTES SET nombre='$_REQUEST[nombre_n]' WHERE matricula=$_REQUEST[matricula2]";
echo 'Nombre modificado con exito';

$consulta=mysqli_query($conn, $query) or die ('Hubo un error en la consulta de la informacion: '.mysqli_error($conn));

mysqli_close($conn);
?>
