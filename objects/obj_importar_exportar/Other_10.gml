/// @description chequeamos si podemos importar o exportar
// You can write your code in this editor
if (global.online_elegir) { estado = 0; exit; }
pj = obj_control_seleccionarPJ.elegido;
if (pj == -1) {
	estado = 0;
	exit;
}

if (file_exists("partida" + string(pj) + ".ini")){
	estado = 2;
}else{
	estado = 1;
}
