/// @description  cargarHechizos()
function cargarHechizos() {

	var nroIndices = 20;
	var vecIndices;

	// Detectar formato: si hechizos[0].indice existe, es formato nuevo
	var _esFormatoNuevo = (read("obj_hechizos", "hechizos[0].indice", -999) != -999);

	if (_esFormatoNuevo) {
		for (var i = 0; i < nroIndices; i++) {
			vecIndices[i] = read("obj_hechizos", "hechizos[" + string(i) + "].indice", -1);
		}
	} else {
		// Formato viejo: leer de indiceHechizos
		for (var i = 0; i < nroIndices; i++) {
			vecIndices[i] = read("obj_hechizos", "indiceHechizos[" + string(i) + "]", -1);
		}
		// Migrar: escribir formato nuevo y borrar claves viejas
		for (var i = 0; i < nroIndices; i++) {
			write("obj_hechizos", "hechizos[" + string(i) + "].indice", vecIndices[i]);
			ini_key_delete("obj_hechizos", "indiceHechizos[" + string(i) + "]");
		}
	}

	// Limpio los hechizos
	
	for (var i = 0; i < nroIndices; i++) { 
	    obj_hechizos.hechizos[i] = hechizoVacio();
	}

	// Cargo los hechizos
	
	var j = 0;
	var posicionesDardoMagico;

	for (var i = 0; i < nroIndices; i++) { 
		if (vecIndices[i] == 125) vecIndices[i] = 5;
	    switch (vecIndices[i] + 120) {
	        case 120:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Curar Veneno", "curar veneno", 12, 1, 10, 0, 0, "NIHIL VED");
	            break;
	        case 121:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Curar Heridas Leves", "curacion", 10, 5, 15, 1, 5, "CORP SANC");
	            break;
	        case 122:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Curar Heridas Graves", "curacion", 40, 21, 38, 12, 35, "EN CORP SANCTIS");
	            break;
	        case 123:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Remover Parálisis", "remover", 300, 44, 45, 0, 0, "AN HOAX VORP");
	            break;
	        case 124:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invisibilidad", "invisibilidad", 500, 72, 87, 0, 0, "");
	            break;
	        case 125:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Dardo Mágico", "negro", 10, 1, 5, 4, 6, "OHL VOR PEK");
				posicionesDardoMagico[j] = i;
				j++;
	            break;
	        case 126:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Flecha Mágica", "negro", 20, 2, 12, 6, 12, "VAX PER");
	            break;
	        case 127:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Flecha Eléctrica", "negro", 40, 5, 22, 12, 20, "SUN VAP");
	            break;
	        case 128:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Misil Mágico", "negro", 45, 6, 38, 25, 35, "VAX IN TAR");
	            break;
	        case 129:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Tormenta de Fuego", "negro", 210, 44, 60, 40, 60, "EN VAX ON TAR");
	            break;
	        case 130:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Descarga Eléctrica", "negro", 460, 72, 85, 63, 85, "T'HY KOOOL");
	            break;
	        case 131:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Apocalipsis", "negro", 1000, 145, 100, 87, 98, "Rahma Nañarak O'al");
	            break;
	        case 132:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Paralizar", "paralisis", 450, 88, 60, 0, 0, "HOAX VORP");
	            break;
	        case 133:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Inmovilizar", "paralisis", 300, 44, 60, 0, 0, "Är Prop s'uo");
	            break;
	        case 134:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Llamado a la Naturaleza", "invocacion", 120, 16, 25, 0, 0, "Nature et worg");
	            break;
	        case 135:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invocar Zombies", "invocacion", 220, 31, 35, 0, 0, "MoÎ cámus");
	            break;
	        case 136:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invocar Elemental de Agua", "invocacion", 950, 131, 87, 0, 0, "Wata Mantra'rax");
	            break;
	        case 137:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invocar Elemental de Tierra", "invocacion", 950, 165, 95, 0, 0, "Mu Mantra'rax");
	            break;
	        case 138:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invocar Elemental de Fuego", "invocacion", 900, 165, 100, 0, 0, "Evarg Icrem Oth");
	            break;
	        case 139:
	            obj_hechizos.hechizos[i] = crearHechizo(vecIndices[i], "Invocar Mascotas", "invocacion", 1000, 165, 87, 0, 0, "Tsälo Kai'Tor");
	            break;
	    }
	}

	// Limpio Dardo Mágico duplicados
	
	if (j > 1) {
		for (var i = 0; i < j - 1; i++) { 
			var pos = posicionesDardoMagico[i];
			obj_hechizos.hechizos[pos] = hechizoVacio();
		}
	}

}