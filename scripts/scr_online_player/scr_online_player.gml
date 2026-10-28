function online_jugador_step() {
    if (!obj_online.playing || obj_online.server_paused || is_undefined(obj_online.state)) {
        puedeMoverse = obj_online.playing && obj_online.server_paused;
        exit;
    }
    var _state = obj_online.state;
    if (meditando && !muerto && !instance_exists(obj_meditacion))
        instance_create_depth(x, y, 0, obj_meditacion);
    if (atacaConHechizo) atacaConArco = false;
    if (atacaConArco) atacaConHechizo = false;
    online_caminar();
    if (!obj_panel_items.mostrado && !obj_panel_trabajos.mostrado && !instance_exists(obj_pausa)) {
        for (var _device = 0; _device < MAX_MULTITOUCH; _device++) {
            if (device_mouse_check_button_pressed(_device, mb_left)) {
                var _mx = device_mouse_x(_device), _my = device_mouse_y(_device);
                if (position_meeting(_mx, _my, obj_area_flechas)) continue;
                if (!atacaConArco && !atacaConHechizo
                    && _mx >= global.render_x && _mx <= global.render_x + 56
                    && _my >= global.render_y && _my <= global.render_y + TILE_SIZE) {
                    obj_gui.panelActivo = !obj_gui.panelActivo;
                } else if (_mx >= global.render_x && _mx < global.render_x + get_render_width()
                    && _my > global.render_y + TILE_SIZE && _my < global.render_y + get_render_height()) {
                    if (atacaConHechizo && puedeAtacar) online_atacar("cast", _mx, _my);
                    else if (atacaConArco && !meditando) online_atacar("bow", _mx, _my);
                    else online_interactuar(_mx, _my);
                }
            }
        }
    }
}

function online_objetivo(_x, _y, _melee, _precise = false) {
    var _result = "", _best = _melee ? TILE_SIZE : TILE_SIZE * 2;
    with (obj_online_actor) {
        if (!is_undefined(data) && data.kind != "drop"
            && !(variable_struct_exists(data, "muerto") && data.muerto)
            && (!_precise || (abs(x - _x) < HALF_TILE && abs(y - HALF_TILE - _y) < HALF_TILE))
            && point_distance(x, y - HALF_TILE, _x, _y) < _best) {
            _best = point_distance(x, y - HALF_TILE, _x, _y);
            _result = data.id;
        }
    }
    return _result;
}

function online_atacar(_mode, _x, _y) {
    if (obj_pj.meditando && _mode == "bow") return;
    var _target = online_objetivo(_x, _y, _mode == "melee", _mode == "cast" || _mode == "bow");
    if (_mode == "cast") {
        var _spell = obj_hechizos.seleccionado;
        if (_spell < 0 || !obj_pj.puedeAtacar || current_time < obj_online.attack_ready_at) return;
        if (_target == "" && (_spell < 5 || _spell >= 14)) _target = obj_online.state.id;
        if (online_accion({op: "cast", target: _target, spell: _spell, x: _x, y: _y})) {
            obj_pj.atacaConHechizo = false;
            obj_online.attack_ready_at = current_time + obj_pj.intervaloHechizo * ONLINE_MS_PER_SECOND / SECOND;
        }
    } else if (_mode == "bow" || _target != "") {
        if (online_accion({op: "attack", target: _target, mode: _mode}) && _mode == "bow")
            obj_pj.atacaConArco = false;
    }
}

function online_melee() {
    var _x = obj_pj.x, _y = obj_pj.y - HALF_TILE;
    switch (obj_pj.direccion) {
        case 0: _y += TILE_SIZE; break;
        case 1: _y -= TILE_SIZE; break;
        case 2: _x -= TILE_SIZE; break;
        case 3: _x += TILE_SIZE; break;
    }
    online_atacar("melee", _x, _y);
}

function online_usar() {
    var _slot = obj_inventario.posSeleccionado;
    if (_slot < 0 || _slot >= MAX_SLOTS) return;
    var _selected = obj_inventario.slots[_slot];
    if (_selected.indice < 0) return;
    if (obj_pj.muerto && _selected.tipo != "runa" && _selected.tipo != "barca") return;
    if (_selected.tipo == "arma") {
        if (obj_pj.armaActual >= 21 && obj_pj.armaActual <= 27
            && obj_pj.puedeAtacar && current_time >= obj_online.attack_ready_at
            && obj_pj.energia >= 20 && obj_pj.flechaEnInv != -1) {
            obj_pj.atacaConHechizo = false;
            obj_pj.atacaConArco = true;
        }
        return;
    }
    var _tool = obj_inventario.slots[_slot].indice;
    if (_tool == 157 || _tool == 158 || _tool == 159) {
        obj_panel_trabajos.modo = (_tool == 157) ? 0 : ((_tool == 158) ? 1 : 2);
        obj_panel_trabajos.alarm[0] = 1;
        return;
    }
    if (_selected.tipo == "trabajo") return;
    online_accion({op: "use", slot: _slot});
}

