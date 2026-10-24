/// @description  IAAgarraItem(idIA)
/// @param idIA
function IAAgarraItem(argument0) {

	/// Agarrar items
    
	if (object_index == obj_oro) {

	    // Si es oro...
	    instance_destroy();
    
	} else if (object_index == obj_item) {

	    var existe = false;

	    for (var i = 0; i < MAX_SLOTS; i++) {
    
	        if (argument0.inventario[i].indice == indice) {
        
	            if (argument0.inventario[i].cant + cantidad <= 10000) {
            
	                // Hay lugar en slot existente
                
	                existe = true;
	                argument0.inventario[i].cant += cantidad;
	                instance_destroy();
                
	                break;
                
	            } else {
	                yaEncontroItem = false;
	                lukea = false;
	                alarm[5] = 1;
	            }
            
	        }
        
	    }
    
	    if (!existe) {
    
	        var agrego = false;
        
	        for (var i = 0; i < MAX_SLOTS; i++) {
        
	            if (argument0.inventario[i].indice == -1) {
            
	                // Hay lugar en slot nuevo
            
	                agrego = true;                
                        
	                argument0.inventario[i].indice = indice;
	                argument0.inventario[i].cant = cantidad;
            
	                instance_destroy();
                
	                break;
                
	            }
            
	        }  
        
	        if (!agrego) {
	            yaEncontroItem = false;
	            lukea = false;
	            alarm[5] = 1;
	        }
        
	    }

	}



}
