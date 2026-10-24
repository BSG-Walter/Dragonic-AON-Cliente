if (online_activo() && (obj_panel_items.mostrado || instance_exists(obj_pausa))) exit;
if (global.online_exportando) exit;
/// @description Controles de teclado y mando

var _moveH = gamepad_axis_value(GAMEPAD_PLAYER, gp_axislh);
var _moveV = gamepad_axis_value(GAMEPAD_PLAYER, gp_axislv);
obj_pj.upKey = keyboard_check(key_up) || obj_flecha_arriba.apretada || _moveV < -GAMEPAD_MOVE_DEADZONE;
obj_pj.downKey = keyboard_check(key_down) || obj_flecha_abajo.apretada || _moveV > GAMEPAD_MOVE_DEADZONE;
obj_pj.leftKey = keyboard_check(key_left) || obj_flecha_izq.apretada || _moveH < -GAMEPAD_MOVE_DEADZONE;
obj_pj.rightKey = keyboard_check(key_right) || obj_flecha_der.apretada || _moveH > GAMEPAD_MOVE_DEADZONE;

var _aimH = gamepad_axis_value(GAMEPAD_PLAYER, gp_axisrh);
var _aimV = gamepad_axis_value(GAMEPAD_PLAYER, gp_axisrv);
var _aimMoved = abs(_aimH) > AIM_DEADZONE || abs(_aimV) > AIM_DEADZONE;
var _recenterAim = gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_aimClick);
var _rangedAttack = gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_disparoRango)
    || gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_disparoRangoRT);

var _minX = 0;
var _maxX = 0;
var _minY = 0;
var _maxY = 0;
if (_aimMoved || _recenterAim || _rangedAttack) {
    _minX = global.render_x + AIM_RETICLE_CLAMP_MARGIN;
    _maxX = global.render_x + get_render_width() - AIM_RETICLE_CLAMP_MARGIN;
    _minY = global.render_y + AIM_RETICLE_CLAMP_MARGIN;
    _maxY = global.render_y + get_render_height() - AIM_RETICLE_CLAMP_MARGIN;
}

if (_aimMoved) {
    if (!obj_pj.aimActive) {
        obj_pj.aimX = obj_pj.x;
        obj_pj.aimY = obj_pj.y;
        obj_pj.aimActive = true;
        obj_pj.aimCamX = global.render_x;
        obj_pj.aimCamY = global.render_y;
    }

    var _mag = sqrt(_aimH * _aimH + _aimV * _aimV);
    var _t = clamp((_mag - AIM_DEADZONE) / (1 - AIM_DEADZONE), 0, 1);
    var _frac = 0.5 * (_t / AIM_PRECISION_LIMIT);
    if (_t > AIM_PRECISION_LIMIT) {
        _frac = 0.5 + 0.5 * ((_t - AIM_PRECISION_LIMIT) / (1 - AIM_PRECISION_LIMIT));
    }
    var _speed = lerp(AIM_MIN_SPEED, AIM_MAX_SPEED, _frac);
    obj_pj.aimX += (_aimH / _mag) * _speed;
    obj_pj.aimY += (_aimV / _mag) * _speed;

    if (obj_opciones.opcionAimAssist && _t <= AIM_PRECISION_LIMIT) {
        var _lock = noone;
        var _lockDistSq = AIM_ASSIST_RADIUS * AIM_ASSIST_RADIUS;
        var _onlineAim = online_activo();
        var _aimObject = _onlineAim ? obj_online_actor : obj_npc_basic;
        with (_aimObject) {
            if (_onlineAim ? (!is_undefined(data) && data.kind != "drop"
                && !(variable_struct_exists(data, "muerto") && data.muerto)) : hostil) {
                var _candidateDX = x - obj_pj.aimX;
                var _candidateDY = y - HALF_TILE - obj_pj.aimY;
                var _distSq = _candidateDX * _candidateDX + _candidateDY * _candidateDY;
                if (_distSq < _lockDistSq) {
                    _lockDistSq = _distSq;
                    _lock = id;
                }
            }
        }

        if (_lock != noone) {
            var _lockDX = _lock.x - obj_pj.aimX;
            var _lockDY = _lock.y - HALF_TILE - obj_pj.aimY;
            var _lockDist = sqrt(_lockDistSq);
            if (_lockDist > 0) {
                var _pullScale = min(AIM_ASSIST_PULL, _lockDist) / _lockDist;
                obj_pj.aimX += _lockDX * _pullScale;
                obj_pj.aimY += _lockDY * _pullScale;
            }
        }
    }

    obj_pj.aimX = clamp(obj_pj.aimX, _minX, _maxX);
    obj_pj.aimY = clamp(obj_pj.aimY, _minY, _maxY);

    var _aimDX = obj_pj.aimX - obj_pj.x;
    var _aimDY = obj_pj.aimY - obj_pj.y;
    var _aimDistSq = _aimDX * _aimDX + _aimDY * _aimDY;
    var _aimMaxDistSq = AIM_RETICLE_MAX_DIST * AIM_RETICLE_MAX_DIST;
    if (_aimDistSq > _aimMaxDistSq) {
        var _aimScale = AIM_RETICLE_MAX_DIST / sqrt(_aimDistSq);
        obj_pj.aimX = obj_pj.x + _aimDX * _aimScale;
        obj_pj.aimY = obj_pj.y + _aimDY * _aimScale;
    }

    var _aAng = point_direction(obj_pj.x, obj_pj.y, obj_pj.aimX, obj_pj.aimY);
    if (_aAng >= 315 || _aAng < 45) {
        obj_pj.aimDir = 3;
    } else if (_aAng >= 45 && _aAng < 135) {
        obj_pj.aimDir = 1;
    } else if (_aAng >= 135 && _aAng < 225) {
        obj_pj.aimDir = 2;
    } else {
        obj_pj.aimDir = 0;
    }
}

