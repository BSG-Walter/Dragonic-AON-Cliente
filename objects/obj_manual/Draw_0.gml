/// @description  Dibujo

if (obj_ayuda.mostrado) {
    draw_set_alpha(0.85);
    draw_sprite(sprite_index, pagina, global.render_x + get_render_width() * 0.5, global.render_y + get_render_height() * 0.5);
    draw_set_alpha(1);
}

