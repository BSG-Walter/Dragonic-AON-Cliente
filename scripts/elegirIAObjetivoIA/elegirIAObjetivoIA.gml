/// @description  elegirIAObjetivoIA(recursivo)
/// @param recursivo

function elegirIAObjetivoIA(argument0) {
	
	distanciaMinima = room_width * room_height;
	IDIAdistanciaMinima = -1;
	cantIAEnView = 0;
	cantInmovilizados = 0;
	
	for (var i = 0; i < obj_opciones.maxBots; ++i) {
	    inmovilizados[i] = -1;
	}
	
	with (obj_persona) {

			if (id == other.id) continue;
		if (!esRivalIA(pk, other.pk)) continue;
		
		var _nueva_distancia = point_distance(x, y, other.x, other.y);
		
		if (_nueva_distancia <= 350) {
			other.cantIAEnView++;
			
			if (inmovilizado) {
				other.inmovilizados[other.cantInmovilizados] = id;
	            other.cantInmovilizados++;
			}
			
			// Si es el primero en chequear lo dejamos por default
			if (other.IDIAdistanciaMinima == -1) {
				other.IDIAdistanciaMinima = id;
				other.distanciaMinima = _nueva_distancia;
				continue;
			}
			
			// Priorizamos si el bot esta inmovilizado sobre la distancia
			if (!inmovilizado && other.IDIAdistanciaMinima.inmovilizado) continue;
			if (inmovilizado && !other.IDIAdistanciaMinima.inmovilizado) {
				other.IDIAdistanciaMinima = id;
				other.distanciaMinima = _nueva_distancia;
				continue;
			}
			
			// Por ultimo, al mas cercano
			if (_nueva_distancia < other.distanciaMinima) {
				other.IDIAdistanciaMinima = id;
				other.distanciaMinima = _nueva_distancia;
			}
		}
	}
	
	
	if (IDIAdistanciaMinima == -1 && (pk != obj_pj.pk || pk)) return -1;
	
	if (obj_pj.muerto || !obj_pj.inmovilizado || (pk && obj_pj.pk) || !enemigo) {
	    return IDIAdistanciaMinima;
	} else {
	    if (cantInmovilizados > 0) {
	        var rand = random(cantInmovilizados);
	        if (rand > (cantInmovilizados - (cantInmovilizados * 0.5))) {
	            return -1;
	        } else {
	            var idRet = -1;
	            for (var i = 0; i < cantInmovilizados; i++) {
	                if (inmovilizados[i].pk != pk) {
	                    idRet = inmovilizados[i];
	                    break;
	                }
	            }    
        
	            if (idRet == -1) {
	                var IARandInmo = floor(random(cantInmovilizados));
	                if (IARandInmo >= 0) {
	                    return inmovilizados[IARandInmo];
	                } else {
	                    return inmovilizados[0];
	                }
	            } else {
	                return idRet;
	            }
	        }
	    } else {
	        return -1;
	    }
	}
}

function treguaPKActivaIA() {
	static habitacion = -1;
	static proximoChequeo = 0;
	static treguaHasta = 0;
	static hayCiudadanos = false;

	var ahora = current_time;
	if (habitacion != room) {
		habitacion = room;
		proximoChequeo = 0;
		treguaHasta = ahora + BOT_PK_TRUCE_MS;
	}
	if (ahora >= proximoChequeo) {
		proximoChequeo = ahora + BOT_PK_TRUCE_CHECK_MS;
		hayCiudadanos = instance_exists(obj_pj) && !obj_pj.muerto && !obj_pj.pk;
		if (!hayCiudadanos) {
			var cantidad = instance_number(obj_persona);
			for (var i = 0; i < cantidad; ++i) {
				var persona = instance_find(obj_persona, i);
				if (!persona.muerto && !persona.pk) {
					hayCiudadanos = true;
					break;
				}
			}
		}
		if (hayCiudadanos) treguaHasta = ahora + BOT_PK_TRUCE_MS;
	}
	return hayCiudadanos || ahora < treguaHasta;
}

function esRivalIA(_miPK, _otroPK) {

	//en arena solo nos importa si son pk y ciuda
	if (room == rm_arena) return _miPK != _otroPK;
	var tregua = treguaPKActivaIA();

	//si son pk y ciuda, siempre son enemigos
	if (_miPK != _otroPK) return true;
	
	//si son ciudas no se atacan
	if (!_miPK) return false;

	// mismo bando pk: los pks ahora tienen codigo, solo se atacan entre ellos si no queda ningún ciuda
	return !tregua;

}
