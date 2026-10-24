/// @description  reiniciarArrayItemsRM(room)
/// @param room
function reiniciarArrayItemsRM(argument0) {
         
	for (var k = 0; k < array_length(ItemsXRM[argument0]); k++) {
	    ItemsXRM[argument0, k] = itemMundoVacio();
	}

}
