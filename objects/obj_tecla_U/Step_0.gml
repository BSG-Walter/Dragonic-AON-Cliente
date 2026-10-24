/// @description  Control mouse
event_inherited()

var nuevoTouch = empieza_a_tocar(self, true)
if (touchId != nuevoTouch && nuevoTouch > -1) {  //detectamos un nuevo tap en el boton
	touchId = nuevoTouch;
    var barcaORunaSeleccionada = false;

    if (obj_inventario.seleccionado != -1) {
            
        for (var i = 0; i < obj_inventario.maximoInv; i++) {
            if (obj_inventario.seleccionado == obj_inventario.slots[i].indice) {
                break;
            }
        }
                
        if (obj_inventario.slots[i].tipo == "barca" || obj_inventario.slots[i].tipo == "runa") {
            barcaORunaSeleccionada = true;
        }
                
    }
            
    if (!obj_pj.muerto || barcaORunaSeleccionada) {
                
		usarItem();
        if (obj_inventario.visible) {
            image_index = 1;
        } else {
            image_index = 3;
        }
            
    }
	exit;
}

if ( touchId > -1 && !esta_tocando(self,touchId)) {
	if (obj_inventario.visible) {
		image_index = 0;
	} else {
	    image_index = 2;
	}
	touchId = -1
}

