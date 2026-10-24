/// @description  Estado inicial

/*

    Total = 20

    0-Curar Veneno
    1-Curar Heridas Leves
    2-Curar Heridas Graves
    3-Remover Parálisis
    4-Invisibilidad
    5-Dardo Mágico
    6-Flecha Mágica
    7-Flecha Eléctrica
    8-Misil Mágico
    9-Tormenta de Fuego
    10-Descarga Eléctrica
    11-Apocalipsis
    12-Paralizar
    13-Inmovilizar
    14-Llamado a la Naturaleza
    15-Invocar Zombies
    16-Invocar Elemental de Agua
    17-Invocar Elemental de Fuego
    18-Invocar Elemental de Tierra
    19-Invocar Mascotas

*/

image_speed = 0;
visible = false;

maximoHechizos = 20;
seleccionado = -1;

moviendoHechizo = false;
posHechizoAMover = 0;
posSeleccionado = -1;

var i = 0;

repeat(maximoHechizos) {
    hechizos[i] = hechizoVacio();
    i++;
}

// Dardo mágico para magos

if (obj_pj.clase == 7) {
    hechizos[0] = crearHechizo(5, "Dardo Mágico", "negro", 10, 1, 5, 4, 6, "OHL VOR PEK");
}

// Seleccionar el primer hechizo disponible por defecto
var i = 0;
repeat(maximoHechizos) {
    if (hechizos[i].indice != -1) {
        seleccionado = hechizos[i].indice;
        posSeleccionado = i;
        break;
    }
    i++;
}

// Doble clic

dobleClic = false;
posDobleClic = -1;

// Paneles

primerPanel = true;
depth = DEPTH_PANEL
/* */
/*  */
