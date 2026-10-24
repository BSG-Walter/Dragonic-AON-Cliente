/// @description  cantidadIARivalCerca()
function cantidadIARivalCerca() {

	cantidadIACerca = 0;

	with (obj_persona) {
		if (id == other.id) continue;
		if (muerto) continue;
		// Early bbox check
		if (abs(x - other.x) > 250 || abs(y - other.y) > 250) continue;
		var esRival = (room == rm_arena) ? (pk != other.pk) : (pk || other.pk);
	    if (esRival) {
	        if (distance_to_object(other) <= 250) {
	            other.cantidadIACerca++;        
	        }
	    }
	}

	return cantidadIACerca;

}
