function online_prueba_cargar() {
    with (obj_online) {
        // El fixture prepara su personaje en SQLite. No usar INI offline.
        if (test_enter_sent || !characters_ready) exit;
        test_selection_flow = global.online_elegir;
        var _name = "Prueba" + test_role;
        for (var _i = 0; _i < array_length(characters); _i++) {
            if (characters[_i].nombre != _name) continue;
            test_save_roundtrip = true; // El servidor listó un personaje persistido.
            test_enter_sent = online_selector_entrar(_i);
            return;
        }
        status_text = "El fixture no tiene el personaje online " + _name;
    }
}

function online_prueba_movimiento() {
    var _ok = true;
    var _kinds = ["player", "bot", "npc"];
    var _targets = [[TILE_SIZE, 0], [-TILE_SIZE, 0], [0, TILE_SIZE], [0, -TILE_SIZE]];
    for (var _kind = 0; _kind < array_length(_kinds); _kind++) {
        for (var _target = 0; _target < array_length(_targets); _target++) {
            var _actor = instance_create_depth(0, 0, 0, obj_online_actor);
            _actor.data = {kind: _kinds[_kind], x: _targets[_target][0], y: _targets[_target][1],
                direccion: 0, muerto: false, navega: false, frames: [[0, 1, 2, 3]]};
            _actor.last_step_x = _actor.data.x;
            _actor.last_step_y = _actor.data.y;
            for (var _step = 0; _step < WALK_STEP_FRAMES; _step++) {
                with (_actor) event_perform(ev_step, ev_step_normal);
                if (_step == 0) {
                    _ok = _ok && abs(point_distance(0, 0, _actor.x, _actor.y)
                        - TILE_SIZE / WALK_STEP_FRAMES) <= ONLINE_TEST_POSITION_TOLERANCE;
                }
            }
            _ok = _ok && point_distance(_actor.x, _actor.y, _actor.data.x, _actor.data.y)
                <= ONLINE_TEST_POSITION_TOLERANCE && _actor.walk_frame >= 2;
            with (_actor) instance_destroy();
        }
    }
    return _ok;
}

function online_prueba_guardar(_ok) {
    var _movement = online_prueba_movimiento();
    var _report = {ok: _ok && _movement, movement_speed_ok: _movement, connected: obj_online.connected, playing: obj_online.playing,
        effects: obj_online.effect_events, sounds: obj_online.audio_events, actions: obj_online.action_events,
        status: obj_online.status_text, players_seen: obj_online.test_players_seen, damage: obj_online.damage_events,
        room: room_get_name(room), online: global.online_modo, save_roundtrip: obj_online.test_save_roundtrip, selection_flow: obj_online.test_selection_flow,
        interaction_checks: obj_online.test_interaction_checks,
        interval_room_fallback_ok: obj_online.test_interval_room_fallback_ok,
        online_no_offline_respawner: !global.online_modo || !instance_exists(obj_respawn_personas)};
    if (instance_exists(obj_pj)) {
        with (obj_pj) {
            _report.terrain_water = place_meeting(x, y, obj_bloqueo_agua);
            _report.terrain_blocked = place_meeting(x, y, obj_bloque_basic);
        }
        _report.x = obj_pj.x;
        _report.y = obj_pj.y;
        _report.health = obj_pj.salud;
        _report.mana = obj_pj.mana;
        _report.inventory = obj_inventario.slots;
        _report.npc_damage = obj_online.test_npc_damage;
        _report.dopa_seen = obj_online.test_dopa_seen;
        _report.dopa_strength = obj_pj.dopaFuerza;
        _report.dopa_agility = obj_pj.dopaAgilidad;
        _report.dopa_remaining = obj_pj.tiempoDopaMax - obj_pj.tiempoDopa;
    }
    var _f = file_text_open_write("online_test_" + obj_online.test_role + ".json");
    file_text_write_string(_f, json_stringify(_report));
    file_text_close(_f);
    obj_online.test_capture = true;
}