var _inventario_visible = obj_tecla_hechizos.visible;

if (gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_swap)) {
    if (_inventario_visible) mostrar_hechizos(); else mostrar_inventario();
    _inventario_visible = !_inventario_visible;
}

var _navHorizontal = gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_derecha)
    - gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_izquierda);
var _navUp = gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_arriba);
var _navDown = gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_abajo);

// Inventario
if (_inventario_visible) {
    var _posSeleccionado = obj_inventario.posSeleccionado + _navHorizontal;
    if (_navUp && _posSeleccionado >= INVENTORY_PAD_ROW_SIZE) _posSeleccionado -= INVENTORY_PAD_ROW_SIZE;
    if (_navDown && _posSeleccionado < INVENTORY_PAD_ROW_SIZE) _posSeleccionado += INVENTORY_PAD_ROW_SIZE;

    if (obj_inventario.posSeleccionado != _posSeleccionado) {
        if (_posSeleccionado < 0) _posSeleccionado = MAX_SLOTS - 1;
        if (_posSeleccionado >= MAX_SLOTS) _posSeleccionado = 0;
        obj_inventario.posSeleccionado = _posSeleccionado;
        obj_inventario.seleccionado = obj_inventario.slots[_posSeleccionado].indice;
        if (online_activo() && !obj_pj.muerto) {
            var _item = obj_inventario.slots[_posSeleccionado];
            if (_item.indice >= 0 && (_item.tipo == "arma" || _item.tipo == "ropa"
                || _item.tipo == "ropaFaccion" || _item.tipo == "escudo" || _item.tipo == "casco"
                || _item.tipo == "flecha" || _item.tipo == "laud" || _item.tipo == "trabajo"))
                online_accion({op: "equip", slot: _posSeleccionado});
            online_accion({op: "work_selection", slot: _posSeleccionado});
        }
    }
// Hechizos
} else {
    var _seleccionado = obj_hechizos.posSeleccionado + _navHorizontal;
    if (_navUp && _seleccionado >= SPELL_PAD_ROW_SIZE) _seleccionado -= SPELL_PAD_ROW_SIZE;
    if (_navDown && _seleccionado < MAX_SLOTS - SPELL_PAD_ROW_SIZE) _seleccionado += SPELL_PAD_ROW_SIZE;

    if (_seleccionado != obj_hechizos.posSeleccionado) {
        if (_seleccionado < 0) _seleccionado = MAX_SLOTS - 1;
        if (_seleccionado >= MAX_SLOTS) _seleccionado = 0;
        indicar_panel_hechizos(_seleccionado < SPELL_PANEL_SPLIT);
        obj_hechizos.posSeleccionado = _seleccionado;
        obj_hechizos.seleccionado = obj_hechizos.hechizos[_seleccionado].indice;
    }
}

if (keyboard_check_pressed(key_usar) || gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_usar) || mouse_check_button_pressed(mb_right)) {
    usarItem();
}

if (online_activo() && (obj_online.menu_open || instance_exists(obj_pausa))) exit;
if (online_activo() && keyboard_check_pressed(ord("L"))) lanzar();
if (obj_pj.muerto) exit;

// Acciones
if (keyboard_check_pressed(key_agarrar)) {
    tirarItem();
}

if (keyboard_check_pressed(key_atacar) || gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_atacar)) {
    pjAtacar();
}

if (keyboard_check_pressed(key_meditar) || gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_meditar)) {
    meditar();
}

if (keyboard_check_pressed(key_agarrar) || gamepad_button_check_pressed(GAMEPAD_PLAYER, joy_agarrar)) {
    agarrar();
}

// R3 recentra mira
if (_recenterAim) {
    obj_pj.aimX = clamp(obj_pj.x, _minX, _maxX);
    obj_pj.aimY = clamp(obj_pj.y - HALF_TILE, _minY, _maxY);
    obj_pj.aimActive = true;
    obj_pj.aimDir = obj_pj.direccion;
    obj_pj.aimCamX = global.render_x;
    obj_pj.aimCamY = global.render_y;
}

// Apuntado
if (_rangedAttack) {
    if (!obj_pj.aimActive) {
        obj_pj.aimX = obj_pj.x;
        obj_pj.aimY = obj_pj.y;
        switch (obj_pj.direccion) {
            case 0: obj_pj.aimY += AIM_START_DISTANCE; break;
            case 1: obj_pj.aimY -= AIM_START_DISTANCE; break;
            case 2: obj_pj.aimX -= AIM_START_DISTANCE; break;
            case 3: obj_pj.aimX += AIM_START_DISTANCE; break;
        }
        obj_pj.aimX = clamp(obj_pj.aimX, _minX, _maxX);
        obj_pj.aimY = clamp(obj_pj.aimY, _minY, _maxY);
        obj_pj.aimActive = true;
        obj_pj.aimDir = obj_pj.direccion;
        obj_pj.aimCamX = global.render_x;
        obj_pj.aimCamY = global.render_y;
    }

    if (_inventario_visible) {
        with (obj_pj) ataqueArco(aimX, aimY);
    } else {
        with (obj_pj) lanzarHechizo(aimX, aimY);
    }
}

//if (keyboard_check_pressed(keyLanzar)){
//	lanzar();
//}
