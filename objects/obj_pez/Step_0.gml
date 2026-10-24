/// @description  Control general

if (!esPescado) {
    if (sube) {
        direction += giro;
    } else {
        direction -= giro;
    }
    
    // Chequear costa solo cada 8 frames para minimizar CPU
    step_check++;
    if (step_check >= 8) {
        step_check = 0;
        
        var nextX = x + lengthdir_x(24, direction);
        var nextY = y + lengthdir_y(24, direction);
        if (!hayAguaEn(nextX, nextY)) {
            direction += 180 + random_range(-45, 45);
        }
        
        visible = hayAguaEn(x, y);
    }
} else {
    visible = true;
    path_speed = 1.85;
    persistent = false;
}

image_angle = direction;

// Control posición (wrap alrededor de la vista)
var anchoV = 600;
var altoV = 280;

if (x >= global.render_x + anchoV) {
    x -= anchoV;
} else if (x <= global.render_x) {
    x += anchoV;
}

if (y >= global.render_y + altoV) {
    y -= altoV;
} else if (y <= global.render_y) {
    y += altoV;
}
