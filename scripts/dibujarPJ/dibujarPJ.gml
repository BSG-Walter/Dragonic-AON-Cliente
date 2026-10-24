/// @description  dibujarPJ(nroPJ)
/// @param nroPJ
function dibujarPJ(argument0) {

    var _online = global.online_elegir && room == rm_seleccionarPJ;
    if (_online) {
        if (!instance_exists(obj_online) || !obj_online.characters_ready
            || argument0 < 1 || argument0 > array_length(obj_online.characters)) return;
    } else if (!file_exists("partida" + string(argument0) + ".ini")) return;
    {

	    var X;
	    var Y;
    
	    switch (argument0) {
	        case 1:        
	            X = 79;    
	            Y = 144;
	            break;    
	        case 2:        
	            X = 189;    
	            Y = 144;
	            break;    
	        case 3:        
	            X = 300;    
	            Y = 144;
	            break;    
	        case 4:        
	            X = 411;    
	            Y = 144;
	            break;    
	        case 5:        
	            X = 522;    
	            Y = 144;
	            break;    
	        case 6:        
	            X = 134;    
	            Y = 267;
	            break;    
	        case 7:        
	            X = 244;    
	            Y = 267;
	            break;    
	        case 8:        
	            X = 354;    
	            Y = 267;
	            break;    
	        case 9:        
	            X = 466;    
	            Y = 267;
	            break;            
	    }    
    
        var _pj = _online ? online_selector_datos(obj_online.characters[argument0 - 1])
            : datosPJ[argument0];
    
	    if (_pj.imgRopa == spr_muerto) {
	        draw_set_alpha(0.5);
	    }
	    draw_sprite(_pj.imgRopa, 0, X, Y);
	    draw_set_alpha(1);
            
	    if (_pj.nroRaza < 3) {
	        if (_pj.sprCabeza == spr_cabeza_muerto) {
	            draw_set_alpha(0.5);
	            draw_sprite(spr_cabeza_muerto, 0, X, Y - 27); 
	            draw_set_alpha(1);
	        } else {
	            draw_sprite(_pj.sprCabeza, 0, X, Y - 36); 
	        }
	        if (_pj.imgCasco != -1) {
	            draw_sprite(_pj.imgCasco, 0, X, Y - 36);  
	        }
	        if (_pj.imgArma != -1) {
	            draw_sprite(_pj.imgArma, 0, X, Y);   
	        }                              
	    } else {
	        if (_pj.sprCabeza == spr_cabeza_muerto) {
	            draw_set_alpha(0.5);
	            draw_sprite(spr_cabeza_muerto, 0, X, Y - 27); 
	            draw_set_alpha(1);
	        } else {
	            draw_sprite(_pj.sprCabeza, 0, X, Y - 28); 
	        }
	        if (_pj.imgCasco != -1) {
	            draw_sprite(_pj.imgCasco, 0, X, Y - 28);  
	        }
	        if (_pj.imgArma != -1) {
	            draw_sprite(_pj.imgArma, 0, X, Y + 4); 
	        }                                     
	    }  
    
	    if (_pj.imgEscudo != -1) {
	        draw_sprite(_pj.imgEscudo, 0, X, Y);
	    }     
    
	    draw_set_halign(fa_center);
	    draw_set_font(fnt_Vedrana_8_bold);    
	    draw_set_color(c_black);
	    draw_text(X + 1, Y + 1, string_hash_to_newline(_pj.nombre));
    
	    if (!_pj.pk) {
	        var color = make_color_rgb(65, 134, 175);
	    } else {
	        var color = make_color_rgb(199, 16, 26);
	    }    
    
	    draw_set_color(color);
	    draw_text(X, Y + 2, string_hash_to_newline(_pj.nombre));

	}



}
