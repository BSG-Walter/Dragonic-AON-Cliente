/// @description  elegirIAObjetivoNPCs()
function elegirIAObjetivoNPCs() {

	distanciaMinima = room_width * room_height;
	IDIAdistanciaMinima = -1;

	with (obj_persona) {
	    if (muerto) continue;
	    if (abs(x - other.x) > 500 || abs(y - other.y) > 500) continue;
	    var nuevaDistancia = distance_to_object(other);
	    if (nuevaDistancia < other.distanciaMinima) {
	        other.IDIAdistanciaMinima = id;
	        other.distanciaMinima = nuevaDistancia;
	    }
	}

	return IDIAdistanciaMinima;



}
