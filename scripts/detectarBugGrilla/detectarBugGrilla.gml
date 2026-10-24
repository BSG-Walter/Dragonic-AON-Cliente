/// @description  detectarBugGrilla()
function detectarBugGrilla() {

	if (pasos == 0 && salud > 0) {
	    if (
	    (y % 16 != 0 || y % TILE_SIZE == 0) ||
	    (x % 16 != 0 || x % TILE_SIZE == 0)
	    ) {
        
	        while (y % 16 != 0 || y % TILE_SIZE == 0) {
	            y--;
	            y = floor(y);            
	        }
        
	        while (x % 16 != 0 || x % TILE_SIZE == 0) {
	            x--;
	            x = floor(x);            
	        }        
        
	        pasos = 0;
        
	    }
	}



}
