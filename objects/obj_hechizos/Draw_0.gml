/// @description  Dibujo los hechizos

if (visible) {
    
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_sprite(spr_fondo_hechizos, 0, global.inventario_x + 121, global.inventario_y + 8);
    draw_set_alpha(1);
    
    draw_set_font(fnt_Vedrana_7_bold);
    draw_set_color(c_white);
    draw_set_halign(fa_right);
    
	for (var i = 0; i < maximoHechizos/2; ++i) {
		var _x_offset = 153 + 64 * i
		var _y_offset = 22
		var _hechizo_index = i
		if (i >= maximoHechizos/4){//segunda fila
			_y_offset+= 32
			_x_offset-= 320
		}
		if (!primerPanel) _hechizo_index+=10
		
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		
		draw_text_ext(global.inventario_x + _x_offset, global.inventario_y + _y_offset, string_hash_to_newline(hechizos[_hechizo_index].nombre), 9, 64);
		                    
        draw_set_valign(fa_top);
        draw_set_halign(fa_left);
                    
        if (!moviendoHechizo) {
                    
            if (obj_pj.skills[0] < hechizos[_hechizo_index].skill) {
                    draw_sprite(spr_hechizo_invalido, 0, global.inventario_x + _x_offset, global.inventario_y + _y_offset);
            }
			
			if (posSeleccionado == _hechizo_index){
				draw_sprite(spr_borde_hechizos, 0, global.inventario_x + _x_offset, global.inventario_y + _y_offset);
			}
                    
        } else if (posHechizoAMover == _hechizo_index) {
            draw_sprite(spr_moviendo_hechizo, 0, global.inventario_x + _x_offset, global.inventario_y + _y_offset);
        }
	}
    
    draw_set_halign(fa_left);

}




