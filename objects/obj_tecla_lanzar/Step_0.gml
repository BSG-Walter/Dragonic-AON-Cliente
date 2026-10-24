/// @description  Control mouse
event_inherited()
if (obj_inventario.visible) exit;

var nuevoTouch = empieza_a_tocar(self, true)
if (touchId != nuevoTouch && nuevoTouch > -1) {  //detectamos un nuevo tap en el boton
	touchId = nuevoTouch;
	
    if (!obj_pj.muerto) {
        keyboard_key_press(ord("L"));
        image_index = 1;
    } else {
        var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
        idINFO.padre = obj_pj.id;
        idINFO.texto = "¡Estás muerto!";
    }
	
	exit;
}

if ( touchId > -1 && !esta_tocando(self,touchId)) {
	keyboard_key_release(ord("L"));
	image_index = 0;
	touchId = -1
}


