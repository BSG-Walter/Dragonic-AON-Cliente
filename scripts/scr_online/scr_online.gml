function pj_actualizar_visuales() {
if (obj_opciones.opcionArboles) {
    var _currArbol = instance_place(x, y, obj_arbol_basic);
    if (_currArbol != ultimoArbol) {
        if (ultimoArbol != noone && instance_exists(ultimoArbol)) ultimoArbol.image_alpha = 1;
        if (_currArbol != noone) _currArbol.image_alpha = 0.5;
        ultimoArbol = _currArbol;
    }
} else {
    if (ultimoArbol != noone) {
        if (instance_exists(ultimoArbol)) ultimoArbol.image_alpha = 1;
        ultimoArbol = noone;
    }
}



// Opacidad techos

if (!obj_opciones.opcionTechos) {

    if (
    (place_meeting(x, y, obj_techo_basic)) ||
    (place_meeting(x, y - TILE_SIZE, obj_techo_basic))
    ) {
        with (obj_techo_basic) {
            visible = false;
        }
    } else {
        with (obj_techo_basic) {
            visible = true;
        }
    }

} else {

    if (
    (place_meeting(x, y, obj_techo_basic)) ||
    (place_meeting(x, y - TILE_SIZE, obj_techo_basic))
    ) {

        with (obj_techo_basic) {
            image_alpha = 0.35;
        }

    } else {

        with (obj_techo_basic) {
            image_alpha = 1;
        }

    }

}


}