function online_prueba_interacciones() {
    var _npc = noone, _drop = noone;
    with (obj_online_actor) {
        if (!is_undefined(data)) {
            if (data.kind == "npc" && data.id == "n:smoke:lobo") _npc = id;
            if (data.kind == "drop" && data.indice == -1) _drop = id;
        }
    }
    if (!instance_exists(_npc) || !instance_exists(_drop)) return undefined;

    var _report = {};
    _report.npc_click = online_info_click(_npc.x, _npc.y - HALF_TILE) == _npc;
    _report.npc_large_edge = online_info_click(_npc.x + TILE_SIZE, _npc.y - HALF_TILE) == _npc;
    _report.drop_click = online_info_click(_drop.x, _drop.y - HALF_TILE) == _drop;
    _report.drop_below = online_info_click(_drop.x, _drop.y + HALF_TILE) == noone;
    var _seen_npc = false, _seen_drop = false;
    with (obj_INFO) {
        if (padre == _npc && string_pos(_npc.data.nombre, texto) > 0) _seen_npc = true;
        if (padre == _drop && string_pos("Monedas de oro", texto) == 1) _seen_drop = true;
    }
    _report.npc_text = _seen_npc;
    _report.drop_text = _seen_drop;

    var _sequence = obj_online.sequence;
    obj_online.last_tame_target = _npc.data.id;
    obj_online.last_tame_click = current_time;
    online_interactuar(_drop.x, _drop.y - HALF_TILE);
    _report.drop_does_not_tame = obj_online.sequence == _sequence
        && obj_online.last_tame_target == "" && obj_online.last_tame_click == 0;

    var _bow_slot = -1, _arrow_slot = -1;
    for (var _i = 0; _i < MAX_SLOTS; _i++) {
        var _item = obj_inventario.slots[_i];
        if (_item.tipo == "arma" && _item.indice >= 21 && _item.indice <= 27) _bow_slot = _i;
        if (_item.tipo == "flecha" && _item.equipado) _arrow_slot = _i;
    }
    if (_bow_slot < 0 || _arrow_slot < 0) return undefined;

    var _old_slot = obj_inventario.posSeleccionado;
    var _old_item = obj_inventario.seleccionado;
    var _old_weapon = obj_pj.armaActual;
    var _old_arrow = obj_pj.flechaEnInv;
    var _old_energy = obj_pj.energia;
    var _old_attack = obj_pj.puedeAtacar;
    var _old_dead = obj_pj.muerto;
    var _old_meditation = obj_pj.meditando;
    var _old_arc = obj_pj.atacaConArco;
    var _old_spell = obj_pj.atacaConHechizo;
    var _old_ready = obj_online.attack_ready_at;

    obj_inventario.posSeleccionado = _bow_slot;
    obj_inventario.seleccionado = obj_inventario.slots[_bow_slot].indice;
    obj_pj.armaActual = obj_inventario.seleccionado;
    obj_pj.flechaEnInv = _arrow_slot;
    obj_pj.energia = obj_pj.energiaMax;
    obj_pj.puedeAtacar = true;
    obj_pj.muerto = false;
    obj_pj.meditando = false;
    obj_pj.atacaConArco = false;
    obj_pj.atacaConHechizo = false;
    obj_online.attack_ready_at = current_time + ONLINE_TEST_FINISH_MS;
    online_usar();
    _report.bow_cooldown = !obj_pj.atacaConArco;
    obj_online.attack_ready_at = 0;
    online_usar();
    _report.bow_ready = obj_pj.atacaConArco;
    obj_pj.atacaConArco = false;
    obj_pj.flechaEnInv = -1;
    online_usar();
    _report.bow_no_arrows = !obj_pj.atacaConArco;
    obj_pj.flechaEnInv = _arrow_slot;
    obj_pj.energia = 0;
    online_usar();
    _report.bow_no_energy = !obj_pj.atacaConArco;
    obj_pj.energia = obj_pj.energiaMax;

    obj_pj.armaActual = 0;
    _sequence = obj_online.sequence;
    online_usar();
    _report.other_weapon_noop = obj_online.sequence == _sequence;
    obj_pj.armaActual = obj_inventario.seleccionado;
    obj_pj.muerto = true;
    _sequence = obj_online.sequence;
    online_usar();
    _report.dead_use_noop = obj_online.sequence == _sequence;
    obj_pj.muerto = false;
    obj_pj.meditando = true;
    _sequence = obj_online.sequence;
    online_atacar("bow", _npc.x, _npc.y);
    online_atacar("cast", _npc.x, _npc.y);
    _report.meditation_no_attack = obj_online.sequence == _sequence;

    obj_inventario.posSeleccionado = _old_slot;
    obj_inventario.seleccionado = _old_item;
    obj_pj.armaActual = _old_weapon;
    obj_pj.flechaEnInv = _old_arrow;
    obj_pj.energia = _old_energy;
    obj_pj.puedeAtacar = _old_attack;
    obj_pj.muerto = _old_dead;
    obj_pj.meditando = _old_meditation;
    obj_pj.atacaConArco = _old_arc;
    obj_pj.atacaConHechizo = _old_spell;
    obj_online.attack_ready_at = _old_ready;
    return _report;
}

