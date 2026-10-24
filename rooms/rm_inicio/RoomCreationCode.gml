/// @description  Inicializa el juego

os_powersave_enable(false);
randomizar();
crearArchivoNombresIA();
//show_debug_overlay(true);
//texture_debug_messages(true);
application_surface_enable(false);

switch (os_type)
{
	case os_windows: global.Config = 0; break;
	case os_linux: global.Config = 1; break;
	case os_macosx: global.Config = 2; break;
	case os_android: global.Config = 3; break;
	case os_ios: global.Config = 4; break;
	case os_winphone: global.Config = 5; break;
}
instance_create_depth(0, 0, ONLINE_DEPTH, obj_online);
