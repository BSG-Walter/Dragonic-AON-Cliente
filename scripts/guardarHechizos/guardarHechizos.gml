/// @description  guardarHechizos() 
function guardarHechizos() {
    
	for (var i = 0; i < MAX_SLOTS; i++) {
	    write("obj_hechizos", "hechizos[" + string(i) + "].indice", obj_hechizos.hechizos[i].indice);
	}



}