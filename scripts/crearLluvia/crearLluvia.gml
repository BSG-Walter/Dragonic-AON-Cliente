/// @description  crearLluvia(cantidad, offsetX, offsetY)
/// @param cantidad
/// @param offsetX
/// @param offsetY
function crearLluvia(argument0, argument1, argument2) {
	repeat(argument0) {
		instance_create_depth(obj_pj.x + random(300) * choose(1, -1) + argument1, obj_pj.y + random(140) * choose(1, -1) + argument2, 0, obj_lluvia);
	}
}
