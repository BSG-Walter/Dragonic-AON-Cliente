/// @description  agarrarItemForzado(indiceItem)
/// @param indiceItem
function agarrarItemForzado(argument0) {

	var indiceItem = argument0;
    var existe = false;
                            
    for (var i = 0; i < obj_inventario.maximoInv; i++) {
        if (obj_inventario.slots[i].indice == indiceItem) {
            if (obj_inventario.slots[i].cant + 1 <= 10000) {            
                // Hay lugar en slot existente   
                existe = true;
                obj_inventario.slots[i].cant++;
                break;               
            }
        }
    }
                                
    if (!existe) {
        for (var i = 0; i < obj_inventario.maximoInv; i++) {
            if (obj_inventario.slots[i].indice == -1) {
                // Hay lugar en slot nuevo  
				
                obj_inventario.slots[i] = crearSlotInv(indiceItem, 1, false);
                                            
                valido = true;
				
                break;
            }
        }  
    }

}
