/// @description  Quita invisibilidad

if (online_activo()) exit;

if (invisible) {
	invisible = false;
	var idINFO = instance_create_depth(x, y, 0, obj_INFO);
	idINFO.padre = id;
	idINFO.color = make_color_rgb(211, 90, 211);
	idINFO.texto = "¡Visible!"; 
	idINFO.tiempo = 180;
}

with (obj_persona) {
    if (agitando) {
        alarm[5] = 1;        
    }
}


