/// @description  Limpia el mundo

if (online_activo()) {
    contando = false;
    exit;
}

if (segundos > 0) {
    contando = true;
    segundos--;
    alarm[0] = SECOND;
} else if (segundos == 0) {
    contando = false;
    segundos = 15;
    alarm[1] = 1;
}

