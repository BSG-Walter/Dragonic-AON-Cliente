/// @description  crearIADelMundo()
function crearIADelMundo() {
if (online_activo() || global.online_exportando) return;

	if (!instance_exists(obj_personas_mundo)) return;

	for (var iAux = 0; iAux < totalMultiIA; iAux++) {

	    var _datos = globalIA[iAux];

	    var valido = true;
    
	    if (_datos.x != -1) {
	        if (_datos.puedeCrear) {
	            if (crea) {
	                if (_datos.roomIA != roomAnterior) {
	                    valido = false;
	                }
	            } else {
	                if (_datos.roomIA != room) {
	                    valido = false;
	                }
	            }
	        } else {
	            valido = false;
	        }
	    } else {
	        valido = false;
	    }
    
	    if (valido) {  
        
	        var creoEfectoLogin = false;
    
	        if (_datos.TPCerca != -1 && crea) {
	            if (_datos.tpCercaVisible) {
	                creoEfectoLogin = true;
	            }
	            _datos.x = _datos.tpCercaXTP;
	            _datos.y = _datos.tpCercaYTP;
	        }  
    
	        var switchMod = -1;
            
	        if (direccionPJ != -1) {
	            switchMod = direccionPJ;
	        } else {
	            switchMod = _datos.direccion;
	        }
    
	        switch (switchMod) { // Controlo la dirección para saber si sumo/resto a la x/y
	            case 0: // Está avanzando hacia abajo  
	                while (_datos.y % 16 != 0 || _datos.y % TILE_SIZE == 0) {
	                    _datos.y++;
	                }
	                break;
	            case 1: // Está avanzando hacia arriba  
	                while (_datos.y % 16 != 0 || _datos.y % TILE_SIZE == 0) {
	                    _datos.y--;
	                }
	                break;
	            case 2: // Está avanzando hacia la izquierda  
	                while (_datos.x % 16 != 0 || _datos.x % TILE_SIZE == 0) {
	                    _datos.x--;
	                }                
	                break;
	            case 3: // Está avanzando hacia la izquierda  
	                while (_datos.x % 16 != 0 || _datos.x % TILE_SIZE == 0) {
	                    _datos.x++;
	                }
	                break;
	        } 
        
	        while ( // Mientras que haya algún bloqueo...
	        instance_position(_datos.x, _datos.y - 16, obj_pj) != noone ||
	        instance_position(_datos.x, _datos.y - 16, obj_bloque_basic) != noone || 
	        instance_position(_datos.x, _datos.y - 16, obj_bloque) != noone || 
	        instance_position(_datos.x, _datos.y - 16, obj_npc_basic) != noone
	        ) {
            
	            switch (switchMod) {
	                case 0:
	                    _datos.y += TILE_SIZE;
	                    break;
	                case 1:
	                    _datos.y -= TILE_SIZE;
	                    break;
	                case 2:
	                    _datos.x -= TILE_SIZE;
	                    break;
	                case 3:
	                    _datos.x += TILE_SIZE;
	                    break;
	            }
            
	        }
        
	        var tile1 = tile_layer_find(TILE_LAYER_GRASS, _datos.x, _datos.y);
	        var tile2 = tile_layer_find(TILE_LAYER_COAST, _datos.x, _datos.y);
	        var tile3 = tile_layer_find(TILE_LAYER_FLOORS, _datos.x, _datos.y);
            
	        if (tile1 != -1 || tile2 != -1 || tile3 != -1) { // Si hay algún tipo de suelo
	            _datos.enBarca = false;
	        } else {
        
	            _datos.enBarca = true;
            
	            if (obj_pj.nivel < 25) {
	                _datos.x = -1;
	            }
            
	        }
        
	        if (_datos.x != -1) {
        
	            var idIA = instance_create_depth(_datos.x, _datos.y, 0, obj_persona);             
	            idIA.enemigo = _datos.enemigo; 
	            idIA.direccion = _datos.direccion; 
	            idIA.yaHabloEnojado1 = _datos.yaHabloEnojado1; 
	            idIA.yaHabloEnojado2 = _datos.yaHabloEnojado2; 
	            idIA.yaHabloEnojado3 = _datos.yaHabloEnojado3; 
	            idIA.genero = _datos.genero; 
	            idIA.clase = _datos.clase; 
	            idIA.nroRaza = _datos.nroRaza; 
	            idIA.saludMax = _datos.saludMax; 
	            idIA.salud = _datos.salud; 
	            idIA.manaMax = _datos.manaMax; 
	            idIA.mana = _datos.mana; 
	            idIA.nombre = _datos.nombre; 
	            idIA.danoMeleeMin = _datos.danoMeleeMin; 
	            idIA.danoMeleeMax = _datos.danoMeleeMax; 
	            idIA.evasion = _datos.evasion; 
            
	            idIA.eqArma = _datos.eqArma; 
	            idIA.eqRopa = _datos.eqRopa; 
	            idIA.eqCascoGorro = _datos.eqCascoGorro; 
	            idIA.eqEscudo = _datos.eqEscudo;
	            idIA.eqFlechas = _datos.eqFlechas;
	            idIA.sprArma = obtenerSpriteArma(idIA.eqArma);
	            idIA.sprEscudo = obtenerSpriteEscudo(idIA.eqEscudo);
            
	            idIA.pk = _datos.pk; 
	            idIA.rangoFaccion = _datos.rangoFaccion; 
	            idIA.enBarca = _datos.enBarca;
            
	            if (_datos.enBarca) {
	                idIA.sprite_index = spr_barca;
	            }
            
	            idIA.sprCabeza = _datos.sprCabeza;
	            idIA.inmovilizado = _datos.inmovilizado;
	            idIA.agitando = _datos.agitando;
            
	            if (obj_mapas_mundo.mapas[room] && _datos.enemigo) {
	                idIA.yaHablo = false;
	            } else {
	                idIA.yaHablo = _datos.yaHablo;
	            }            
            
	            idIA.tiempoEnView = _datos.tiempoEnView;
	            idIA.alarm[4] = _datos.alarm4;
	            idIA.alarm[7] = _datos.alarm7;
	            idIA.alarm[8] = _datos.alarm8;
	            idIA.tiempoLejosPJ = _datos.tiempoLejosPJ;
	            idIA.TPCerca = -1;
            
	            idIA.image_index = idIA.index[idIA.direccion, 0];
	            idIA.frameArma = 0;
	            idIA.frameEscudo = 0;
    
	            idIA.inventario = itemsGlobalIA[iAux];
            
	            globalIA[_datos.lugarEnGlobalIA] = datosIAVacio();
            
	            with (idIA) {
	                guardarDatosIAEnGlobalIA();   
	            }
            
	            if (creoEfectoLogin) {
	                var idEfecto = instance_create_depth(idIA.x, idIA.y, 0, obj_efecto_login);
	                idEfecto.padre = idIA;
	                reproducirSonido(snd_logueo, false, false);
	            }
            
	            actualizarCiudas();
                
	        }
        
	    }

	}



}