function online_agarrar() {
    var _target = "";
    with (obj_online_actor) {
        if (!is_undefined(data) && data.kind == "drop"
            && floor(data.x / TILE_SIZE) == floor(obj_pj.x / TILE_SIZE)
            && floor(data.y / TILE_SIZE) == floor(obj_pj.y / TILE_SIZE)) _target = data.id;
    }
    if (_target != "") online_accion({op: "pickup", target: _target});
}

function online_inventario_tirar(_slot) {
    var _item = obj_inventario.slots[_slot];
    if (_item.indice < 0) return;
    if (_item.cant > 1) {
        if (!instance_exists(obj_numpad))
            instance_create_depth(global.render_x + get_render_width() * 0.5,
                global.render_y + get_render_height() * 0.5, 0, obj_numpad);
    } else {
        online_accion({op: "drop", slot: _slot, count: 1});
    }
}

function online_inventario_step() {
    if (obj_panel_items.mostrado || instance_exists(obj_pausa) || instance_exists(obj_numpad)) return;
    for (var _device = 0; _device < MAX_MULTITOUCH; _device++) {
        if (!device_mouse_check_button_pressed(_device, mb_left)) continue;
        var _mx = device_mouse_x(_device) - global.inventario_x - INVENTARIO_WIDTH;
        var _my = device_mouse_y(_device) - global.inventario_y - 7;
        if (_mx < 0 || _mx >= INVENTORY_PAD_ROW_SIZE * TILE_SIZE || _my < 0 || _my >= TILE_SIZE * 2) continue;
        var _slot = floor(_mx / TILE_SIZE) + floor(_my / TILE_SIZE) * INVENTORY_PAD_ROW_SIZE;
        var _has_item = slots[_slot].indice >= 0;
        var _double = posSeleccionado == _slot && obj_online.last_inventory_click > 0
            && current_time - obj_online.last_inventory_click < ONLINE_DOUBLE_CLICK_MS;
        obj_control_devices.devicesL[_device] = true;

        if (obj_pj.muerto) {
            obj_hechizos.moviendoHechizo = false;
            obj_mover_inventario.moviendoItem = false;
            if (!obj_tecla_T.teclaApretada) {
                var _type = _has_item ? slots[_slot].tipo : "";
                posSeleccionado = (_type == "runa" || _type == "barca") ? _slot : -1;
                seleccionado = posSeleccionado >= 0 ? slots[_slot].indice : -1;
                if (posSeleccionado >= 0) obj_skills_libres.mostrado = false;
            }
            obj_online.last_inventory_click = 0;
            continue;
        }

        if (obj_tecla_T.teclaApretada) {
            if (_has_item) online_inventario_tirar(_slot);
            obj_online.last_inventory_click = 0;
        } else if (obj_mover_inventario.moviendoItem && posSeleccionado >= 0) {
            online_accion({op: "swap", slot: posSeleccionado, to: _slot});
            obj_mover_inventario.moviendoItem = false;
            obj_online.last_inventory_click = 0;
        } else if (_double) {
            if (_has_item) online_inventario_tirar(_slot);
            obj_online.last_inventory_click = 0;
        } else {
            if (_has_item) {
                var _tipo = slots[_slot].tipo;
                if (_tipo == "arma" || _tipo == "ropa" || _tipo == "ropaFaccion"
                    || _tipo == "escudo" || _tipo == "casco" || _tipo == "flecha"
                    || _tipo == "laud" || _tipo == "trabajo") {
                    online_accion({op: "equip", slot: _slot});
                }
            }
            obj_online.last_inventory_click = current_time;
        }
        posSeleccionado = _slot;
        seleccionado = slots[_slot].indice;
        online_accion({op: "work_selection", slot: _slot});
    }
}

