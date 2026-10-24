/// @description Animación ataque con arma

if (!muerto) {
    if (frameArma <= 2) {
        frameArma++;
        alarm[3] = 2.5;
    } else {
        frameArma = 0;
    }
}
