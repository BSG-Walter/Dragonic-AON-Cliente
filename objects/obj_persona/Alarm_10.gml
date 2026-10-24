/// @description  Muerte
reproducirSonido(snd_muerte, false, false);

palabrasMagicas = "";
dicePalabrasMagicas = false;
inmovilizado = false;
salud = 0;
mana = 0;
agitando = false;
enemigo = false;

if (!enBarca && !is_special_room()) {
    alarm[11] = 1;
}

if (instance_number(obj_INFO) > 0) {
    with (obj_INFO) {
        if (padre == other.id) {
            instance_destroy();
        }   
    }
}

var i = 0;
while (i < obj_personas_mundo.totalMultiIA) {
    var _slot = obj_personas_mundo.globalIA[i];
    if (_slot.x != -1 && _slot.nombre == nombre) {
        break;
    }
    i++;
}

obj_personas_mundo.globalIA[i] = datosIAVacio();

obj_respawn_personas.alarm[0] = random_range(obj_respawn_personas.intervaloMin, obj_respawn_personas.intervaloMax);
