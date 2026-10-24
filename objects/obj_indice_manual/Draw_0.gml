/// @description  Dibujo

if (obj_ayuda.mostrado) {
    draw_set_alpha(0.75);
    draw_sprite(sprite_index, 0, global.render_x + get_render_width() * 0.5 - 192, global.render_y + get_render_height() * 0.5 + 108);
    draw_set_alpha(1);
}

