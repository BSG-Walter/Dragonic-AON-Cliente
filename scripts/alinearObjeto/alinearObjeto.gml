/// @description  alinearObjeto()
function alinearObjeto() {

	while (y % 16 != 0 || y % TILE_SIZE == 0) {
	    y--;
	}

	while (x % 16 != 0 || x % TILE_SIZE == 0) {
	    x++;
	}



}
