
if (is_undefined(data)) exit;
draw_set_color(c_white);
draw_set_alpha(1);
if (data.kind == "drop") {
    draw_sprite(data.indice >= 0 ? spr_items : spr_oro, data.indice >= 0 ? data.indice : 0, x, y);
    exit;
}
var _moving = point_distance(x, y, data.x, data.y) > 1;
var _frame = walk_frame;
if (data.kind == "npc") {
    if (sprite_exists(sprite_index)) {
        var _row = data.frames[data.direccion];
        draw_sprite(sprite_index, _row[_frame mod array_length(_row)], x, y);
    }
    if (is_struct(npc_head) && sprite_exists(npc_head.sprite))
        draw_sprite(npc_head.sprite, npc_head.gira ? data.direccion : 0, x + npc_head.x, y - npc_head.y);
} else {
    var _sprite = data.nroRaza < 3 ? (data.nroRaza == 2 ? (data.genero == 0 ? spr_cuerpo_negro_h : spr_cuerpo_negro_m)
        : (data.genero == 0 ? spr_cuerpo_alto_h : spr_cuerpo_alto_m))
        : (data.genero == 0 ? spr_cuerpo_bajo_h : spr_cuerpo_bajo_m);
    var _ropa = obtenerSpriteRopa(data.ropaActual);
    if (_ropa >= 0) _sprite = _ropa;
    if (data.muerto) _sprite = spr_muerto;
    if (data.navega) _sprite = data.muerto ? spr_barca_muerto
        : (data.esArmada ? spr_barca_Ciuda : (data.esLegion ? spr_barca_PK : spr_barca));
    draw_set_alpha(data.muerto ? (data.navega ? ONLINE_GHOST_BOAT_ALPHA : ONLINE_GHOST_ALPHA)
        : (data.invisible ? ONLINE_GHOST_ALPHA : 1));
    if (sprite_exists(_sprite)) draw_sprite(_sprite, data.direccion * ONLINE_BODY_FRAMES + _frame, x, y);
    if (!data.navega) {
        var _head = data.muerto ? spr_cabeza_muerto : asset_get_index(data.sprCabeza);
        var _offset = data.muerto ? ONLINE_HEAD_GHOST : (data.nroRaza < 3 ? ONLINE_HEAD_TALL : ONLINE_HEAD_SHORT);
        if (sprite_exists(_head)) draw_sprite(_head, data.direccion, x, y - _offset);
        if (!data.muerto) {
            var _helmets = [spr_casco_1, spr_casco_2, spr_casco_3, spr_gorro_1, spr_gorro_2];
            var _helmet = data.cascoActual - ONLINE_HELMET_BASE;
            if (_helmet >= 0 && _helmet < array_length(_helmets)) draw_sprite(_helmets[_helmet], data.direccion, x, y - _offset);
            var _weapon = obtenerSpriteArma(data.armaActual);
            if (sprite_exists(_weapon)) draw_sprite(_weapon, data.direccion * ONLINE_WEAPON_FRAMES + weapon_frame,
                x, y + (data.nroRaza < 3 ? 0 : ONLINE_WEAPON_SHORT_OFFSET));
            var _shield = obtenerSpriteEscudo(data.escudoActual);
            if (sprite_exists(_shield)) draw_sprite(_shield, data.direccion * ONLINE_WEAPON_FRAMES + weapon_frame, x, y);
        }
    }
    draw_set_alpha(1);
}
if (data.kind == "player" && data.meditando) {
    var _aura = data.nivel < 15 ? spr_meditacion_1
        : (data.nivel < 30 ? spr_meditacion_2
        : (data.nivel < 40 ? spr_meditacion_3
        : (data.nivel < 47 ? spr_meditacion_4 : spr_meditacion_5)));
    draw_sprite_ext(_aura, floor(current_time / 33) mod sprite_get_number(_aura), x, y, 1, 1, 0, c_white, 0.5);
}
if (data.kind != "npc") {
    var _nombreMostrar = data.nombre;
    var _etiquetaBot = "";
    if (data.kind == "bot") {
        if (bot_nombre_cache != data.nombre) {
            bot_nombre_cache = data.nombre;
            var _etiquetaInicio = string_pos(" [Bot lvl ", data.nombre);
            bot_nombre_visible = _etiquetaInicio > 0
                ? string_copy(data.nombre, 1, _etiquetaInicio - 1) : data.nombre;
            bot_etiqueta_nivel = _etiquetaInicio > 0
                ? string_copy(data.nombre, _etiquetaInicio + 1, string_length(data.nombre) - _etiquetaInicio) : "";
        }
        _nombreMostrar = bot_nombre_visible;
        _etiquetaBot = bot_etiqueta_nivel;
    }

    draw_set_font(fnt_Vedrana_8_bold);
    draw_set_halign(fa_center);
    draw_set_color(c_black);
    draw_text(x + 1, y + 1, string_hash_to_newline(_nombreMostrar));

    var _color = data.pk
        ? (data.esLegion ? ONLINE_NAME_LEGION_COLOR : ONLINE_NAME_PK_COLOR)
        : (data.esArmada ? ONLINE_NAME_ARMADA_COLOR : ONLINE_NAME_CITIZEN_COLOR);
    draw_set_color(_color);
    draw_text(x, y + 2, string_hash_to_newline(_nombreMostrar));
    if (variable_struct_exists(data, "insigniaPionero") && data.insigniaPionero && obj_opciones.opcionInsigniaPionero)
        draw_sprite(spr_insignia, 0, x - floor(string_width(_nombreMostrar) / 2) - ONLINE_INSIGNIA_OFFSET, y + ONLINE_INSIGNIA_Y);

    if (data.esLegion || data.esArmada) {
        var _faccion = data.esLegion ? "<Legión Oscura>" : "<Armada Imperial>";
        draw_set_color(c_black);
        draw_text(x + 1, y + 12, _faccion);
        draw_set_color(_color);
        draw_text(x, y + 13, _faccion);
    }
    if (_etiquetaBot != "") {
        var _desplazamiento = (data.esLegion || data.esArmada) ? ONLINE_BOT_LEVEL_LINE_OFFSET : 0;
        draw_set_color(c_black);
        draw_text(x + 1, y + 12 + _desplazamiento, _etiquetaBot);
        draw_set_color(_color);
        draw_text(x, y + 13 + _desplazamiento, _etiquetaBot);
    }
}
var _manaMax = variable_struct_exists(data, "manaMax") ? data.manaMax : 0;
online_dibujar_barras(x, y, data.salud, data.saludMax,
    _manaMax > 0 ? data.mana : 0, _manaMax, data.kind != "npc");
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_set_alpha(1);

if (dicePalabrasMagicas && current_time < words_until) {
    draw_set_halign(fa_center);
    draw_set_color(c_aqua);
    draw_text(x, y - TILE_SIZE * 2, palabrasMagicas);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}
