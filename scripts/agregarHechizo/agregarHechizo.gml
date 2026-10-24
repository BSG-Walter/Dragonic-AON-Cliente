/// @description  agregarHechizo(indiceHechizo)
/// @param indiceHechizo
function agregarHechizo(argument0) {

	var yaExiste = false;

	for (var i = 0; i < obj_hechizos.maximoHechizos; i++) {
	    if (obj_hechizos.hechizos[i].indice == argument0 - 120) {
	        yaExiste = true;
	        break;
	    }
	}

	if (!yaExiste) {

	    for (var i = 0; i < obj_hechizos.maximoHechizos; i++) {
	        if (obj_hechizos.hechizos[i].indice == -1) {
	            break;
	        }
	    }
    
	    /*
    
	    0-Curar Veneno                  OK
	    1-Curar Heridas Leves           OK
	    2-Curar Heridas Graves          OK
	    3-Remover Parálisis             OK
	    4-Invisibilidad                 OK
	    5-Dardo Mágico                  OK
	    6-Flecha Mágica                 OK
	    7-Flecha Eléctrica              OK
	    8-Misil Mágico                  OK
	    9-Tormenta de Fuego             OK
	    10-Descarga Eléctrica           OK
	    11-Apocalipsis                  OK
	    12-Paralizar                    OK    
	    13-Inmovilizar                  OK
	    14-Llamado a la Naturaleza      OK
	    15-Invocar Zombies              OK
	    16-Invocar Elemental de Agua    OK
	    17-Invocar Elemental de Fuego   OK
	    18-Invocar Elemental de Tierra  OK
	    19-Invocar Mascotas             OK
    
	    */
    
	    switch (argument0) {
	        case 120:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Curar Veneno", "curar veneno", 12, 1, 10, 0, 0, "NIHIL VED");
	            break;
	        case 121:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Curar Heridas Leves", "curacion", 10, 5, 15, 1, 5, "CORP SANC");
	            break;
	        case 122:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Curar Heridas Graves", "curacion", 40, 21, 38, 12, 35, "EN CORP SANCTIS");
	            break;
	        case 123:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Remover Parálisis", "remover", 300, 44, 45, 0, 0, "AN HOAX VORP");
	            break;
	        case 124:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invisibilidad", "invisibilidad", 500, 72, 87, 0, 0, "");
	            break;
	        case 125:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Dardo Mágico", "negro", 10, 1, 5, 4, 6, "OHL VOR PEK");
	            break;
	        case 126:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Flecha Mágica", "negro", 20, 2, 12, 6, 12, "VAX PER");
	            break;
	        case 127:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Flecha Eléctrica", "negro", 40, 5, 22, 12, 20, "SUN VAP");
	            break;
	        case 128:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Misil Mágico", "negro", 45, 6, 38, 25, 35, "VAX IN TAR");
	            break;
	        case 129:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Tormenta de Fuego", "negro", 210, 44, 60, 40, 60, "EN VAX ON TAR");
	            break;
	        case 130:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Descarga Eléctrica", "negro", 460, 72, 85, 63, 85, "T'HY KOOOL");
	            break;
	        case 131:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Apocalipsis", "negro", 1000, 145, 100, 87, 98, "Rahma Nañarak O'al");
	            break;
	        case 132:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Paralizar", "paralisis", 450, 88, 60, 0, 0, "HOAX VORP");
	            break;
	        case 133:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Inmovilizar", "paralisis", 300, 44, 60, 0, 0, "Är Prop s'uo");
	            break;
	        case 134:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Llamado a la Naturaleza", "invocacion", 120, 16, 25, 0, 0, "Nature et worg");
	            break;
	        case 135:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invocar Zombies", "invocacion", 220, 31, 35, 0, 0, "MoÎ cámus");
	            break;
	        case 136:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invocar Elemental de Agua", "invocacion", 950, 131, 87, 0, 0, "Wata Mantra'rax");
	            break;
	        case 137:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invocar Elemental de Tierra", "invocacion", 950, 165, 95, 0, 0, "Mu Mantra'rax");
	            break;
	        case 138:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invocar Elemental de Fuego", "invocacion", 900, 165, 100, 0, 0, "Evarg Icrem Oth");
	            break;
	        case 139:
	            obj_hechizos.hechizos[i] = crearHechizo(argument0 - 120, "Invocar Mascotas", "invocacion", 1000, 165, 87, 0, 0, "Tsälo Kai'Tor");
	            break;
	    }
    
	    obj_hechizos.seleccionado = -1;
    
	    return true;

	} else {
	    return false;
	}



}
