/// @description  descontarItemInv(indiceItem, cantidad)
/// @param indiceItem
/// @param cantidad
function descontarItemInv(argument0, argument1) { // La función asume que todos los items están en un mismo slot

	var indiceItem = argument0;
	var cantidadItem = argument1;
                            
    for (var i = 0; i < obj_inventario.maximoInv; i++) {
        if (obj_inventario.slots[i].indice == indiceItem) {
            if (obj_inventario.slots[i].cant >= cantidadItem) {            
                // Descuenta
				obj_inventario.slots[i].cant -= cantidadItem;
                break;                        
            }
        }
    }
	
	if (obj_inventario.slots[i].cant == 0) {
		if (obj_inventario.slots[i].indice == obj_inventario.seleccionado) {
            obj_inventario.seleccionado = -1;
        }
                                             
        if (i == obj_inventario.posSeleccionado) {
            obj_inventario.posSeleccionado = -1;
        }
                                      
        obj_inventario.slots[i] = crearSlotInv(-1, 0, false);
	}

}
