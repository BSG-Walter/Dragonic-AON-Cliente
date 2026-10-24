/// @description  Se destruyen

var idINFO = instance_create_depth(x, y, 0, obj_INFO);
idINFO.padre = obj_pj.id;
idINFO.texto = "¡Tu elemental se ha ido!";

instance_destroy();

