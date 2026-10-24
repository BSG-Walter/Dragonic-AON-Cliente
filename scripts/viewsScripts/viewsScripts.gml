// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

//Gets
function get_inventario_x(){
	return get_render_x() //la posicion x siempre tiene que ser la misma que el render
}

function get_inventario_y(){
	return get_render_y() + get_render_height();
}

function get_inventario_width(){
	return INVENTARIO_WIDTH;
}

function get_inventario_height(){
	return INVENTARIO_HEIGHT;
}

function get_render_x(){
	return camera_get_view_x(view_camera[0])
}

function get_render_y(){
	return camera_get_view_y(view_camera[0])
}

function get_render_width(){
	return RENDER_WIDTH;
}

function get_render_height(){
	return RENDER_HEIGHT;
}

//Sets

function set_render_x(_x){
	camera_set_view_pos(view_camera[0], _x, global.render_y)
}

function set_render_y(_y){
	camera_set_view_pos(view_camera[0], global.render_x, _y)
}

//Esta funcion no tienen por que usarse, ya que por ahora seteamos la resolucion por constantes
function set_render_resolution(_w, _h){
	camera_set_view_size(view_camera[0], _w, _h)
}