function online_prueba_step() {
    with (obj_online) {
        if (test_role == "combat" && room == rm_menuPrincipal) {
            crearObjetosBasicos(-1);
            online_prueba_combate();
            game_end();
            exit;
        }
        if (string_pos("manual", test_role) == 1) {
            if (room == rm_menuPrincipal && test_stage == 0) {
                test_stage = 1;
                online_conectar(false);
            }
            if (authenticated && room == rm_seleccionarPJ && !instance_exists(obj_pj)) online_prueba_cargar();
            if (playing && instance_exists(obj_pj) && current_time - test_last_live >= ONLINE_LIVE_REPORT_MS) {
                test_last_live = current_time;
                var _live = {room: room_get_name(room), x: obj_pj.x, y: obj_pj.y, sx: state.x, sy: state.y,
                    health: obj_pj.salud, dead: obj_pj.muerto, boat: obj_pj.navega, paused: instance_exists(obj_pausa),
                    shop: obj_panel_items.mostrado, spells: effect_events, actions: action_events, sounds: audio_events,
                    sequence: sequence, ack: last_ack, epoch: state.position_epoch, local_bots: instance_number(obj_persona),
                    oro: obj_pj.oro, steps: obj_pj.pasos, inventory: obj_inventario.slots};
                var _file = file_text_open_write("online_live_" + test_role + ".json");
                file_text_write_string(_file, json_stringify(_live));
                file_text_close(_file);
            }
            exit;
        }
        if (test_role == "form" || test_role == "shop") {
            if (test_stage == 0 && room == rm_menuPrincipal) {
                test_started = current_time;
                test_stage = 1;
                if (test_role == "form") {
                    form_open = true;
                    form_values = ["wss://jugar.ejemplo.com", "443", "mi_cuenta", "ClaveEjemplo"];
                } else {
                    crearObjetosBasicos(-1);
                    room_goto(rm_79);
                }
            }
            if (test_role == "shop" && test_stage == 1 && room == rm_79) {
                var _merchant = instance_find(obj_npc_hechizos, 0);
                if (_merchant != noone) {
                    obj_pj.x = _merchant.x;
                    obj_pj.y = _merchant.y + TILE_SIZE;
                    if (_merchant.x >= global.render_x && _merchant.x <= global.render_x + get_render_width()
                        && _merchant.y >= global.render_y && _merchant.y <= global.render_y + get_render_height()) {
                        obj_panel_items.idPadre = _merchant;
                        obj_panel_items.mostrado = true;
                        global.online_modo = true;
                        test_stage = 2;
                    }
                }
            }
            if (test_stage > 0 && test_stage != 9 && current_time - test_started > ONLINE_TEST_FINISH_MS * 2) {
                online_prueba_guardar(test_role == "form" ? form_open : obj_panel_items.mostrado);
                test_stage = 9;
                test_started = current_time;
            }
        } else if (test_role == "offline") {
            if (test_stage == 0 && room == rm_menuPrincipal) {
                crearObjetosBasicos(-1);
                obj_pj.nombre = "PruebaOffline";
                obj_pj.saludMax = ONLINE_TEST_HEALTH;
                obj_pj.salud = ONLINE_TEST_HEALTH;
                obj_pj.skills[2] = 100;
                obj_pj.atributos[0] = 30;
                obj_pj.nivel = 30;
                room_goto(rm_78);
                test_stage = 1;
                test_started = current_time;
                exit;
            }
            if (test_stage == 1 && room == rm_78) {
                obj_pj.x = ONLINE_TEST_COMBAT_X;
                obj_pj.y = ONLINE_TEST_COMBAT_Y;
                with (obj_npc_basic) if (hostil) instance_destroy();
                test_npc = instance_create_depth(obj_pj.x + TILE_SIZE, obj_pj.y, 0, obj_npc_lobo);
                test_npc.saludMax = ONLINE_TEST_HEALTH;
                test_npc.salud = ONLINE_TEST_HEALTH;
                test_npc.inmovilizado = true;
                test_npc.alarm[4] = -1;
                test_npc.roomInicial = -1;
                test_stage = 2;
            }
            if (test_stage == 2 && current_time - last_move > ONLINE_TEST_OFFLINE_ATTACK_MS) {
                last_move = current_time;
                if (instance_exists(test_npc)) {
                    obj_pj.direccion = 3;
                    pjAtacar();
                    test_npc_damage = ONLINE_TEST_HEALTH - test_npc.salud;
                }
            }
            if (test_stage == 2 && current_time - test_started > ONLINE_TEST_MS div 2) {
                online_prueba_guardar(test_npc_damage > 0 && !global.online_modo);
                test_stage = 9;
                test_started = current_time;
            }
        } else {
            if (room == rm_menuPrincipal && test_stage == 0) {
                // Regresión real del crash al entrar a salas ausentes de la matriz 12x12.
                test_interval_room_fallback_ok = setearIntervaloCreacionIA(rm_arena) == 1
                    && abs(setearIntervaloCreacionIA(rm_94) - 0.85) < 0.001;
                test_stage = 1;
                online_conectar(false);
            }
            if (authenticated && room == rm_seleccionarPJ && !instance_exists(obj_pj)) online_prueba_cargar();
            if (playing && !is_undefined(state)) {
                if (test_role == "b" && !test_interaction_complete && room == rm_78) {
                    var _checks = online_prueba_interacciones();
                    if (!is_undefined(_checks)) {
                        test_interaction_checks = _checks;
                        test_interaction_complete = true;
                    }
                }
                var _seen = 0;
                with (obj_online_actor) if (!is_undefined(data) && data.kind == "player") _seen++;
                test_players_seen = max(test_players_seen, _seen);
                if (test_stage == 1) {
                    test_stage = 2;
                    test_started = current_time;
                    online_accion({op: "chat", text: "¡Prueba simultánea de GameMaker!"});
                    online_accion({op: "use", slot: 16});
                }
                if (!test_dopa_strength_sent && current_time - test_started > ONLINE_TEST_FINISH_MS) {
                    test_dopa_strength_sent = true;
                    online_accion({op: "use", slot: 17});
                }
                if (obj_pj.dopaFuerza == 1 && obj_pj.dopaAgilidad == 1
                    && obj_pj.tiempoDopa > 0 && obj_pj.tiempoDopa < obj_pj.tiempoDopaMax)
                    test_dopa_seen = true;
                if (current_time - last_move > ONLINE_TEST_ACTION_MS) {
                    last_move = current_time;
                    if (room == rm_79) online_accion({op: "move", direction: test_role == "a" ? 3 : 2});
                    else {
                        var _target = "", _npc = "";
                        with (obj_online_actor) {
                            if (is_undefined(data)) continue;
                            if (data.kind == "player") _target = data.id;
                            if (data.kind == "npc") _npc = data.id;
                        }
                        if (test_role == "a" && _target != "") {
                            if (test_action_count++ mod 3 == 0) { obj_pj.direccion = 3; pjAtacar(); }
                            else online_accion({op: "cast", target: _target, spell: 5});
                        }
                        if (test_role == "b" && _npc != "") online_accion({op: "attack", target: _npc, mode: "bow"});
                    }
                }
                if (current_time - test_started > ONLINE_TEST_MS && test_stage == 2) {
                    online_prueba_guardar(playing && test_players_seen > 0 && damage_events > 0 && room == rm_78
                        && test_save_roundtrip && test_selection_flow && test_dopa_seen
                        && test_interval_room_fallback_ok && !instance_exists(obj_respawn_personas));
                    test_stage = 9;
                    test_started = current_time;
                }
            }
            if (!playing && test_stage != 9 && current_time - test_started > ONLINE_TEST_MS * 3) {
                online_prueba_guardar(false);
                test_stage = 9;
                test_started = current_time;
            }
        }
        if (test_stage == 9 && current_time - test_started > ONLINE_TEST_FINISH_MS) {
            if (playing) online_enviar({op: "leave"});
            game_end();
        }
    }
}

