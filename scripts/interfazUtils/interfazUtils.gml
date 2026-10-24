// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function interfazUtils() {

}

function mostrar_hechizos() {
	if (obj_tecla_hechizos.visible && !obj_tecla_inventario.visible) {
	    obj_inventario.visible = false;
	    obj_hechizos.visible = true;
	    obj_tecla_T.visible = false;
	    obj_tecla_lanzar.visible = true;
	    obj_tecla_U.image_index = 2;
	    obj_tecla_hechizos.alarm[0] = 1;
	}
}

function mostrar_inventario(){
    if (obj_tecla_inventario.visible && !obj_tecla_hechizos.visible) {
        obj_inventario.visible = true;
        obj_hechizos.visible = false;
        obj_tecla_T.visible = true;
        obj_tecla_lanzar.visible = false;
        obj_tecla_U.image_index = 0;
        obj_tecla_inventario.alarm[0] = 1;
    }
}

function indicar_panel_hechizos(primer_panel_estado){
    if (!obj_inventario.visible) {
		obj_hechizos.primerPanel = primer_panel_estado;
    }
}

function alternar_panel_hechizos(){
	indicar_panel_hechizos(!obj_hechizos.primerPanel);
}