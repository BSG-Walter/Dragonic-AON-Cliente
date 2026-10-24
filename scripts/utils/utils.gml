// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function is_ingame_room(){
	return !(room == rm_inicio || room == rm_EBGames || room == rm_crearPJ || room == rm_nombrePJ || room == rm_creditos || room == rm_menuPrincipal || room == rm_opciones || room == rm_seleccionarPJ)
}

function is_special_room(){
	return (room == rm_arena)
}

function bloqueadoPorBandoArena(_idNPC){
	if (room == rm_arena && obj_pj.pk == _idNPC.pk) {
		var _info = instance_create_depth(x, y, 0, obj_INFO);
		_info.texto = "¡No podés atacar a los de tu bando en la arena!";
		return true;
	}
	return false;
}

function esMapaDescubierto() {
	return (
		room != rm_83 && room != rm_84 && room != rm_85 && room != rm_86 && room != rm_87 && room != rm_88 && room != rm_89 && room != rm_90 && room != rm_91 && room != rm_92 && room != rm_93 && room != rm_158 && room != rm_159
	);
}

function esMapaPolo() {
	return (
		room == rm_4 ||
		room == rm_5 ||
		room == rm_6 ||
		room == rm_7 ||
		room == rm_8 ||
		room == rm_9 ||
		room == rm_10 ||
		room == rm_12 ||
		room == rm_15 ||
		room == rm_17
	);
}
