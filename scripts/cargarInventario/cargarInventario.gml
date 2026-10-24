/// @description  cargarInventario()
function cargarInventario() {

	var maximoInv = 20;

	for (var i = 0; i < maximoInv; i++) {
	    obj_inventario.slots[i] = crearSlotInv(-1, 0, false);
	}

	var nroIndices = 20;

	// Detectar formato: si slots[0].indice existe, es formato nuevo
	var _esFormatoNuevo = (read("obj_inventario", "slots[0].indice", -999) != -999);

	if (_esFormatoNuevo) {
		for (var i = 0; i < nroIndices; i++) {
			var _idx = read("obj_inventario", "slots[" + string(i) + "].indice", -1);
			var _cant = read("obj_inventario", "slots[" + string(i) + "].cant", 0);
			var _eq = read("obj_inventario", "slots[" + string(i) + "].equipado", false);
			obj_inventario.slots[i] = crearSlotInv(_idx, _cant, _eq);
		}
	} else {
		// Formato viejo: leer de indiceInv/cantInv/equipadoInv
		for (var i = 0; i < nroIndices; i++) {
			var _idx = read("obj_inventario", "indiceInv[" + string(i) + "]", -1);
			var _cant = read("obj_inventario", "cantInv[" + string(i) + "]", 0);
			var _eq = read("obj_inventario", "equipadoInv[" + string(i) + "]", false);
			obj_inventario.slots[i] = crearSlotInv(_idx, _cant, _eq);
		}
		// Migrar: escribir formato nuevo y borrar claves viejas
		guardarInventario();
		for (var i = 0; i < nroIndices; i++) {
			ini_key_delete("obj_inventario", "indiceInv[" + string(i) + "]");
			ini_key_delete("obj_inventario", "cantInv[" + string(i) + "]");
			ini_key_delete("obj_inventario", "equipadoInv[" + string(i) + "]");
		}
	}

	obj_pj.desnudo = read("obj_pj", "desnudo", false);

	obj_pj.ropaActual = read("obj_pj", "ropaActual", -1);
	obj_pj.ropaEnInv = read("obj_pj", "ropaEnInv", -1);
	obj_pj.ropaIndexada = read("obj_pj", "ropaIndexada", true);

	obj_pj.armaActual = read("obj_pj", "armaActual", -1);
	obj_pj.armaEnInv = read("obj_pj", "armaEnInv", -1);
	obj_pj.sprArma = obtenerSpriteArma(obj_pj.armaActual);

	obj_pj.flechaActual = read("obj_pj", "flechaActual", -1);
	obj_pj.flechaEnInv = read("obj_pj", "flechaEnInv", -1);

}