/// @description  Control general

var _render_x = obj_pj.x - mitadAnchoV;
var _render_y = obj_pj.y - mitadAltoV;

image_angle++;

if (subiendo) {
    image_alpha += 0.005;
} else {
    image_alpha -= 0.005;
}

if (image_alpha >= 0.45 || image_alpha <= 0) {
    alarm[0] = 1;
}

// Control posición

if (x >= _render_x + anchoV) {
    x -= anchoV;
} else if (x <= _render_x) {
    x += anchoV;
}

if (y >= _render_y + altoV) {
    y -= altoV;
} else if (y <= _render_y) {
    y += altoV;
}

