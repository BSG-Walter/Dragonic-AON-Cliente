/// @description  alinearPJ()
function alinearPJ() {

	switch (direccion) { // Controlo la dirección para saber si sumo/resto a la x/y
	    case 0: // Está avanzando hacia abajo  
	        while (y % 16 != 0 || y % TILE_SIZE == 0) {
	            y++;
	            y = floor(y);
	        }
	        break;
	    case 1: // Está avanzando hacia arriba  
	        while (y % 16 != 0 || y % TILE_SIZE == 0) {
	            y--;
	            y = floor(y);
	        }
	        break;
	    case 2: // Está avanzando hacia la izquierda  
	        while (x % 16 != 0 || x % TILE_SIZE == 0) {
	            x--;
	            x = floor(x);
	        }                
	        break;
	    case 3: // Está avanzando hacia la izquierda  
	        while (x % 16 != 0 || x % TILE_SIZE == 0) {
	            x++;
	            x = floor(x);
	        }
	        break;
	} 

	image_speed = 0;
	pasos = 0;
	puedeMoverse = true;
	frame = 0;

	if (armaActual != -1) {
	    frameArma = 0;
	}

	if (escudoActual != -1) {
	    frameEscudo = 0;
	}



}
