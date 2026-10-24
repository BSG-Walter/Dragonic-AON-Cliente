/// @description  Hago que los items se caigan al morir

var _slot = slots[indiceTirarItems];

if (_slot.indice != 144 && _slot.indice != 145 && (_slot.indice < 164 || _slot.indice > 211)) {

    if (_slot.indice != -1) {
        var idItem = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_item);
        idItem.indice = _slot.indice;
        idItem.cantidad = _slot.cant;
        idItem.tipo = _slot.tipo;
    }

    if (_slot.indice == seleccionado) {
        seleccionado = -1;
    }
    
    if (indiceTirarItems == posSeleccionado) {
        posSeleccionado = -1;
    }
    
    slots[indiceTirarItems] = crearSlotInv(-1, 0, false);
    
}

if (indiceTirarItems == 19) {    
    indiceTirarItems = 0;
    alarm[3] = -1;
    obj_pj.inmovilizado = false;    
} else {
    indiceTirarItems++;
    alarm[3] = 1;
}
