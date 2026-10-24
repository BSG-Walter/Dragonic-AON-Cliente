/// @description  Dibujo

draw_set_halign(fa_center);
draw_set_alpha(image_alpha);
draw_set_font(fuente);
draw_set_color(c_black);
draw_text(x, y - desfaseY - modY, string_hash_to_newline(texto));
draw_set_color(color);
draw_text(x - 1, y - desfaseY + 1 - modY, string_hash_to_newline(texto));
draw_set_color(c_black);
draw_set_alpha(1);
draw_set_halign(fa_left);