function online_info_click(_mx, _my) {
    var _actor = noone;
    var _nearest = 0;
    with (obj_online_actor) {
        if (!is_undefined(data) && (data.kind == "npc" || data.kind == "drop")) {
            var _sprite = data.kind == "npc" ? sprite_index : (data.indice >= 0 ? spr_items : spr_oro);
            if (sprite_exists(_sprite)) {
                var _left = x + sprite_get_bbox_left(_sprite) - sprite_get_xoffset(_sprite);
                var _right = x + sprite_get_bbox_right(_sprite) - sprite_get_xoffset(_sprite);
                var _top = y + sprite_get_bbox_top(_sprite) - sprite_get_yoffset(_sprite);
                var _bottom = y + sprite_get_bbox_bottom(_sprite) - sprite_get_yoffset(_sprite);
                if (_mx >= _left && _mx <= _right && _my >= _top && _my <= _bottom) {
                    var _distance = point_distance((_left + _right) * 0.5, (_top + _bottom) * 0.5, _mx, _my);
                    if (_actor == noone || _distance < _nearest) {
                        _nearest = _distance;
                        _actor = id;
                    }
                }
            }
        }
    }
    if (!instance_exists(_actor)) return noone;
    var _entity = _actor.data;
    var _info = instance_create_depth(_actor.x, _actor.y, DEPTH_FLOAT_TEXT, obj_INFO);
    _info.padre = _actor;
    if (_entity.kind == "npc") {
        var _prefix = "";
        if (_entity.owner != "") {
            _prefix = (variable_struct_exists(_entity, "tamed") && _entity.tamed)
                ? "(Mascota) " : "(Invocado) ";
        }
        _info.texto = _prefix + _entity.nombre + " - " + string(_entity.salud) + "/" + string(_entity.saludMax);
        _info.limite = 3;
        _info.color = c_orange;
    } else {
        _info.texto = _entity.indice >= 0
            ? nombreItem(_entity.indice) + " (" + string(_entity.cant) + ")"
            : "Monedas de oro (" + string(_entity.cant) + ")";
    }
    return _actor;
}

function online_interactuar(_mx, _my) {
    if (obj_inventario.seleccionado >= 148 && obj_inventario.seleccionado <= 150 && instance_position(_mx, _my, obj_fragua) != noone) {
        online_accion({op: "smelt", slot: obj_inventario.posSeleccionado, x: _mx, y: _my});
        return;
    }
    if (obj_pj.trabajoEquipado && obj_pj.trabajoActual >= 147 && obj_pj.trabajoActual <= 156) {
        if (obj_pj.trabajoActual == 147) {
            // Las copas ocupan varias celdas: el servidor espera la posicion del arbol.
            var _arbol = noone, _cercania = TILE_SIZE * 3;
            with (obj_arbol_basic) {
                if (position_meeting(_mx, _my, id)) {
                    var _distancia = point_distance(x, y, obj_pj.x, obj_pj.y);
                    if (_distancia < _cercania) {
                        _cercania = _distancia;
                        _arbol = id;
                    }
                }
            }
            if (_arbol != noone) online_accion({op: "work", x: _arbol.x, y: _arbol.y});
        } else online_accion({op: "work", x: _mx, y: _my});
        return;
    }
    var _clicked = online_info_click(_mx, _my);
    if (!instance_exists(_clicked) || _clicked.data.kind != "npc") {
        obj_online.last_tame_target = "";
        obj_online.last_tame_click = 0;
        return;
    }
    var _target = _clicked.data.id;
    if (string_copy(_target, 1, 2) == "n:") {
        if (obj_online.last_tame_target == _target && obj_online.last_tame_click > 0
            && current_time - obj_online.last_tame_click <= ONLINE_TAME_DOUBLE_CLICK_MS) {
            online_accion({op: "tame", target: _target});
            obj_online.last_tame_click = 0;
        } else {
            obj_online.last_tame_target = _target;
            obj_online.last_tame_click = current_time;
        }
    }

}

function online_npc_index(_id) {
    if (!instance_exists(_id) || is_undefined(obj_online.catalog)) return -1;
    var _maps = obj_online.catalog.maps;
    for (var _i = 0; _i < array_length(_maps); _i++) {
        if (_maps[_i].name != room_get_name(room)) continue;
        var _npcs = _maps[_i].npcs;
        for (var _j = 0; _j < array_length(_npcs); _j++) {
            if (_npcs[_j].asset == object_get_name(_id.object_index) && _npcs[_j].x == _id.x && _npcs[_j].y == _id.y) return _npcs[_j].index;
        }
    }
    return -1;
}

