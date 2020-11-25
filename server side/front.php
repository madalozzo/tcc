<?php
	
	/*
	 * Pluviam
	* Saulo Matte Madalozzo
	* saulo.zz@gmail.com
	* nov/2013
	*/
	
	ini_set('display_errors', 'On');
	error_reporting(E_ALL);
	
	include("misc/database/connectionTCC.php");
		
	if (!empty($_GET['pais']))  
	{
		$pais = pg_escape_string(substr($_GET['pais'], 0, 2)); 
	} else {
		$pais = "0";
	}
	
	if (!empty($_GET['uf'])) 
	{
		$uf = strtoupper(pg_escape_string(substr($_GET['uf'], 0, 2)));
	} else {
		$uf = "0";
	}
	
	if (!empty($_GET['cidade'])) 
	{
		$cidade = pg_escape_string($_GET['cidade']);
	} else {
		$cidade = "0";
	}
	
	if (!empty($_GET['estacao'])) 
	{
		$nomeEstacao = pg_escape_string($_GET['estacao']);
	} else {
		$nomeEstacao = "0";
	}
	
	//echo "$pais / $uf / $cidade / $nomeEstacao<br>";
	
	$sql = "select * from cidade, uf, estacao where cidade.cid_url = '$cidade' and uf.uf_sigla = '$uf' and estacao.est_url = '$nomeEstacao'";
	$result = pg_query($con, $sql);
	if (!$result) {
		echo "Erro2";
	}
	if( pg_num_rows($result) != 1){ // se retornou uma linha, continua, senao die die die...
		echo "Nenhuma estacao encontrada";
	}
	
	
	$row = pg_fetch_assoc($result);
	$est_nome = $row['est_nome'];
	define("PLUVIAM_DB_CODIGO", $row["est_cod"]);
	//$dbCodigo = $row["est_cod"];
	
	
	//echo "  ",PLUVIAM_DB_CODIGO;
	
	$sql = "
	select dmi_temp,
	dmi_umidade,
	dmi_pressao,
	dmi_chuva,
	dmi_ventomed,
	dmi_dirvento,
	dmi_datahora from dados_min where dmi_est_cod = '".PLUVIAM_DB_CODIGO."' order by dmi_datahora desc  LIMIT 30;";
	$result = pg_query($con, $sql);
	if (!$result) {
		echo "Erro2";
		exit;
	}
	
	$datahora = array();
	$temperatura = array();
	$umidade = array();
	$chuva = array();
	$vento = array();
	$dirVento = array();
	$pressao = array();
	$luz = array();
	
	while ($row = pg_fetch_assoc($result)) {
		$datahora[] = substr($row["dmi_datahora"], 11, 5);
		$temperatura[] = $row["dmi_temp"];
		$chuva[] = $row["dmi_chuva"];
		$umidade[] = $row["dmi_umidade"];
		$vento[] = round(($row["dmi_ventomed"]*2.4)/60,1);
		$dirVento[] = $row["dmi_dirvento"];
		$pressao[] = $row["dmi_pressao"]/100;
	}
	
	$sql = "select (sum(dmi_chuva)*0.343) as chuva from dados_min where dmi_est_cod = '".PLUVIAM_DB_CODIGO."';";
	$result = pg_query($con, $sql);
	if (!$result) {
		echo "Erro2";
		exit;
	}
	$row = pg_fetch_assoc($result);
	$chuvaTotal = $row["chuva"];
