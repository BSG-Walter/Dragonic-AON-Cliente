/// @description  guardarBanco() 
function guardarBanco() {
    
	for (var i = 0; i < MAX_SLOTS; i++) {
	    write("obj_banco", "slots[" + string(i) + "].indice", obj_banco.slots[i].indice);
	    write("obj_banco", "slots[" + string(i) + "].cant", obj_banco.slots[i].cant);
	    writeS("obj_banco", "slots[" + string(i) + "].nombre", obj_banco.slots[i].nombre);
	}



}