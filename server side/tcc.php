<?php
/*
 * Pluviam
 * Saulo Matte Madalozzo 
 * saulo.zz@gmail.com
 * nov/2013
 */ 

ini_set('display_errors', 'On');
error_reporting(E_ALL);


include("connectionTCC.php");

function roundDown($hour) {
	return ((floor($hour/5)) * 5);
}


//validar url

//CODIGO
if (!empty($_GET['cd'])) //codigo da estacao no banco - validar para numeros
{
	$inCodigo = pg_escape_string(substr($_GET['cd'], 0, 5));
} else {
	$inCodigo = "0";
	dropFlow();
}

$sql = "select est_cod, est_sandbox, est_token, est_senha from estacao where est_login='$inCodigo'";
$result = pg_query($con, $sql);

if( pg_num_rows($result) != 1){ // se retornou uma linha, continua, senao die die die...
	dropFlow();		
}

$row = pg_fetch_assoc($result);
	define("PLUVIAM_DB_CODIGO", $row["est_cod"]); 
	//$dbCodigo = $row["est_cod"];
	define("PLUVIAM_DB_SANDBOX", $row["est_sandbox"]);
	//$dbSandbox = $row["est_sandbox"];
	define("PLUVIAM_DB_TOKEN", $row["est_token"]);
	//$dbToken = $row["est_token"];
	define("PLUVIAM_DB_SENHA", $row["est_senha"]);
	//$dbSenha = $row["est_senha"];


//SENHA
if (!empty($_GET['pw'])) //pega a senha e valida 
{
	$inPassword = pg_escape_string(substr($_GET['pw'], 0, 16)); //a senha tem 8, se tiver mais jah da erro na proxima, por isso pega 9 e se tiver mais da erro =)
} else {
	$inPassword = "0";
	dropFlow();
}

if (hash('sha256',$inPassword, false) != PLUVIAM_DB_SENHA){
	dropFlow();
}



//TOKEN
if (!empty($_GET['tk'])) //token de seguranca
{
	$inToken = pg_escape_string(substr($_GET['tk'], 0, 8)); //mesmo esquema da senha, bancou o engracadinho e tentou adicionar algo a mais vai se f&$@!#...
} else {
	$inToken = "0";
	dropFlow();
}

if (hash('sha256',$inToken, false) != PLUVIAM_DB_TOKEN){
	dropFlow(); //token diferente, parar.
}


if (!empty($_GET['st']) && is_numeric($_GET['st'])) //tempo que o source esta ligado em ms - validar para numeros
{
   $inSourceTime = $_GET['st'];
} else {
   $inSourceTime = "0";
   dropFlow();
}


$quantDados = 0;

if (isset($_GET['tp']) && is_numeric($_GET['tp'])) //temperatura sensor 1 - validar numeros
{
   $inTemperatura = $_GET['tp'];
   $quantDados++;
} else {
   $inTemperatura = "-99.99"; //no temp...
}

if (isset($_GET['pr']) && is_numeric($_GET['pr'])) //pressao - validar numeros
{
   $inPressao = (int)$_GET['pr'];
   $quantDados++;
} else {
   $inPressao = "100000";
}


if (isset($_GET['um']) && is_numeric($_GET['um'])) //umidade - validar numeros
{
   $inUmidade = $_GET['um'];
   $quantDados++;
} else {
   $inUmidade = "0";
}

if (isset($_GET['lu']) && is_numeric($_GET['lu'])) //luminosidade - validar numeros
{
   $inLuz = (int)$_GET['lu'];
   $quantDados++;
} else {
   $inLuz = "-1";
}

if (isset($_GET['ch']) && is_numeric($_GET['ch'])) //chuva - validar numeros
{
   $inChuva = (int)$_GET['ch'];
   $quantDados++;
} else {
   $inChuva = "0";
}

if (isset($_GET['vn']) && is_numeric($_GET['vn'])) //vento medio - validar numeros
{
   $inVentoMed = (int)$_GET['vn'];
   $quantDados++;
} else {
   $inVentoMed = "0";
}

if (isset($_GET['vx']) && is_numeric($_GET['vx'])) //vento maximo - validar numeros
{
   $inVentoMax = (int)$_GET['vx'];
   $quantDados++;
} else {
   $inVentoMax = "0";
}

if (isset($_GET['vm']) && is_numeric($_GET['vm'])) //vento minimo - validar numeros
{
   $inVentoMin = (int)$_GET['vm'];
   $quantDados++;
} else {
   $inVentoMin = "0";
}


if (isset($_GET['dv']) && is_numeric($_GET['dv'])) //direcao do vento - validar numeros
{
   $inDirVento = (int)$_GET['dv'];
   $quantDados++;
} else {
   $inDirVento = "-1";
}

if (isset($_GET['rd']) && is_numeric($_GET['rd'])) //radiacao beta e gama, solar etc
{
	$inRadiacao = (int)$_GET['rd'];
	$quantDados++;
} else {
	$inRadiacao = "-1";
}

if (isset($_GET['ra']) && is_numeric($_GET['ra'])) //raios, descargas atmosfericas
{
	$inRaio = (int)$_GET['ra'];
	$quantDados++;
} else {
	$inRaio = "0";
}

if ($quantDados == 0){
	dropFlow();
}


date_default_timezone_set('America/Sao_Paulo');
$format = 'Y-m-d H:i:s';
$dateNow = new DateTime();
$horaAgora = $dateNow->format("H");
$minutoAgora = $dateNow->format("i");
$segundoAgora = $dateNow->format("s");
$dateNow->setTime($horaAgora, $minutoAgora ,$segundoAgora);
$dateNowString = $dateNow->format($format);

//grava no banco

$sql = "INSERT INTO dados_min (dmi_est_cod, dmi_datahora, dmi_temp, dmi_pressao, 
dmi_umidade, dmi_luz, dmi_chuva, dmi_ventomax, dmi_ventomin, dmi_ventomed, dmi_dirvento,
dmi_raios, dmi_radiacao, dmi_real) 
VALUES ('".PLUVIAM_DB_CODIGO."', '$dateNowString', '$inTemperatura', '$inPressao', '$inUmidade', 
'$inLuz', '$inChuva', '$inVentoMax', '$inVentoMin', '$inVentoMed',
'$inDirVento', '$inRaio', '$inRadiacao', 'true')";


$res=pg_query($con, $sql);

// Verify and end the transaction as appropriate.
if (!$res) {
    pg_query($con, "ROLLBACK");  
} else {
    pg_query($con, "COMMIT");
    echo "1"; //all ok, send a message
}

pg_close($con);

?>
