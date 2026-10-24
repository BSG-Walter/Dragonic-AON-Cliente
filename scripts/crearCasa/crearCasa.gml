/// @description  crearCasa(techo, tipoComercio)
/// @param techo
/// @param  tipoComercio
function crearCasa(argument0, argument1) {

	var techo;

	switch (argument0) {
	    case 1: 
	        techo = obj_techo_casa_1;
	        break;
	    case 2: 
	        techo = obj_techo_casa_2;
	        break;
	    case 3: 
	        techo = obj_techo_casa_3;
	        break;
	    case 4: 
	        techo = obj_techo_casa_4;
	        break;
	}

	// Resto de la casa

	instance_create_depth(x, y - 144, 0, obj_casa_p2);
	instance_create_depth(x, y - 16, 0, techo);

	// Bloqueos

	var idBloqueo1 = instance_create_depth(x - 160, y + 16, 0, obj_bloqueo);
	idBloqueo1.image_xscale = 3;

	instance_create_depth(x + 32, y + 16, 0, obj_bloqueo);

	var idBloqueo3 = instance_create_depth(x - 192, y - 16, 0, obj_bloqueo);
	idBloqueo3.image_xscale = 5;

	var idBloqueo4 = instance_create_depth(x - 192, y - 176, 0, obj_bloqueo);
	idBloqueo4.image_yscale = 5;

	var idBloqueo5 = instance_create_depth(x + 64, y - 176, 0, obj_bloqueo);
	idBloqueo5.image_yscale = 6;

	var idBloqueo6 = instance_create_depth(x - 160, y - 176, 0, obj_bloqueo);
	idBloqueo6.image_xscale = 7;

	instance_create_depth(x + 32, y - 16, 0, obj_bloqueo);

	instance_create_depth(x - 112, y - 112, 0, obj_hogar);

	// Piso

	var layPiso = layer_get_id("Tiles_Pisos");
	if (layPiso == -1) {
		layPiso = layer_create(TILE_LAYER_FLOORS, "Tiles_Pisos");
	}
	layer_sprite_create(layPiso, x - 160, y - 144, tl_piso_casa_completo);

	// Decoración

	if (!obj_opciones.opcionOptimizarCiudades) {

	    if (argument1 == "banco") {
	        instance_create_depth(x + 16, y - 128, 0, obj_biblioteca_1);
	        instance_create_depth(x, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_banquero);
	        instance_create_depth(x, y - 144, 0, obj_cofre_cerrado);
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_1);
	        var idBloqueoMesa = instance_create_depth(x - 64, y - 112, 0, obj_bloqueo);
	        idBloqueoMesa.image_xscale = 3;
	    } else if (argument1 == "magia") {
	        instance_create_depth(x + 16, y - 128, 0, obj_biblioteca_2);
	        instance_create_depth(x, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_mago); 
	        instance_create_depth(x - 48, y - 112, 0, obj_npc_hechizos);  
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_2);
	        var idBloqueoMesa = instance_create_depth(x - 64, y - 112, 0, obj_bloqueo);
	        idBloqueoMesa.image_xscale = 3;
	    } else if (argument1 == "carpinteria") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_carpintero); 
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_5);
	        var idBloqueoMesa = instance_create_depth(x - 64, y - 112, 0, obj_bloqueo);
	        idBloqueoMesa.image_xscale = 3;
	    } else if (argument1 == "armas") {
	        instance_create_depth(x + 16, y - 112, 0, obj_armas);
	        instance_create_depth(x, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 48, y - 80, 0, obj_npc_armas); 
	    } else if (argument1 == "armaduras") {
	        instance_create_depth(x - 48, y - 80, 0, obj_npc_armaduras);
	        instance_create_depth(x - 16, y - 80, 0, obj_npc_cascos_escudos); 
	    } else if (argument1 == "sastre") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_sastre); 
	        instance_create_depth(x - 48, y - 112, 0, obj_npc_sastre_tunicas);  
	        instance_create_depth(x + 16, y - 112, 0, obj_npc_sastre_bajos);  
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_4);
	        var idBloqueoMesa = instance_create_depth(x - 64, y - 112, 0, obj_bloqueo);
	        idBloqueoMesa.image_xscale = 3;
	    } else if (argument1 == "provisiones") { 
	        instance_create_depth(x, y - 128, 0, obj_repisa_copas);
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_comidas); 
	        instance_create_depth(x + 16, y - 112, 0, obj_npc_bebidas);  
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_6);
	        var idBloqueoBar1 = instance_create_depth(x - 96, y - 112, 0, obj_bloqueo);
	        var idBloqueoBar2 = instance_create_depth(x - 96, y - 80, 0, obj_bloqueo);
	        var idBloqueoBar3 = instance_create_depth(x - 96, y - 144, 0, obj_bloqueo);
	        idBloqueoBar1.image_xscale = 5;
	        idBloqueoBar2.image_xscale = 2;
	        idBloqueoBar3.image_xscale = 5;
	    } else if (argument1 == "pociones") {
	        instance_create_depth(x + 16, y - 128, 0, obj_biblioteca_3);
	        instance_create_depth(x, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 48, y - 128, 0, obj_biblioteca_1);
	        instance_create_depth(x - 64, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_pociones);
	        instance_create_depth(x - 16, y - 112, 0, obj_mesa_3);
	        var idBloqueoMesa = instance_create_depth(x - 64, y - 112, 0, obj_bloqueo);
	        idBloqueoMesa.image_xscale = 3;
	    } else if (argument1 == "herreria") {
	        instance_create_depth(x - 96, y - 128, 0, obj_fragua);
	        instance_create_depth(x - 16, y - 80, 0, obj_npc_herrero); 
	    } else if (argument1 == "pesca") {
	        instance_create_depth(x + 16, y - 128, 0, obj_colgante_pez_1);
	        instance_create_depth(x - 32, y - 128, 0, obj_colgante_pez_2);
	        instance_create_depth(x + 48, y - 112, 0, obj_canias);
	        instance_create_depth(x + 32, y - 144, 0, obj_bloqueo);
	        instance_create_depth(x - 16, y - 80, 0, obj_npc_pescador); 
	    }

	} else {

	    if (argument1 == "banco") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_banquero);
	    } else if (argument1 == "magia") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_mago); 
	        instance_create_depth(x - 48, y - 112, 0, obj_npc_hechizos);  
	    } else if (argument1 == "carpinteria") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_carpintero); 
	    } else if (argument1 == "armas") {
	        instance_create_depth(x - 48, y - 80, 0, obj_npc_armas); 
	    } else if (argument1 == "armaduras") {
	        instance_create_depth(x - 48, y - 80, 0, obj_npc_armaduras);
	        instance_create_depth(x - 16, y - 80, 0, obj_npc_cascos_escudos); 
	    } else if (argument1 == "sastre") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_sastre); 
	        instance_create_depth(x - 48, y - 112, 0, obj_npc_sastre_tunicas);  
	        instance_create_depth(x + 16, y - 112, 0, obj_npc_sastre_bajos);  
	    } else if (argument1 == "provisiones") { 
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_comidas); 
	        instance_create_depth(x + 16, y - 112, 0, obj_npc_bebidas);  
	    } else if (argument1 == "pociones") {
	        instance_create_depth(x - 16, y - 112, 0, obj_npc_pociones);
	    } else if (argument1 == "herreria") {
	        instance_create_depth(x - 96, y - 128, 0, obj_fragua);
	        instance_create_depth(x - 48, y - 80, 0, obj_npc_herrero); 
	    } else if (argument1 == "pesca") {
	        instance_create_depth(x - 16, y - 80, 0, obj_npc_pescador); 
	    }

	}



}
