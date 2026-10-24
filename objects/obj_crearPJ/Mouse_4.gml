/// @description  Crea el PJ

if (room == rm_crearPJ) {
    if (online_creacion_activa()) {
        online_selector_crear();
        exit;
    }
    if (obj_nombrePJ.nombre != "" && obj_skills.skillsLibres == 0) {
        room_goto(rm_79);
        crearObjetosBasicos(-1);
        
    }
}

