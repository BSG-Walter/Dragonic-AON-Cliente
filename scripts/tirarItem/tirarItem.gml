// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function tirarItem(){
if (online_activo()) return;
/// @description  Agarrar items
with (obj_pj){
	if (muerto) exit;

		if (position_meeting(x, y - 16, obj_item_basic)) {
        
		    idItem = instance_position(x, y - 16, obj_item_basic);
        
		    if (idItem.object_index == obj_oro) {
        
		        // Si es oro...
        
		        if (oro + idItem.valor <= oroMax) {
		            oro += idItem.valor;
		        } else {
		            oro = oroMax;
		        }
            
		        with (idItem) {
		            instance_destroy();
		        }
            
		    } else if (idItem.object_index == obj_item) {
        
		        var existe = false;
        
		        for (var i = 0; i < obj_inventario.maximoInv; i++) {
            
		        if (obj_inventario.slots[i].indice == idItem.indice) {
                
		            if (obj_inventario.slots[i].cant + idItem.cantidad <= 10000) {
                    
		                // Hay lugar en slot existente
                        
		                existe = true;
                        
		                obj_inventario.slots[i].cant += idItem.cantidad;
                        
		                    with (idItem) {
		                        instance_destroy();
		                    }
                        
		                    break;
                        
		                }
                    
		            }
                
		        }
            
		        if (!existe) {
		            for (var i = 0; i < obj_inventario.maximoInv; i++) {
                
		            if (obj_inventario.slots[i].indice == -1) {
                    
		                    // Hay lugar en slot nuevo
                         
		                    /*
                         
		                    En inventario:
                         
		                    indiceInv
		                    tipoInv
		                    cantInv
		                    equipadoInv
		                    generoInv
		                    razaInv
                         
		                    datosItem:
                         
		                    tipoInv
		                    generoInv
		                    razaInv
                         
		                    */
                        
		                    datosItem = configurarItem(idItem.indice);
                        
		                    obj_inventario.slots[i] = crearSlotInv(idItem.indice, idItem.cantidad, false);
                    
		                    with (idItem) {
		                        instance_destroy();
		                    }
                        
		                    break;
                        
						}
                    
				}  
			}
              
        
		}
        
	}
}
}