/// @description Dopas van bajando

if (online_activo()) exit;

if (obj_pj.tiempoDopa < obj_pj.tiempoDopaMax) {
	obj_pj.tiempoDopa++
	if (obj_pj.tiempoDopa == obj_pj.tiempoDopaMax - 10) {
		var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
        idINFO.padre = obj_pj.id;
        idINFO.texto = "Te estás volviendo débil...";
	}
	alarm[7] = SECOND
} else {
	obj_pj.tiempoDopa = obj_pj.tiempoDopaMax
	obj_pj.dopaFuerza = 0
	obj_pj.dopaAgilidad = 0
	var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
    idINFO.padre = obj_pj.id;
    idINFO.texto = "Te has debilitado";
}
	
