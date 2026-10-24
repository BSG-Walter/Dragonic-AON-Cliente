/// @description  hayEnemigosCerca()
function hayEnemigosCerca() {

	var _enemigosCerca = false;
	var _maxDistancia = (get_render_width() / 2)
	
	with (obj_persona) {
	    if (!muerto & pk!= other.pk && distance_to_object(other) <= _maxDistancia) {
	        other.enemigosCerca = true;
	        break;
	    }
	}
	
	return _enemigosCerca;
}