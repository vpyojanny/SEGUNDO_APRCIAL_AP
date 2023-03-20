<?php

$host='CONT_MYSQL_SP';
$port=3346;
$bd='SP_AP';
$user='root';
$pass='1160439';
$matricula=$_REQUEST['matricula'];

$conn=mysqli_connect($host, $user, $pass, $bd, $port) or die ('Hubo un error en la conexion de la base de datos: '.mysqli_connect_error());

$query="SELECT * FROM TB_ESTUDIANTE WHERE matricula=$matricula";

$consulta=mysqli_query($conn, $query) or die ('Hubo un error en la consulta de la informacion: '.mysqli_error($conn));

if($obj=mysqli_fetch_object($consulta)){
	?>

	<form action="mostrar.php" method="post">
		Inserte el nuevo nombre:
		<input type="text" name="nombre_n" value="<?php echo $obj->nombre?>">
		<input type="hidden" name="matricula2" value="<?php echo $obj->matricula?>">
	</form>
	<?php 
}
else{
	echo 'No existe alumno registrado con esa matricula.';
}

mysqli_close($conn);
?>