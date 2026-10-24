/// @description  invocarGuardarMascotas(x, y)
/// @param x
/// @param y
function invocarGuardarMascotas(argument0, argument1) {

	var invoca = true;

	for (var i = 0; i < 3; i++) {
	    if (obj_pj.criaturasHijas[i, 0] != -1) {
	        invoca = false;
	        break;
	    }
	} 

	if (invoca) {

	    // Invoca

	    var consumoMana = 1000;
    
	    if (obj_pj.mana < consumoMana) {
	        idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	        idINFO.padre = obj_pj.id;
	        idINFO.texto = "¡Maná menor a " + string(consumoMana) + "!";
	        return 0;
	    }
    
	    if (obj_mapas_mundo.mapas[room]) {
	        var idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	        idINFO.texto = "¡No podés invocar criaturas en una zona segura!";
	        return 0;
	    }
        
	    var posXMouse = round(argument0);
	    var posYMouse = round(argument1);
    
	    while (posXMouse % 16 != 0 || posXMouse % TILE_SIZE == 0) {
	        posXMouse++;
	    }
    
	    while (posYMouse % 16 != 0 || posYMouse % TILE_SIZE == 0) {
	        posYMouse++;
	    }
    
	    var tilePasto = tile_layer_find(TILE_LAYER_GRASS, posXMouse, posYMouse); // Pasto
	    var tileCosta = tile_layer_find(TILE_LAYER_COAST, posXMouse, posYMouse); // Costa
	    var tilePisosYPuentes = tile_layer_find(TILE_LAYER_FLOORS, posXMouse, posYMouse); // Pisos y puentes
    
	    if (tilePasto != -1 || tileCosta != -1 || tilePisosYPuentes != -1) { // Si hay algún tipo de suelo...
	        obj_pj.mana -= consumoMana;        
	    } else {
	        idINFO = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
	        idINFO.padre = obj_pj.id;
	        idINFO.texto = "¡No podés invocar mascotas en el agua!";
	        return 0;
	    }
    
	    // Guarda invocaciones si tiene
    
	    for (var i = 0; i < 3; i++) {
	        if (obj_pj.criaturasInvocadas[i] != -1) {
	            with (obj_pj.criaturasInvocadas[i]) {
	                instance_destroy();
	            }
	            obj_pj.criaturasInvocadas[i] = -1;
	        }
	    }
        
	    for (var i = 0; i < 3; i++) {
	        if (obj_pj.criaturasHijas[i, 0] == -1) {
	            if (obj_pj.criaturasHijas[i, 1] != -1) {                
            
	                var idMascota = instance_create_depth(posXMouse, posYMouse, 0, obj_pj.criaturasHijas[i, 1]);       
	                idMascota.domado = true;
	                obj_pj.criaturasHijas[i, 0] = idMascota;    
	                idMascota.salud = obj_pj.criaturasHijas[i, 2];            
	                idMascota.roomInicial = obj_pj.criaturasHijas[i, 3];            
	                idMascota.alarm[6] = 1;
	                idMascota.alarm[8] = 1;
                
	            }          
	        }
	    } 
    
	    return 1;

	} else {

	    // Guarda

	    for (var i = 0; i < 3; i++) {
	        if (obj_pj.criaturasHijas[i, 0] != -1) {
	            with (obj_pj.criaturasHijas[i, 0]) {
	                instance_destroy();
	            }
	            obj_pj.criaturasHijas[i, 0] = -1;
	        }
	    } 
    
	    return 1;
    
	}



}
