/// @description  Se destruyen

if (instance_number(obj_npc_lobo_invocado) == 1) {
    var idINFO = instance_create_depth(x, y, 0, obj_INFO);
    idINFO.padre = obj_pj.id;
    idINFO.texto = "¡Tus lobos se han ido!";
}

instance_destroy();

