if (online_activo()) { lanzar(); exit; }
/// @description  Lanzo hechizo

if (seleccionado != -1) {

    for (var i = 0; i < maximoHechizos; i++) {
        if (seleccionado == hechizos[i].indice) {
            break;
        }
    }
    
    if (obj_pj.puedeAtacar) {
        obj_pj.atacaConHechizo = true;
    }
    
}

obj_tecla_lanzar.alarm[0] = 2;