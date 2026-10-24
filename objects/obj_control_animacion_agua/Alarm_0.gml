/// @description  Cambiar dirección

if (obj_opciones.opcionAnimacionAgua) {

	direccionX = direccionX * -1;
    
    if (random(10) > 5) {
        direccionY = 1;
    } else {
        direccionY = -1;
    }
    
    alarm[0] = SECOND * 10;
    
}


