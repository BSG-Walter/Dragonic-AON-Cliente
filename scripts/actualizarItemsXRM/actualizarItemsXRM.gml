/// @description  actualizarItemsXRM(ID)
/// @param ID
function actualizarItemsXRM(argument0) {

	if (is_ingame_room()) {

	    with (argument0) {
                    
	        var _datosItem = itemMundoVacio();
                
	        _datosItem.x = x;
	        _datosItem.y = y;
        
	        if (object_index == obj_item) {
	            _datosItem.indice = indice;
	            _datosItem.tipo = tipo;
	            _datosItem.cantidad = cantidad;
	        } else if (object_index == obj_oro) {
	            _datosItem.valor = valor;
	        }
        
	        obj_items_mundo.ItemsXRM[room, obj_items_mundo.i] = _datosItem;
        
	        instance_destroy();
                    
	    }

	}



}
