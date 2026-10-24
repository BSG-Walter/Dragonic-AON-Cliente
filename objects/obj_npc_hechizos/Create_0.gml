/// @description  Estado inicial

hostil = false;
desc = "Bienvenido a mi pequeño negocio... Tengo algunos hechizos que podrían interesarte";

// Doble clic

dobleClic = false;

// Inventario

for (var i = 0; i < MAX_SLOTS; i++) {
    slots[i] = crearSlotNpc(-1, 0, "Vacío");
}

vecIndices = [120, 125, 121, 126, 127, 128, 134, 135, 123, 122, 132, 129, 133, 124, 136, 139, 130, 138, 137, 131];
nroIndices = array_length(vecIndices);

for (var i = 0; i < nroIndices; i++) {
    item = vecIndices[i];
    slots[i] = crearSlotNpc(item, 1, configurarItem(item).nombre);
}
