/// @description  guardarInventario() 
function guardarInventario() {
    
	for (var i = 0; i < MAX_SLOTS; i++) {
	    write("obj_inventario", "slots[" + string(i) + "].indice", obj_inventario.slots[i].indice);
	    write("obj_inventario", "slots[" + string(i) + "].cant", obj_inventario.slots[i].cant);
	    write("obj_inventario", "slots[" + string(i) + "].equipado", obj_inventario.slots[i].equipado);
	}



}