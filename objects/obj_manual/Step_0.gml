/// @description  Control general

if (obj_ayuda.mostrado) {
    visible = true;
    x = global.render_x + get_render_width() * 0.5;
    y = global.render_y + get_render_height() * 0.5;
} else {
    visible = false;
    pagina = 0;
}