?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta http-equiv="refresh" content="60">
<link rel="icon" href="favicon.ico" type="image/x-icon">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<title>
<?php echo $est_nome?> - TCC
</title>
 
	<style>
	.agoraMedida {
		font-family: Arial,Helvetica,sans-serif;
		color: #333333;
		font-weight: bold;
		font-size: 36px;
	}
	.agoraUnidade {
		font-family: Arial,Helvetica,sans-serif;
		font-size: 14px;
		color: #333333;
	}
	.agoraDescricao {
		font-family: Arial,Helvetica,sans-serif;
		font-size: 12px;
	}
	.agoraDuvida {
		border: 1px dashed #999999;
		font-weight: bold;
		font-family: Arial,Helvetica,sans-serif;
		font-size: 16px;
	}
	td.agorabarra {
		border-right: 2px solid #EAEAEA;
	}
	</style>
 

	<script type="text/javascript" src="http://www.google.com/jsapi"></script>
	<script type="text/javascript">
	google.load('visualization', '1', {packages: ['corechart']});
	</script>
	 
 
	<script type="text/javascript">
	
	
	function drawTemperatura() {
		var data = google.visualization.arrayToDataTable([
			['Hora', '°c'],
			<?php
				for($i = 0; $i < 30; $i++)
				{
					echo   "['", $datahora[$i],"',", $temperatura[$i], "],"; 
				}	
			?>
		]);
		var options = {
			hAxis:{direction: -1}, 
			colors:['red'],
			legend: {position: 'none'},
			width: 1000, height: 300,  
			title: 'Temperatura - °C',
			vAxis: {minValue: 0},
			isStacked: true
		};
		var chart = new google.visualization.LineChart(document.getElementById('temperatura'));
		chart.draw(data, options);
	}
	
	
	function drawUmidade() {
		var data = google.visualization.arrayToDataTable([
			['Hora', '%'],
			<?php
				for($i = 0; $i < 30; $i++)
				{
					echo   "['", $datahora[$i],"',", $umidade[$i], "],"; 
				}	
			?>
		]);
		
		var options = {
			hAxis:{direction: -1}, 
			colors:['blue'],
			legend: {position: 'none'},
			width: 1000, height: 300,  
			title: 'Umidade - %',
			vAxis: {maxValue: 5},
			isStacked: true
		};
		var chart = new google.visualization.LineChart(document.getElementById('umidade'));
		chart.draw(data, options);
	}
	
	function drawVento() {
		var data = google.visualization.arrayToDataTable([
			['Hora', 'km/h'],
			<?php
				for($i = 0; $i < 30; $i++)
				{
					echo   "['", $datahora[$i],"',", $vento[$i], "],"; 
				}	
			?>
		]);
		
		var options = {
			hAxis:{direction: -1}, 
			colors:['blue'],
			legend: {position: 'none'},
			width: 1000, height: 300,  
			title: 'Vento - km/h',
			isStacked: true
		};
		var chart = new google.visualization.LineChart(document.getElementById('vento'));
		chart.draw(data, options);
	}
	function drawPressao() {
		var data = google.visualization.arrayToDataTable([
			['Hora', 'hPa'],
			<?php
				for($i = 0; $i < 30; $i++)
				{
					echo   "['", $datahora[$i],"',", $pressao[$i], "],"; 
				}	
			?>
		]);
		var options = {
			hAxis:{direction: -1}, 
			colors:['green'],
			legend: {position: 'none'},
			width: 1000, height: 300,  
			title: 'Pressão - hPa',
			isStacked: true
		};
		var chart = new google.visualization.LineChart(document.getElementById('pressao'));
		chart.draw(data, options);	
	  
	}
	function drawChuva() 
	{
		var data = google.visualization.arrayToDataTable([
			['Dia', 'mm'],
			<?php
				for($i = 0; $i < 30; $i++)
				{
					//echo   "['", $chuvaTrintaDiasDia[$i], "/", $chuvaTrintaDiasMes[$i], "/", $chuvaTrintaDiasAno[$i], "', ", $chuvaTrintaDiasChuva[$i], "],";  
					echo   "['", $datahora[$i],"',", $chuva[$i]*0.343, "],";
				}	
			?>
		]);
		var options = {
			hAxis:{direction: -1},
			legend: {position: 'none'},
			width: 1000, height: 300,  
			title: 'Chuva - mm',
			//vAxis: {title: 'mm'},
			isStacked: true
		};
		var chart = new google.visualization.SteppedAreaChart(document.getElementById('chuva'));
		chart.draw(data, options);
	}
	google.setOnLoadCallback(drawTemperatura);
	google.setOnLoadCallback(drawUmidade);
	google.setOnLoadCallback(drawPressao);
	google.setOnLoadCallback(drawVento);
	google.setOnLoadCallback(drawChuva);
	</script>

	<?php 

    // {{{ calculateDewPoint()
    /**
     * Calculate dewpoint from temperature and humidity
     * This is only an approximation, there is no exact formula, this
     * one here is called Magnus-Formula
     *
     * Temperature has to be entered in deg C!
     *
     * @param   float                       $temperature
     * @param   float                       $humidity
     * @return  float
     * @access  public
     * @link    http://www.faqs.org/faqs/meteorology/temp-dewpoint/
     */
    function calculateDewPoint($temperature, $humidity)
    {
        if ($temperature >= 0) {
            $a = 7.5;
            $b = 237.3;
        } else {
            $a = 7.6;
            $b = 240.7;
        }

        // First calculate saturation steam pressure for temperature
        $SSP = 6.1078 * pow(10, ($a * $temperature) / ($b + $temperature));

        // Steam pressure
        $SP  = $humidity / 100 * $SSP;

        $v   = log($SP / 6.1078, 10);

        return ($b * $v / ($a - $v));
    }

		while ($row = pg_fetch_assoc($result)) {

			$PdirVento = $row["dirvento"];
			$Pvento = round(($row["ventomed"]*2.4)/60,1);

		}
		
		//ponto de orvalho
		$PpontoOrvalho = round(calculateDewPoint($temperatura[0],$umidade[0]),1);
	
		//direcao do vento
		
		//N  - 0
		//NE - 5
		//E  - 3
		//SE - 7
		//S  - 1
		//SO - 6
		//O  - 2
		//NO - 4
		$PdirVento = $dirVento[0];
		if ($vento[0] != 0){
			if ($PdirVento == 0){
				$PdirVento = "N";
				$PdirVentoDesc = "; origem Norte";
			}
			else if ($PdirVento == 5){
				$PdirVento = "NE";
				$PdirVentoDesc = "; origem Nordeste";
			}
			else if ($PdirVento == 3){
				$PdirVento = "E";
				$PdirVentoDesc = "; origem Este";
			}
			else if ($PdirVento == 7){
				$PdirVento = "SE";
				$PdirVentoDesc = "; origem Sudeste";
			}
			else if ($PdirVento == 1){
				$PdirVento = "S";
				$PdirVentoDesc = "; origem Sul";
			}
			else if ($PdirVento == 6){
				$PdirVento = "SW";
				$PdirVentoDesc = "; origem Sudoeste";
			}
			else if ($PdirVento == 2){
				$PdirVento = "W";
				$PdirVentoDesc = "; origem Oeste";
			}
			else if ($PdirVento == 4){
				$PdirVento = "NW";
				$PdirVentoDesc = "; origem Noroeste";
			}
			else if ($PdirVento == 8){ //tem vento, mas nao sabe a direcao
				$PdirVento = "";
				$PdirVentoDesc = "";
			}

		}
		else
		{
			$PdirVento = "";
			$PdirVentoDesc = "";
		}	
		?>	


	</head>

	<body style="font-family: Arial;border: 0 none;">

		<div id="tituloPagina" style="width: 1000px; height: 50px; margin: auto;text-align:center; margin-top:15px">
			<b>Estação Meteorológica Automática Experimental - <?php echo $est_nome; ?></b></br>
		</div>
		<div id="hora" style="width: 800px; height: auto; margin: 10px auto">
			<small>Última atualização: <b><?php echo $datahora[0]?></b></small>
			
		</div>
		<div>
			<table style="margin:auto;">
				<tbody>
					<tr>
						<td style="min-width: 130px;text-align: center" class="agorabarra" title="Temperatura <?php echo $temperatura[0]; ?> graus Celsius. Ponto de orvalho <?php echo $PpontoOrvalho; ?>">
							<img border="0" src="imgs/PThermometer_Hot.png"/><br/>
							<span class="agoraDescricao">Temperatura</span><br/>
							<span class="agoraMedida"><?php echo $temperatura[0]; ?></span>
							<span class="agoraUnidade">°C</span>
						</td>
						<td style="min-width: 130px;text-align: center" class="agorabarra" title="<?php echo $umidade[0]; ?> porcento (umidade relativa do ar)">
							<img border="0" src="imgs/PRaindrop.png"/><br/>
							<span class="agoraDescricao">Umidade</span><br/>
							<span class="agoraMedida"><?php echo $umidade[0]; ?></span>
							<span class="agoraUnidade">%</span>
						</td>
						<td style="min-width: 130px;text-align: center" class="agorabarra" title="<?php echo $pressao[0]; ?> hectopascais">
							<img border="0" src="imgs/PBarometer.png"/><br/>
							<span class="agoraDescricao">Pressão</span><br/>
							<span class="agoraMedida"><?php echo $pressao[0]; ?></span>
							<span class="agoraUnidade">hPa</span>
						</td>
						<td style="min-width: 130px;text-align: center" class="agorabarra" title="<?php echo $vento[0]; ?> kilometros por hora<?php echo $PdirVentoDesc; ?>">
							<img border="0" src="imgs/PWind.png"/><br/>
							<span class="agoraDescricao">Vento</span><br/>
							<span class="agoraMedida"><?php echo $vento[0]; ?></span>
							<span class="agoraUnidade">km/h </span><span class="agoraMedida"><?php echo $PdirVento; ?></span>
						</td>
						<td style="min-width: 130px;text-align: center" title="<?php echo round($chuvaTotal,1); ?> mm ">
							<img border="0" src="imgs/PUmbrella.png"/><br/>
							<span class="agoraDescricao" style="white-space:nowrap">Chuva Hoje</span><br/>
							<span class="agoraMedida"><?php echo round($chuvaTotal,1); ?></span>
							<span class="agoraUnidade">mm</span>
						</td>
					</tr>
				</tbody>
			</table>
			
		</div>
		
		<div id="precipitacao" style="width: 1000px; height: 65px; margin: auto; text-align:center">
			<br/><br/>

		</div>
		<div id="semjscript">
			<noscript>
			<table style="text-align: left; margin-left: auto; margin-right: auto;">
			<tbody>
			<tr>
			<td>
			<p class="semjava">Para que
			esta pagina funcione adequadamente o navegador
			precisa suportar JavaScript.
			</p>
			</td>
			</tr>
			</tbody>
			</table>
			</noscript>
		</div>
		<div id="temperatura" style="width: 1000px; height: 300px; margin: auto"></div>
		<div id="umidade" style="width: 1000px; height: 300px; margin: auto"></div>
		<div id="chuva" style="width: 1000px; height: 300px; margin: auto"></div>
		<div id="pressao" style="width: 1000px; height: 300px; margin: auto"></div>
		<div id="vento" style="width: 1000px; height: 300px; margin: auto"></div>

		
		<div style="text-align:right">
			<small>2013 Saulo Matté Madalozzo | saulo.zz@gmail.com</small>
		</div>
	</body>
</html>

<?php 
	pg_close($con);
?>

