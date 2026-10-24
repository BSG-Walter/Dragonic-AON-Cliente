/// @description  Estado inicial

hostil = false;
desc = "¡Hola muchacho! Bienvenido a mi humilde carpintería";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [21, 22, 23, 29, 30, 147, 157];
nroIndices = array_length(vecIndices);

for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
