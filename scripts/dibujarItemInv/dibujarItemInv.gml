/// @description  dibujarItemInv(idItem, offY, posicion)
/// @param idItem
/// @param  offY
/// @param  posicion
function dibujarItemInv(argument0, argument1, argument2) {

	var _slot = slots[argument0];

	if (_slot.indice != -1) {
	    draw_sprite(spr_items, _slot.indice, global.inventario_x + 136 + argument2, global.inventario_y + 40 + argument1);
	    draw_text(global.inventario_x + 152 + argument2, global.inventario_y + 28 + argument1, string_hash_to_newline(string(_slot.cant)));
    
	    if (_slot.equipado) {
	        draw_sprite(spr_cruz_equipado, 0, global.inventario_x + 136 + argument2, global.inventario_y + 40 + argument1);
	    }
    
	    if (obj_pj.atacaConArco && obj_pj.armaEnInv == argument0) {
	        draw_set_halign(fa_left);
	        draw_set_color(c_yellow);
	        draw_text(global.inventario_x + 122 + argument2, global.inventario_y + 8 + argument1, string_hash_to_newline("U"));
	        draw_set_color(c_white);
	        draw_set_halign(fa_right);
	    }
	}

	if (posSeleccionado == argument0) {
		if (obj_mover_inventario.moviendoItem)
			draw_sprite(spr_borde_inv_moviendo, 0, global.inventario_x + 136 + argument2, global.inventario_y + 40 + argument1);
		else
			draw_sprite(spr_borde_inv, 0, global.inventario_x + 136 + argument2, global.inventario_y + 40 + argument1);
	}

}
