/// @description  actualizarIAs()
function actualizarIAs() {

	if (is_ingame_room()) {  
	
	    with (obj_persona) {
        
	        if (!muerto) {
                    
	            x = floor(x);
	            y = floor(y);
            
	            var _datos = datosIAVacio();
	            _datos.x = x;
	            _datos.y = y;
	            _datos.enemigo = enemigo;
	            _datos.direccion = direccion;
	            _datos.yaHabloEnojado1 = yaHabloEnojado1;
	            _datos.yaHabloEnojado2 = yaHabloEnojado2;
	            _datos.yaHabloEnojado3 = yaHabloEnojado3;
	            _datos.genero = genero;
	            _datos.clase = clase;
	            _datos.nroRaza = nroRaza;
	            _datos.saludMax = saludMax;
	            _datos.salud = salud;
	            _datos.manaMax = manaMax;
	            _datos.mana = mana;
	            _datos.nombre = nombre;
	            _datos.danoMeleeMin = danoMeleeMin;
	            _datos.danoMeleeMax = danoMeleeMax;
	            _datos.evasion = evasion;
	            _datos.eqArma = eqArma;
	            _datos.eqRopa = eqRopa;
	            _datos.eqCascoGorro = eqCascoGorro;
	            _datos.eqEscudo = eqEscudo;
	            _datos.eqFlechas = eqFlechas;
	            _datos.pk = pk;
	            _datos.enBarca = enBarca;
	            _datos.sprCabeza = sprCabeza;
	            _datos.inmovilizado = inmovilizado;
	            _datos.agitando = agitando;
	            _datos.yaHablo = yaHablo;
	            _datos.tiempoEnView = tiempoEnView;
	            _datos.alarm4 = alarm[4];
	            _datos.alarm8 = alarm[8];
	            _datos.tiempoLejosPJ = tiempoLejosPJ;
            
	            var _tpCerca = -1;
            
	            with (obj_tp) {
	                if (place_meeting(x, y, obj_pj)) {
	                    _tpCerca = id;
	                    break;
	                }
	            }
            
	            _datos.TPCerca = _tpCerca;
            
	            if (_tpCerca != -1) {
	                _datos.distTPCerca = distance_to_object(_tpCerca);
	                _datos.tpCercaX = _tpCerca.x;
	                _datos.tpCercaY = _tpCerca.y;
	                _datos.tpCercaXTP = _tpCerca.xTP;
	                _datos.tpCercaYTP = _tpCerca.yTP;
	                _datos.tpCercaVisible = _tpCerca.visible;
	            }        
            
	            _datos.roomIA = room;
            
	            if (moviendose || puedeMoverse) { // Si se está moviendo...
            
	                switch (direccion) { // Controlo la dirección para saber si sumo/resto a la x/y
	                    case 0: // Está avanzando hacia abajo  
	                        while (y % 16 != 0 || y % TILE_SIZE == 0) {
	                            y++;
	                        }
	                        break;
	                    case 1: // Está avanzando hacia arriba  
	                        while (y % 16 != 0 || y % TILE_SIZE == 0) {
	                            y--;
	                        }
	                        break;
	                    case 2: // Está avanzando hacia la izquierda  
	                        while (x % 16 != 0 || x % TILE_SIZE == 0) {
	                            x--;
	                        }
	                        break;
	                    case 3: // Está avanzando hacia la derecha  
	                        while (x % 16 != 0 || x % TILE_SIZE == 0) {
	                            x++;
	                        }
	                        break;
	                }
            
	                _datos.x = x;
	                _datos.y = y;
                
	            }
            
	            var i = 0;
	            while (i < obj_personas_mundo.totalMultiIA) {
	                var _slot = obj_personas_mundo.globalIA[i];
	                if (_slot.x != -1 && _slot.nombre == nombre) {
	                    break;
	                }
	                i++;
	            }
	            _datos.lugarEnGlobalIA = i;
            
	            _datos.alarm7 = alarm[7];
	            _datos.puedeCrear = false; // Ya puede crearse ya que alcanzó el límite de la room
	            _datos.sigueAlOtroMapa = sigue; // Indica si sigue o no al PJ
	            _datos.rangoFaccion = rangoFaccion;
            
	            obj_personas_mundo.globalIA[i] = _datos;
	            obj_personas_mundo.itemsGlobalIA[i] = inventario;
            
	            instance_destroy();
                        
	        }

	    }
    
	}



}
