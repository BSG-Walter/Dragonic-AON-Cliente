// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function lanzar(){
    if (online_activo()) {
        if (current_time < obj_online.attack_ready_at) return;
        obj_pj.atacaConArco = false;
    }
	if (obj_hechizos.seleccionado != -1) {

	    for (var i = 0; i < obj_hechizos.maximoHechizos; i++) {
	        if (obj_hechizos.seleccionado == obj_hechizos.hechizos[i].indice) {
	            break;
	        }
	    }
    
	    if (obj_pj.puedeAtacar) {
	        obj_pj.atacaConHechizo = true;
	    }
    
	}
	obj_tecla_lanzar.alarm[0] = 2;
}