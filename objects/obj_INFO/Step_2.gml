/// @description  Sincroniza posicion con el padre sin lag de 1 frame

if (instance_exists(padre)) {
    x = padre.x;
    y = padre.y;
    depth = padre.depth - 10;
}
