/// @description  Control general

// Control posición
var _render_x = obj_pj.x - mitadAnchoV;
var _render_y = obj_pj.y - mitadAltoV;
if (visible) {
	
	if (x >= _render_x + anchoV) {
		x -= anchoV;
	} else if (x <= _render_x) {
	    x += anchoV;
	}

	if (y >= _render_y + altoV) {
	    y -= altoV;
		instance_create_depth(_render_x + random(anchoV), _render_y + random(altoV), 0, obj_salpicadura);
	} else if (y <= _render_y) {
	    // y += altoV;
	}

	y += ySpd;
	x -= xSpd;

}