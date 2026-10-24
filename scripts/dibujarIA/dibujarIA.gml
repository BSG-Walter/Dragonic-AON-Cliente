/// @description  dibujarIA()
function dibujarIA() {

	if (!muerto) {

	    if (!enBarca) {
	        var _sprRopa = obtenerSpriteRopa(eqRopa);
        if (_sprRopa != -1) sprite_index = _sprRopa;
        var sprCascoGorro = -1;
        
	        if (eqCascoGorro != -1) {
	            switch (eqCascoGorro) {
	                case 93:
	                    sprCascoGorro = spr_casco_1;
	                    break;
	                case 96:
	                    sprCascoGorro = spr_gorro_1;
	                    break;
	            }
	        }    
            
	        if (nroRaza < 3) {
        
	            if (image_index >= 0 && image_index <= 4) {
	                draw_sprite(sprCabeza, 0, x, y - 36);
	            } else if (image_index >= 5 && image_index <= 9) {
	                draw_sprite(sprCabeza, 1, x, y - 36);
	            } else if (image_index >= 10 && image_index <= 14) {
	                draw_sprite(sprCabeza, 2, x, y - 36);
	            } else if (image_index >= 15 && image_index <= 19) {
	                draw_sprite(sprCabeza, 3, x, y - 36);
	            }
        
	            if (sprCascoGorro != -1) {
        
	                if (image_index >= 0 && image_index <= 4) {
	                    draw_sprite(sprCascoGorro, 0, x, y - 36);
	                } else if (image_index >= 5 && image_index <= 9) {
	                    draw_sprite(sprCascoGorro, 1, x, y - 36);
	                } else if (image_index >= 10 && image_index <= 14) {
	                    draw_sprite(sprCascoGorro, 2, x, y - 36);
	                } else if (image_index >= 15 && image_index <= 19) {
	                    draw_sprite(sprCascoGorro, 3, x, y - 36);
	                }
            
	            }
            
	        } else {
        
	            if (image_index >= 0 && image_index <= 4) {
	                draw_sprite(sprCabeza, 0, x, y - 28);
	            } else if (image_index >= 5 && image_index <= 9) {
	                draw_sprite(sprCabeza, 1, x, y - 28);
	            } else if (image_index >= 10 && image_index <= 14) {
	                draw_sprite(sprCabeza, 2, x, y - 28);
	            } else if (image_index >= 15 && image_index <= 19) {
	                draw_sprite(sprCabeza, 3, x, y - 28);
	            }
        
	            if (sprCascoGorro != -1) {

	                if (image_index >= 0 && image_index <= 4) {
	                    draw_sprite(sprCascoGorro, 0, x, y - 28);
	                } else if (image_index >= 5 && image_index <= 9) {
	                    draw_sprite(sprCascoGorro, 1, x, y - 28);
	                } else if (image_index >= 10 && image_index <= 14) {
	                    draw_sprite(sprCascoGorro, 2, x, y - 28);
	                } else if (image_index >= 15 && image_index <= 19) {
	                    draw_sprite(sprCascoGorro, 3, x, y - 28);
	                }

	            }

	        }

	        // Arma y Escudo
	        if (sprArma != -1) {
	            var armaY = (nroRaza < 3) ? y : (y + 4);
	            draw_sprite(sprArma, (direccion * 4) + frameArma, x, armaY);
	        }

	        if (sprEscudo != -1) {
	            draw_sprite(sprEscudo, (direccion * 4) + frameEscudo, x, y);
	        }
	    } else {
	        sprite_index = spr_barca;
	    }
    
	} else {
        
	    if (!enBarca) {
	        sprite_index = spr_muerto;
    
	        if (image_index >= 0 && image_index <= 4) {
	            draw_sprite(spr_cabeza_muerto, 0, x, y - 27);
	        } else if (image_index >= 5 && image_index <= 9) {
	            draw_sprite(spr_cabeza_muerto, 1, x, y - 27);
	        } else if (image_index >= 10 && image_index <= 14) {
	            draw_sprite(spr_cabeza_muerto, 2, x, y - 27);
	        } else if (image_index >= 15 && image_index <= 19) {
	            draw_sprite(spr_cabeza_muerto, 3, x, y - 27);
	        }
	    } else {
	        sprite_index = spr_barca_muerto;
	    }

	}



}
