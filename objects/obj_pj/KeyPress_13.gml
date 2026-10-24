if (online_activo()) exit;
/// @description  Crea IA - Sube a nivel máximo (DEBUGGING)

/*

with (obj_persona) {
	salud = 0;
}

var idIA = instance_create_depth(x, y + TILE_SIZE, 0, obj_persona);

with (idIA) {
    guardarDatosIAEnGlobalIA();
}

subirNivelMaxGM()

*/

if (gpu_get_texfilter())
{
    gpu_set_texfilter(false);
}
else
{
    gpu_set_texfilter(true);
}