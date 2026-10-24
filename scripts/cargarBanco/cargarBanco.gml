/// @description  cargarBanco()
function cargarBanco() {

	// Detectar formato: si slots[0].indice existe, es formato nuevo
	var _esFormatoNuevo = (read("obj_banco", "slots[0].indice", -999) != -999);

	if (_esFormatoNuevo) {
		for (var i = 0; i < MAX_SLOTS; i++) {
			var _idx = read("obj_banco", "slots[" + string(i) + "].indice", -1);
			var _cant = read("obj_banco", "slots[" + string(i) + "].cant", 0);
			var _nombre = readS("obj_banco", "slots[" + string(i) + "].nombre", "Vacío");
			obj_banco.slots[i] = crearSlotNpc(_idx, _cant, _nombre);
		}
	} else {
		// Formato viejo: leer de indiceNpc/cantNpc/nombreNpc
		for (var i = 0; i < MAX_SLOTS; i++) {
			var _idx = read("obj_banco", "indiceNpc[" + string(i) + "]", -1);
			var _cant = read("obj_banco", "cantNpc[" + string(i) + "]", 0);
			var _nombre = readS("obj_banco", "nombreNpc[" + string(i) + "]", "Vacío");
			obj_banco.slots[i] = crearSlotNpc(_idx, _cant, _nombre);
		}
		// Migrar: escribir formato nuevo y borrar claves viejas
		guardarBanco();
		for (var i = 0; i < MAX_SLOTS; i++) {
			ini_key_delete("obj_banco", "indiceNpc[" + string(i) + "]");
			ini_key_delete("obj_banco", "cantNpc[" + string(i) + "]");
			ini_key_delete("obj_banco", "nombreNpc[" + string(i) + "]");
		}
	}

}