// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function dibujarBarraChica(posX, posY, value, maxValue, color){
	draw_sprite_ext(spr_barra_back_chica, 0, posX, posY, 1, 1, 0, c_dkgray, 1 );
	// Mismo cociente real para hambre/sed del estado v4.
	var _fill = maxValue > 0 ? clamp(real(value) / real(maxValue), 0.0, 1.0) : 0.0;
	draw_sprite_ext(spr_barra_base_chica, 0, posX, posY, _fill, 1, 0, color, 1 );

	draw_set_color(c_black);
	draw_set_halign(fa_center);
	draw_text_ext(posX + 20, posY - 3, string(value) + "/" + string(maxValue), 0, 100);
	draw_set_color(c_white);
	draw_text_ext(posX + 19, posY - 2, string(value) + "/" + string(maxValue), 0, 100);
}