function online_volver_menu(_notificar = true) {
    if (_notificar) online_enviar({op: "leave"});
    obj_online.playing = false;
    obj_online.state = undefined;
    obj_online.attack_ready_at = 0;
    obj_online.pending_teleports = [];
    obj_online.spell_count = -1;
    obj_online.pending_spell_sequence = 0;
    obj_online.menu_open = false;
    obj_online.menu_editing_count = false;
    global.online_pendiente = false;
    global.online_elegir = false;
    instance_activate_all();
    with (all) {
        if (object_index != obj_online && object_index != obj_opciones && object_index != obj_control_vista
            && object_index != obj_control_opciones && object_index != obj_control_devices
            && object_index != obj_control_musica && object_index != obj_control_notificacion_torneos
            && object_index != obj_sonido_mar && object_index != obj_opcion_sonido && object_index != obj_opcion_musica) instance_destroy();
    }
    global.online_modo = false;
    room_goto(rm_menuPrincipal);
}

function online_paso_ocupado(_x, _y) {
    var _portal = instance_place(_x, _y, obj_tp);
    if (_portal != noone && obj_pj.nivel < _portal.nivelRequerido) {
        var _nombre = "este dungeon";
        switch (_portal.roomTP) {
            case rm_88: _nombre = "Dungeon Zaá Cik'"; break;
            case rm_90: _nombre = "Dungeon Wurl"; break;
            case rm_91: _nombre = "Dungeon Zerök"; break;
        }
        obj_online.status_text = "Necesitás nivel " + string(_portal.nivelRequerido)
            + " para entrar a " + _nombre + " (tenés " + string(obj_pj.nivel) + ")";
        obj_online.status_expire_at = current_time + ONLINE_STATUS_DURATION_MS;
        return true;
    }
    if (!place_meeting(_x, _y, obj_npc_basic) && !online_ocupado(_x, _y)) return false;
    return _portal == noone;
}

function online_ocupado(_x, _y) {
    if (obj_pj.muerto) return false;
    var _blocked = false;
    with (obj_online_actor) if (!is_undefined(data) && data.kind != "drop"
        && !(variable_struct_exists(data, "muerto") && data.muerto)
        && point_distance(data.x, data.y, _x, _y) < HALF_TILE) _blocked = true;
    return _blocked;
}