function online_prueba_tirada(_lo, _hi, _record) {
    var _value = random_range(_lo, _hi);
    array_push(_record.rolls, [_lo, _hi, _value]);
    return _value;
}

function online_prueba_combate() {
    var _cases = [];
    var _weapons = json_parse("{\"0\":[2,3],\"1\":[2,4],\"2\":[5,6],\"3\":[4,7],\"4\":[5,7],\"5\":[6,7],\"6\":[6,8],\"7\":[4,4],\"8\":[6,7],\"9\":[6,8],\"10\":[9,10],\"11\":[8,10],\"12\":[10,11],\"13\":[11,13],\"14\":[10,12],\"15\":[13,15],\"16\":[14,16],\"17\":[16,18],\"21\":[5.5,7],\"22\":[7,9],\"23\":[9,11],\"24\":[13,15],\"25\":[16,16],\"26\":[15,19],\"27\":[16,19],\"-1\":[2,3]}");
    var _armor = json_parse("{\"33\":[5,15],\"34\":[5,15],\"35\":[5,15],\"36\":[5,15],\"37\":[15,20],\"38\":[15,20],\"39\":[5,5],\"40\":[5,15],\"41\":[25,30],\"42\":[25,30],\"43\":[20,25],\"44\":[20,25],\"45\":[2,2],\"46\":[2,2],\"47\":[2,2],\"48\":[2,2],\"49\":[2,2],\"50\":[2,2],\"51\":[3,3],\"52\":[5,5],\"53\":[2,2],\"54\":[5,5],\"55\":[5,10],\"56\":[5,10],\"57\":[5,8],\"58\":[10,15],\"59\":[10,15],\"60\":[5,10],\"61\":[15,25],\"62\":[10,15],\"63\":[10,15],\"64\":[10,15],\"65\":[10,15],\"66\":[15,20],\"67\":[15,20],\"68\":[15,27],\"69\":[15,27],\"70\":[15,27],\"71\":[2,2],\"72\":[10,15],\"73\":[10,15],\"74\":[10,15],\"75\":[12,17],\"76\":[12,17],\"77\":[12,17],\"78\":[15,20],\"79\":[10,25],\"80\":[10,25],\"81\":[10,27],\"82\":[12,25],\"83\":[10,20],\"84\":[10,20],\"85\":[8,12],\"86\":[17,28],\"87\":[17,28],\"88\":[17,28],\"89\":[20,30],\"90\":[20,30],\"91\":[23,33],\"92\":[25,35],\"164\":[12,17],\"165\":[12,17],\"166\":[20,25],\"167\":[20,25],\"168\":[25,30],\"169\":[25,30],\"170\":[12,17],\"171\":[12,17],\"172\":[20,25],\"173\":[20,25],\"174\":[25,30],\"175\":[25,30],\"176\":[12,24],\"177\":[12,24],\"178\":[22,25],\"179\":[22,25],\"180\":[25,35],\"181\":[25,35],\"182\":[12,24],\"183\":[12,24],\"184\":[22,25],\"185\":[22,25],\"186\":[25,35],\"187\":[25,35],\"188\":[12,17],\"189\":[12,17],\"190\":[20,25],\"191\":[20,25],\"192\":[25,30],\"193\":[25,30],\"194\":[12,17],\"195\":[12,17],\"196\":[20,25],\"197\":[20,25],\"198\":[25,30],\"199\":[25,30],\"200\":[12,17],\"201\":[12,17],\"202\":[15,26],\"203\":[15,26],\"204\":[20,30],\"205\":[20,30],\"206\":[12,17],\"207\":[12,17],\"208\":[15,26],\"209\":[15,26],\"210\":[20,30],\"211\":[20,30],\"212\":[10,15],\"213\":[10,15],\"214\":[12,17],\"215\":[10,20],\"216\":[12,25],\"222\":[40,45],\"223\":[40,45],\"224\":[40,45],\"225\":[40,45],\"226\":[40,45]}");
    var _arrows = [[4.5, 5], [5, 5.5], [5.5, 6], [6, 6]];
    var _melee = [0.80, 0.85, 0.90, 0.80, 0.95, 0.70, 1.05, 0.60, 0.95];
    var _bow = [1.05, 0.75, 0.80, 0.95, 0.80, 1, 0.85, 1, 0.80];
    var _levels = [1, 30, 47];
    var _clothes = [-1, 33, 37, 68, 222, 176];
    var _helmets = [-1, 93, 94, 95];
    var _shields = [-1, 98, 99, 100];
    var _stab = [6.75, 6.55, 6.5, 6.4, 6.25, 6.15, 6, 5.95, 5.8, 5.75];
    var _names = variable_struct_get_names(_weapons);
    for (var _class = 0; _class < array_length(_melee); _class++) {
        for (var _weapon = 0; _weapon < array_length(_names); _weapon++) {
            for (var _sample = 0; _sample < ONLINE_PARITY_SAMPLES; _sample++) {
                var _record = {kind: "physical", rolls: [], weapon: real(_names[_weapon]),
                    player_class: _class, level: _levels[_sample mod array_length(_levels)],
                    doses: _sample mod 5, person: _sample mod 2 == 1,
                    clothes: _clothes[_sample], helmet: _helmets[_sample mod array_length(_helmets)],
                    shield: _shields[_sample mod array_length(_shields)], arrow: 29 + _sample mod array_length(_arrows)};
                obj_pj.armaActual = _record.weapon;
                obj_pj.clase = _class;
                obj_pj.atributos[0] = 18;
                obj_pj.dopaFuerza = _record.doses;
                obj_pj.modDanoLvl = 0.75 + (_record.level - 1) * 0.0053;
                obj_pj.modDanoCuerpoACuerpo = _melee[_class];
                obj_pj.modDanoArco = _bow[_class];
                obj_pj.flechaActual = _record.arrow;
                eqRopa = _record.clothes;
                eqCascoGorro = _record.helmet;
                eqEscudo = _record.shield;
                var _seed = array_length(_cases);
                random_set_seed(_seed);
                var _base = online_prueba_tirada(obj_pj.danoMin, obj_pj.danoMax, _record);
                var _range = variable_struct_get(_weapons, _names[_weapon]);
                online_prueba_tirada(_range[0], _range[1], _record);
                if (_record.weapon >= 21) {
                    _range = _arrows[_record.arrow - 29];
                    online_prueba_tirada(_range[0], _range[1], _record);
                }
                if (_record.person) {
                    if (eqRopa == 33) online_prueba_tirada(5, 15, _record);
                    if (eqRopa == 37) online_prueba_tirada(15, 20, _record);
                    if (eqRopa == 68) online_prueba_tirada(15, 27, _record);
                    if (eqCascoGorro == 93) online_prueba_tirada(3, 8, _record);
                    if (eqEscudo == 98) online_prueba_tirada(1, 1, _record);
                    if (eqEscudo == 99) online_prueba_tirada(1, 4, _record);
                }
                random_set_seed(_seed);
                _base = random_range(obj_pj.danoMin, obj_pj.danoMax);
                var _damage = max(1, floor(calcularDanoFisicoPJ(_base, _record.person) * obj_pj.modDanoLvl));
                _record.critical = false;
                if (_record.weapon >= 0 && _record.weapon <= 7) {
                    if (_class == 1 || _class == 2) _damage = round(_damage * 1.25);
                    var _chance = _stab[3] - (_class == 1 ? 1.5 : (_class == 2 ? 0.5 : 0));
                    var _roll = random(7.5);
                    array_push(_record.rolls, [0, 7.5, _roll]);
                    _record.critical = _roll > _chance;
                    if (_record.critical) _damage = round(_damage * 3.4);
                }
                _record.damage = _damage;
                array_push(_cases, _record);
            }
        }
    }
    _names = variable_struct_get_names(_armor);
    for (var _cloth = 0; _cloth < array_length(_names); _cloth++) {
        for (var _sample = 0; _sample < ONLINE_PARITY_SAMPLES; _sample++) {
            var _record = {kind: "npc_physical", rolls: [], clothes: real(_names[_cloth]),
                helmet: _helmets[_sample mod array_length(_helmets)], shield: _shields[_sample mod array_length(_shields)],
                base: 100 + _sample};
            obj_pj.ropaActual = _record.clothes;
            obj_pj.cascoActual = _record.helmet;
            obj_pj.escudoActual = _record.shield;
            _seed = array_length(_cases);
            random_set_seed(_seed);
            var _range = variable_struct_get(_armor, _names[_cloth]);
            online_prueba_tirada(_range[0], _range[1], _record);
            if (_record.helmet >= 93 && _record.helmet <= 95) {
                _range = [[3, 8], [10, 13], [15, 20]][_record.helmet - 93];
                online_prueba_tirada(_range[0], _range[1], _record);
            }
            if (_record.shield >= 98) {
                _range = [[1, 1], [2, 4], [4, 6]][_record.shield - 98];
                online_prueba_tirada(_range[0], _range[1], _record);
            }
            random_set_seed(_seed);
            _record.damage = calcularDanoFisicoNPC(_record.base);
            array_push(_cases, _record);
        }
    }
    var _staffs = [-1, 18, 19, 20, 227];
    var _spells = [[1, 5], [12, 35], [4, 6], [6, 12], [12, 20], [25, 35], [40, 60], [63, 85], [87, 98]];
    for (var _spell = 0; _spell < array_length(_spells); _spell++) {
        for (var _staff = 0; _staff < array_length(_staffs); _staff++) {
            for (var _sample = 0; _sample < ONLINE_PARITY_SAMPLES; _sample++) {
                var _record = {kind: "magic", rolls: [], staff: _staffs[_staff], laud: _sample mod 2 == 0,
                    helmet: _sample mod 3 == 0 ? 96 : -1, healing: _spell < 2,
                    lo: _spells[_spell][0], hi: _spells[_spell][1]};
                obj_pj.armaActual = _record.staff;
                obj_pj.laudEquipado = _record.laud;
                eqCascoGorro = _record.helmet;
                var _base = online_prueba_tirada(_record.lo, _record.hi, _record);
                _record.damage = calcularDanoMagicoPJ(_base, !_record.healing, id);
                array_push(_cases, _record);
            }
        }
    }
    for (var _skill = 0; _skill <= 100; _skill++) {
        for (var _hat = -1; _hat <= 1; _hat++) {
            obj_pj.skills[17] = _skill;
            obj_pj.cascoActual = _hat == -1 ? -1 : 96 + _hat;
            array_push(_cases, {kind: "npc_magic", base: 101, skill: _skill,
                helmet: obj_pj.cascoActual, damage: calcularDanoMagicoNPC(101), rolls: []});
        }
    }
    var _rounds = [];
    for (var _i = 0; _i < ONLINE_PARITY_SAMPLES; _i++) array_push(_rounds, round(_i + 0.5));
    var _file = file_text_open_write("online_combat_parity.json");
    file_text_write_string(_file, json_stringify({cases: _cases, rounds: _rounds}));
    file_text_close(_file);
    show_debug_message("COMBAT_PARITY_DONE " + string(array_length(_cases)));
}
