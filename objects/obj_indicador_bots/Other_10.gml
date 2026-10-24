/// @description Insert description here
// You can write your code in this editor
obj_opciones.maxBots = value;
ini_open("opciones.ini");
write("dificultad", "maxBots", obj_opciones.maxBots);
ini_close(); 