function online_caminar() {
var bloqueo = false;

if (obj_opciones.opcionArboles) {
    var _currArbol = instance_place(x, y, obj_arbol_basic);
    if (_currArbol != ultimoArbol) {
        if (ultimoArbol != noone && instance_exists(ultimoArbol)) ultimoArbol.image_alpha = 1;
        if (_currArbol != noone) _currArbol.image_alpha = 0.5;
        ultimoArbol = _currArbol;
    }
} else {
    if (ultimoArbol != noone) {
        if (instance_exists(ultimoArbol)) ultimoArbol.image_alpha = 1;
        ultimoArbol = noone;
    }
}



var _mouseDown = device_mouse_check_button(0, mb_left) || device_mouse_check_button(1, mb_left) || device_mouse_check_button(2, mb_left) || device_mouse_check_button(3, mb_left) || device_mouse_check_button(4, mb_left);
var _device = _mouseDown ? elegirDeviceLibre() : -1;
if (puedeMoverse && !online_interfaz_abierta()) {
    var _direccionAnterior = direccion;
    if (rightKey) {
        direccion = 3;
    } else if (leftKey) {
        direccion = 2;
    } else if (upKey) {
        direccion = 1;
    } else if (downKey) {
        direccion = 0;
    }
    if (direccion != _direccionAnterior) online_accion({op: "turn", direction: direccion});
}

if (pasos == 0 && puedeMoverse && !inmovilizado && !meditando && !online_interfaz_abierta()) {

    var sndPaso = -1;

    if (rightKey) {

        // Derecha

        if (!navega) {
            bloqueo = place_meeting(x + TILE_SIZE, y, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x + TILE_SIZE, y, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }

        if (
        !place_meeting(x + TILE_SIZE, y, obj_bloque_basic) &&
        !online_paso_ocupado(x + TILE_SIZE, y) &&
        !bloqueo
        ) {
            xInicio = x; yInicio = y; xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            x += spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 3;
            online_accion({op: "move", direction: 3, x: xInicio + (TILE_SIZE), y: yInicio + (0), room: room_get_name(room), epoch: obj_online.state.position_epoch});
        }

    } else if (leftKey) {

        // Izquierda

        if (!navega) {
            bloqueo = place_meeting(x - TILE_SIZE, y, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x - TILE_SIZE, y, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }

        if (
        !place_meeting(x - TILE_SIZE, y, obj_bloque_basic) &&
        !online_paso_ocupado(x - TILE_SIZE, y) &&
        !bloqueo
        ) {
            xInicio = x; yInicio = y; xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            x -= spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 2;
            online_accion({op: "move", direction: 2, x: xInicio + (-TILE_SIZE), y: yInicio + (0), room: room_get_name(room), epoch: obj_online.state.position_epoch});
        }

    } else if (upKey) {

        // Arriba

        if (!navega) {
            bloqueo = place_meeting(x, y - TILE_SIZE, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x, y - TILE_SIZE, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }

        if (
        !place_meeting(x, y - TILE_SIZE, obj_bloque_basic) &&
        !online_paso_ocupado(x, y - TILE_SIZE) &&
        !bloqueo
        ) {
            yInicio = y; xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            y -= spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 1;
            online_accion({op: "move", direction: 1, x: xInicio + (0), y: yInicio + (-TILE_SIZE), room: room_get_name(room), epoch: obj_online.state.position_epoch});
        }

    } else if (downKey) {

        // Abajo

        if (!navega) {
            bloqueo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_agua);
            sndPaso = snd_paso;
        } else {
            bloqueo = place_meeting(x, y + TILE_SIZE, obj_bloqueo_tierra);
            sndPaso = snd_barca;
        }

        if (
        !place_meeting(x, y + TILE_SIZE, obj_bloque_basic) &&
        !online_paso_ocupado(x, y + TILE_SIZE) &&
        !bloqueo
        ) {
            yInicio = y; xInicio = x;
            // frame = 0;
            alarm[0] = 1;
            y += spd;
            if (!muerto) {
                reproducirSonido(sndPaso, false, false);
            }
            pasos = 1;
            ultimaTecla = 0;
            online_accion({op: "move", direction: 0, x: xInicio + (0), y: yInicio + (TILE_SIZE), room: room_get_name(room), epoch: obj_online.state.position_epoch});
        }

    }

}

switch (ultimaTecla) {
    case 0:
        if (pasos > 0) {
            if (pasos < pasosMax) {
                y += spd;
                pasos++;
                puedeMoverse = false;
            } else {
                y += spdUltimoPaso;
                y = floor(y);
                pasos = 0;
                puedeMoverse = true;
            }
        }
        break;
    case 1:
        if (pasos > 0) {
            if (pasos < pasosMax) {
                y -= spd;
                pasos++;
                puedeMoverse = false;
            } else {
                y -= spdUltimoPaso;
                y = floor(y);
                y++;
                pasos = 0;
                puedeMoverse = true;
            }
        }
        break;
    case 2:
        if (pasos > 0) {
            if (pasos < pasosMax) {
                x -= spd;
                pasos++;
                puedeMoverse = false;
            } else {
                x -= spdUltimoPaso;
                x = floor(x);
                x++;
                pasos = 0;
                puedeMoverse = true;
            }
        }
        break;
    case 3:
        if (pasos > 0) {
            if (pasos < pasosMax) {
                x += spd;
                pasos++;
                puedeMoverse = false;
            } else {
                x += spdUltimoPaso;
                x = floor(x);
                pasos = 0;
                puedeMoverse = true;
            }
        }
        break;
}


}

function online_comerciar(_op) {
    if (indiceItem < 0 || indiceItem >= MAX_SLOTS || !mostrado) return;
    if ((_op == "buy" || _op == "withdraw") ? !sectorNpc : !sectorPj) return;
    var _count = floor(real(campoCantidadS));
    var _npc = modoBanco ? idBanquero : idPadre;
    var _index = online_npc_index(_npc);
    if (_count <= 0 || _index < 0) return;
    var _slot = (_op == "buy" || _op == "withdraw") ? idPadre.slots[indiceItem] : obj_inventario.slots[indiceItem];
    if (_slot.indice < 0) return;
    if (_op != "buy") _count = min(_count, _slot.cant);
    var _message = {op: _op, npc: _index, slot: indiceItem, item: _slot.indice, count: _count};
    if (_op == "buy" || _op == "sell") {
        obj_online.commerce_next_id++;
        _message.request_id = obj_online.commerce_nonce + ":" + string(obj_online.commerce_next_id);
    }
    if (_op == "buy" || _op == "sell") online_comercio_solicitar(_message);
    else online_accion(_message);
}

function online_interfaz_abierta() {
    return instance_exists(obj_pausa) || obj_panel_items.mostrado || obj_panel_trabajos.mostrado;
}
