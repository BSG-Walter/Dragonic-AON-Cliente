

function online_button(_left, _top, _right, _text) {
    draw_set_color(make_color_rgb(28, 45, 52));
    draw_rectangle(_left, _top, _right, _top + ONLINE_UI_BUTTON_HEIGHT, false);
    draw_set_color(c_aqua);
    draw_rectangle(_left, _top, _right, _top + ONLINE_UI_BUTTON_HEIGHT, true);
    draw_set_color(c_white);
    draw_text(_left + ONLINE_UI_TEXT_HEIGHT, _top + ONLINE_UI_TEXT_HEIGHT * 0.5, _text);
}

function online_ui_draw() {
    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(fnt_Vedrana_8_bold);
    if (room == rm_menuPrincipal && !obj_online.form_open)
        online_button(ONLINE_UI_RIGHT, 0, RESOLUTION_WIDTH, "Online");
    if (obj_online.form_open) {
        draw_set_color(make_color_rgb(15, 24, 31));
        draw_rectangle(ONLINE_UI_LEFT - ONLINE_UI_ROW, ONLINE_UI_TOP, ONLINE_UI_RIGHT + ONLINE_UI_ROW,
            ONLINE_UI_TOP + ONLINE_UI_FORM_HEIGHT, false);
        draw_set_color(c_white);
        draw_text(ONLINE_UI_LEFT, ONLINE_UI_TOP + ONLINE_UI_TEXT_HEIGHT, "Dragonic Online");
        online_button(ONLINE_UI_LOCAL_BUTTON_X, ONLINE_UI_TOP, ONLINE_UI_RIGHT, "Usar 127.0.0.1:8768");
        var _labels = ["Servidor", "Puerto", "Cuenta", "Contraseña"];
        for (var _i = 0; _i < 4; _i++) {
            var _y = ONLINE_UI_TOP + ONLINE_UI_ROW * (_i + 1);
            draw_set_color(c_white);
            draw_text(ONLINE_UI_LEFT, _y + ONLINE_UI_TEXT_HEIGHT * 0.5, _labels[_i]);
            draw_set_color(make_color_rgb(40, 50, 60));
            draw_rectangle(ONLINE_UI_FIELD_LEFT, _y, ONLINE_UI_RIGHT, _y + ONLINE_UI_BUTTON_HEIGHT, false);
            draw_set_color(obj_online.form_field == _i ? c_aqua : c_white);
            var _text = obj_online.form_values[_i];
            if (_i == 3) _text = string_repeat("*", string_length(_text));
            draw_text(ONLINE_UI_FIELD_LEFT + ONLINE_UI_TEXT_HEIGHT, _y + ONLINE_UI_TEXT_HEIGHT * 0.5,
                string_copy(_text, max(1, string_length(_text) - ONLINE_UI_ROW), ONLINE_UI_ROW));
        }
        online_button(ONLINE_UI_LEFT, ONLINE_UI_BUTTON_Y, ONLINE_UI_FIELD_LEFT + ONLINE_UI_ROW, "Entrar");
        online_button(ONLINE_UI_RIGHT - ONLINE_UI_FIELD_LEFT, ONLINE_UI_BUTTON_Y, ONLINE_UI_RIGHT, "Crear cuenta");
        online_button(ONLINE_UI_FIELD_LEFT, ONLINE_UI_CANCEL_Y, ONLINE_UI_RIGHT - ONLINE_UI_LEFT, "Cancelar");
    }
    if (obj_online.status_text != "") {
        draw_set_font(fnt_Vedrana_7_bold);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_text_ext(RESOLUTION_WIDTH div 2,
            global.online_elegir ? RESOLUTION_HEIGHT - ONLINE_UI_ROW : (room == rm_menuPrincipal || obj_online.form_open
            ? ONLINE_UI_STATUS_Y : ONLINE_UI_TEXT_HEIGHT),
            obj_online.status_text, -1, RESOLUTION_WIDTH - ONLINE_UI_ROW);
    }
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

function online_creacion_activa() {
    return global.online_elegir && (room == rm_crearPJ || room == rm_nombrePJ)
        && instance_exists(obj_online) && obj_online.authenticated && !obj_online.playing;
}

function online_creacion_limpiar() {
    with (obj_boton_crearPJ_basic) instance_destroy();
}

function online_creacion_volver() {
    online_creacion_limpiar();
    room_goto(rm_seleccionarPJ);
}

function online_selector_entrar(_index) {
    if (!obj_online.characters_ready || obj_online.playing || obj_online.enter_pending || obj_online.create_pending || obj_online.delete_pending
        || _index < 0 || _index >= array_length(obj_online.characters)) return false;
    var _slot = obj_online.characters[_index];
    if (!is_struct(_slot) || !is_string(_slot.nombre) || _slot.nombre == "") return false;
    if (!online_enviar({op: "enter", name: _slot.nombre})) return false;
    obj_online.character_selected = _index;
    obj_online.enter_pending = true;
    obj_online.enter_started_at = current_time;
    global.online_modo = true;
    obj_online.status_text = "Entrando con " + _slot.nombre + "...";
    return true;
}

function online_selector_crear() {
    if (!online_creacion_activa() || !obj_online.characters_ready
        || obj_online.create_pending || obj_online.enter_pending) return;
    if (array_length(obj_online.characters) >= 9) {
        obj_online.status_text = "La cuenta ya tiene nueve personajes";
        return;
    }
    if (!instance_exists(obj_nombrePJ) || !instance_exists(obj_skills)
        || !instance_exists(obj_flecha_clase_izq) || !instance_exists(obj_flecha_raza_izq)
        || !instance_exists(obj_flecha_sexo_izq) || !instance_exists(obj_cabezaPJ)
        || !instance_exists(obj_dados)) return;
    if (obj_skills.skillsLibres != 0) {
        obj_online.status_text = "Repartí los diez puntos de habilidad antes de crear";
        return;
    }
    var _name = string_trim(obj_nombrePJ.nombre);
    if (string_length(_name) < 2 || string_length(_name) > 24
        || string_lower(_name) == "restaurar_personaje") {
        obj_online.status_text = "El nombre debe tener entre 2 y 24 caracteres";
        return;
    }
    for (var _i = 1; _i <= string_length(_name); _i++) {
        if (ord(string_char_at(_name, _i)) < 32) {
            obj_online.status_text = "El nombre tiene caracteres inválidos";
            return;
        }
    }
    var _skills = [];
    for (var _i = 0; _i < 18; _i++) array_push(_skills, obj_skills.skills[_i]);
    var _cabeza = obj_cabezaPJ.cabezas[obj_cabezaPJ.seleccionado];
    if (_cabeza < 0) {
        obj_online.status_text = "Seleccioná una cabeza válida";
        return;
    }
    var _atributos = [];
    for (var _i = 0; _i < 5; _i++) array_push(_atributos, obj_dados.dados[_i]);
    if (online_enviar({op: "create_character", nombre: _name,
        clase: obj_flecha_clase_izq.seleccionado,
        genero: obj_flecha_sexo_izq.seleccionado,
        nroRaza: obj_flecha_raza_izq.seleccionado,
        sprCabeza: sprite_get_name(_cabeza), atributos: _atributos, skills: _skills})) {
        obj_online.character_create_name = _name;
        obj_online.create_pending = true;
        obj_online.create_started_at = current_time;
        obj_online.status_text = "Creando personaje en el servidor...";
    }
}

function online_selector_datos(_slot) {
    var _raza = variable_struct_exists(_slot, "nroRaza") ? clamp(_slot.nroRaza, 0, 4) : 0;
    var _genero = variable_struct_exists(_slot, "genero") ? clamp(_slot.genero, 0, 1) : 0;
    var _cabezas = [[1, 25], [30, 37], [42, 46], [62, 54], [51, 54]];
    var _head_name = variable_struct_exists(_slot, "sprCabeza") ? _slot.sprCabeza
        : "spr_cabeza_" + string(_cabezas[_raza][_genero]);
    var _cabeza = asset_get_index(_head_name);
    if (_cabeza < 0) _cabeza = spr_cabeza_1;
    var _cuerpo;
    if (_raza == 2) _cuerpo = _genero == 0 ? spr_cuerpo_negro_h : spr_cuerpo_negro_m;
    else if (_raza >= 3) _cuerpo = _genero == 0 ? spr_cuerpo_bajo_h : spr_cuerpo_bajo_m;
    else _cuerpo = _genero == 0 ? spr_cuerpo_alto_h : spr_cuerpo_alto_m;
    var _muerto = variable_struct_exists(_slot, "muerto") && _slot.muerto;
    var _desnudo = !variable_struct_exists(_slot, "desnudo") || _slot.desnudo;
    var _ropa = variable_struct_exists(_slot, "ropaActual") ? _slot.ropaActual : -1;
    if (!_desnudo && _ropa >= 0) {
        var _spriteRopa = online_selector_ropa(_ropa);
        if (_spriteRopa >= 0) _cuerpo = _spriteRopa;
    }
    var _arma = variable_struct_exists(_slot, "armaActual") ? obtenerSpriteArma(_slot.armaActual) : -1;
    var _escudo = variable_struct_exists(_slot, "escudoActual") ? obtenerSpriteEscudo(_slot.escudoActual) : -1;
    var _casco = variable_struct_exists(_slot, "cascoActual") ? _slot.cascoActual : -1;
    var _sprCasco = -1;
    if (_casco >= 93 && _casco <= 97) {
        var _cascos = [spr_casco_1, spr_casco_2, spr_casco_3, spr_gorro_1, spr_gorro_2];
        _sprCasco = _cascos[_casco - 93];
    }
    if (_muerto) { _cabeza = spr_cabeza_muerto; _cuerpo = spr_muerto; }
    return slotPJ(_slot.nombre, _raza, _cabeza,
        variable_struct_exists(_slot, "pk") && _slot.pk, _cuerpo, _arma, _escudo, _sprCasco);
}

function online_selector_ropa(_indice) {
    if (_indice >= 33 && _indice <= 44) return asset_get_index("spr_tunica_" + string(_indice - 32));
    if (_indice >= 45 && _indice <= 71) return asset_get_index("spr_ropa_" + string(_indice - 44));
    if (_indice >= 72 && _indice <= 92) return asset_get_index("spr_armadura_" + string(_indice - 71));
    if (_indice >= 164 && _indice <= 211) {
        var _bloque = (_indice - 164) div 6;
        var _nombre = _bloque mod 2 == 0 ? "spr_armada_" : "spr_legion_";
        var _pos = (_indice - 164) mod 6;
        var _nro = 1 + (_bloque div 2) * 3 + (_pos div 2) + ((_pos mod 2) * 12);
        return asset_get_index(_nombre + string(_nro));
    }
    switch (_indice) {
        case 212: return spr_armadura_22;
        case 213: return spr_armadura_23;
        case 214: return spr_armadura_25;
        case 215: return spr_armadura_24;
        case 216: return spr_armadura_26;
        case 222: return spr_armadura_27;
        case 223: return spr_armadura_28;
        case 224: return spr_armadura_29;
        case 225: return spr_armadura_30;
        case 226: return spr_armadura_31;
    }
    return -1;
}
