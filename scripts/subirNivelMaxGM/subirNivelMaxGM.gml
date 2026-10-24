/// @description  subirNivelMaxGM()
function subirNivelMaxGM() {

	while (obj_pj.nivel < obj_pj.nivelMax) {
		subirNivel();
	}

	skills[0] = 100; // Magia
	skills[1] = 100; // Tácticas de Combate
	skills[2] = 100; // Combate con Armas
	skills[3] = 100; // Meditar
	skills[4] = 100; // Apuñalar
	skills[5] = 100; // Talar
	skills[6] = 100; // Defensa con Escudos
	skills[7] = 100; // Pesca
	skills[8] = 100; // Minería
	skills[9] = 100; // Carpintería
	skills[10] = 100; // Herrería
	skills[11] = 100; // Domar Animales
	skills[12] = 100; // Arquería
	skills[13] = 100; // Combate sin Armas
	skills[14] = 100; // Navegación
	skills[15] = 100; // Sastrería
	skills[16] = 100; // Comercio
	skills[17] = 100; // Resistencia Mágica

	oro = oroMax;
	
	obj_inventario.slots[14] = crearSlotInv(163, 100, false);
	obj_inventario.slots[15] = crearSlotInv(146, 10000, false);
	obj_inventario.slots[16] = crearSlotInv(28, 10000, false);
	obj_inventario.slots[17] = crearSlotInv(151, 10000, false);
	obj_inventario.slots[18] = crearSlotInv(152, 10000, false);
	obj_inventario.slots[19] = crearSlotInv(153, 10000, false);

}
