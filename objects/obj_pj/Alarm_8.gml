/// @description  Animación ataque con arma

puedeAtacar = false;

if (frameArma <= 2) {
    frameArma++;
    alarm[8] = 2.5;
} else {
    frameArma = 0;
}
