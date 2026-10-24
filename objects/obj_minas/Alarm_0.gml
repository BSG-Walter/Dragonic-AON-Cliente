/// @description  Creo los bloqueos y modifico el gráfico

if (indice == 0) {
    var idBloqueo = instance_create_depth(x - 16, y - 64, 0, obj_bloqueo_minas);
    idBloqueo.tipo = tipo;
    idBloqueo.image_yscale = 2;
} else {
    var idBloqueo = instance_create_depth(x - 16, y - TILE_SIZE, 0, obj_bloqueo_minas);
    idBloqueo.tipo = tipo;
}

if (tipo == "plata") {
    indice += 4;
} else if (tipo == "oro") {
    indice += 8;
}

image_index = indice;

