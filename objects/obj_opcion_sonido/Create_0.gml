/// @description  Estado inicial

depth = DEPTH_MENU_OPTION;
image_speed = 0;
sonidoActivado = true;

ini_open("opciones.ini");
sonidoActivado = read("opciones", "sonidoActivado", true);
ini_close(); 

if (sonidoActivado) {
    image_index = 0;
} else {
    image_index = 1;
}



