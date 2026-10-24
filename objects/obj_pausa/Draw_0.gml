/// @description  Dibuja el menú

draw_sprite(bck_pausa, 0, global.render_x, global.render_y);

//set_render_width(get_render_width());
//set_render_height(get_render_height());

draw_set_valign(fa_middle);
draw_set_halign(fa_center);
draw_set_colour(c_white);

// Skills

draw_set_halign(fa_left);

draw_set_font(fnt_Vedrana_5_bold);

for (var i = 0; i < 18; i++) {
    draw_text(global.render_x + 96, global.render_y + 88 + 8 * i, string_hash_to_newline(textoSkill(i) + ": " + string(skills[i])));
}

// Datos PJ

draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_font(fnt_Vedrana_5_bold);

draw_text(global.render_x + 96, global.render_y + 264, string_hash_to_newline("Experiencia: " + string(experiencia) + "/" + string(expLvl[nivel])));
draw_text(global.render_x + 96, global.render_y + 264 + 8, string_hash_to_newline("Fuerza: " + string(atributos[0])));
draw_text(global.render_x + 96, global.render_y + 264 + 16, string_hash_to_newline("Agilidad: " + string(atributos[1])));
draw_text(global.render_x + 96, global.render_y + 264 + 24, string_hash_to_newline("Inteligencia: " + string(atributos[2])));
draw_text(global.render_x + 96, global.render_y + 264 + 32, string_hash_to_newline("Carisma: " + string(atributos[3])));
draw_text(global.render_x + 96, global.render_y + 264 + 40, string_hash_to_newline("Constitución: " + string(atributos[4])));

claseTxt = "";

switch (clase) {
    case 0:
        claseTxt = "Arquero";
        break;
    case 1:
        claseTxt = "Asesino";
        break;
    case 2:
        claseTxt = "Bardo";
        break;
    case 3:
        claseTxt = "Cazador";
        break;
    case 4:
        claseTxt = "Clérigo";
        break;
    case 5:
        claseTxt = "Druida";
        break;
    case 6:
        claseTxt = "Guerrero";
        break;
    case 7:
        claseTxt = "Mago";
        break;
    case 8:
        claseTxt = "Paladín";
        break;
}

draw_text(global.render_x + 96, global.render_y + 264 + 48, string_hash_to_newline("Clase: " + claseTxt));

var totalMatados = ciudadanosMatados + criminalesMatados;

draw_text(global.render_x + 96, global.render_y + 264 + 56, string_hash_to_newline("Personas matadas: " + string(totalMatados)));
draw_text(global.render_x + 96, global.render_y + 264 + 64, string_hash_to_newline("Ciudadanos matados: " + string(ciudadanosMatados)));
draw_text(global.render_x + 96, global.render_y + 264 + 72, string_hash_to_newline("Criminales matados: " + string(criminalesMatados)));

// Mapa

draw_set_halign(fa_center);
draw_sprite(spr_mapa, roomDesconocida, global.render_x + 230, global.render_y + 96);

draw_set_valign(fa_middle);
draw_set_font(fnt_Vedrana_5_bold);
draw_text_ext(global.render_x + 295, global.render_y + 200, string_hash_to_newline(nombreMapaPausa), 8, 60);
draw_set_valign(fa_top);

if (online_activo() && instance_exists(obj_online)
    && obj_online.save_state != 0
    && (obj_online.save_state == 1 || current_time < obj_online.save_feedback_until)) {
    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
    draw_set_font(fnt_Vedrana_8_bold);
    draw_set_colour(obj_online.save_state == 2 ? c_lime : (obj_online.save_state == 1 ? c_yellow : c_red));
    draw_text(global.render_x + get_render_width() * 0.5, global.render_y + 2,
        string_hash_to_newline(obj_online.save_feedback));
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
} else if (dibuja) {

    draw_set_valign(fa_top);
    draw_set_halign(fa_center);
    draw_set_font(fnt_Vedrana_8_bold);
    
    if (pudoGuardar) {
        draw_set_colour(c_lime);
        draw_text(global.render_x + get_render_width() * 0.5, global.render_y + 2, string_hash_to_newline("Partida guardada"));
    } else {
        draw_set_colour(c_red);
        if (IACerca) {
            draw_text(global.render_x + get_render_width() * 0.5, global.render_y + 2, string_hash_to_newline("No podés guardar la partida habiendo enemigos cerca tuyo"));
        } else {
            draw_text(global.render_x + get_render_width() * 0.5, global.render_y + 2, string_hash_to_newline("No se pudo guardar la partida"));
        }
    }
    
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);

}

