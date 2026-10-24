/// @description  Control gráfico
    
if (moviendose && !inmovilizado && !muerto) {

    image_index = index[direccion, frame];
    
    if (frame < 4) {
        frame++;
    } else {
        frame = 0;
    }
    
    // No pisar animación de ataque (alarm[3])
    if (alarm[3] == -1) {
        if (frameArma < 3) {
            frameArma++;
        } else {
            frameArma = 0;
        }
    }

    if (frameEscudo < 3) {
        frameEscudo++;
    } else {
        frameEscudo = 0;
    }

} else {
    image_index = index[direccion, 0];
    if (alarm[3] == -1) {
        frameArma = 0;
    }
    frameEscudo = 0;
}

alarm[1] = 6.25;

