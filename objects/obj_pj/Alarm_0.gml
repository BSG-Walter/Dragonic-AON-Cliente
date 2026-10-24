/// @description  Gráfico

if (!puedeMoverse) {

    image_index = index[direccion, frame];
    
    if (frame < 5) {
        frame++;
        if (frame == 5) {
            frame = 0
        }
    }
    
    if (armaActual != -1) {
        // No pisar la animación de ataque
        if (alarm[8] == -1) {
            if (frameArma < 5) {
                frameArma++;
                if (frameArma == 5) {
                    frameArma = 0;
                }
            }
        }
    }

    if (escudoActual != -1) {
        if (frameEscudo < 5) {
            frameEscudo++;
            if (frameEscudo == 5) {
                frameEscudo = 0;
            }
        }
    }

} else {

    image_index = index[direccion, 0];

    if (armaActual != -1) {
        if (alarm[8] == -1) {
            frameArma = 0;
        }
    }
    
    if (escudoActual != -1) {
        frameEscudo = 0;
    }

}
alarm[0] = 4;
