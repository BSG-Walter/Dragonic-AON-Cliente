/// @description  Dibujo

if (obj_ayuda.mostrado) {
    draw_set_alpha(0.75);
    draw_sprite(spr_flecha_der_manual, 0, global.render_x + get_render_width() * 0.5 + 384 * 0.5 - 2, global.render_y + get_render_height() * 0.5 + 216 * 0.5 - 2);
    draw_set_alpha(1);
}

