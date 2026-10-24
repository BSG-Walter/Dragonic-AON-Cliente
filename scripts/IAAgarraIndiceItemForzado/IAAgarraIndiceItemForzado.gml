/// @description  IAAgarraIndiceItemForzado(indiceItem)
/// @param indiceItem
function IAAgarraIndiceItemForzado(argument0){

	var existe = false;

	    for (var i = 0; i < MAX_SLOTS; i++) {
    
	        if (inventario[i].indice == argument0) {
        
	            if (inventario[i].cant + 1 <= 10000) {
            
	                // Hay lugar en slot existente
                
	                existe = true;
	                inventario[i].cant ++;
                
	                break;
                
	            }
            
	        }
        
	    }
    
	    if (!existe) {
    
	        var agrego = false;
        
	        for (var i = 0; i < MAX_SLOTS; i++) {
        
	            if (inventario[i].indice == -1) {
            
	                // Hay lugar en slot nuevo
            
	                agrego = true;                
                        
	                inventario[i].indice = argument0;
	                inventario[i].cant = 1;
                
	                break;
                
	            }
            
	        }  
        
	        if (!agrego) {
	            inventario[19].indice = argument0;
	            inventario[19].cant = 1;
	        }
        
	    }

}
