function online_recibir(_message) {
    with (obj_online) {
        if (!is_struct(_message) || !variable_struct_exists(_message, "op")) return;
        last_receive = current_time;
        var _cleanup_notice = _message.op == "chat" && (variable_struct_exists(_message, "cleanup_seconds")
            || variable_struct_exists(_message, "cleanup_done"));
        if (_message.op == "error" || (_message.op == "chat" && !_cleanup_notice))
            status_expire_at = current_time + ONLINE_STATUS_DURATION_MS;
        switch (_message.op) {
            case "pong":
                show_debug_message("ONLINE_PONG_RECEIVED ms_since_ping=" + string(current_time - last_ping));
                break;
            case "hello":
                login_phase_started_at = current_time;
                show_debug_message("ONLINE_LOGIN_PHASE hello");
                if (_message.protocol != ONLINE_PROTOCOL) { online_desconectar("Versión de servidor incompatible"); return; }
                online_enviar({op: "login", protocol: ONLINE_PROTOCOL, account: form_values[2], password: form_values[3], register: register_account, actor_batches: variable_struct_exists(_message, "actor_batches") && _message.actor_batches});
                form_values[3] = "";
                break;
            case "authenticated":
                login_phase_started_at = current_time;
                show_debug_message("ONLINE_LOGIN_PHASE authenticated");
                authenticated = true;
                global.online_elegir = true;
                global.online_modo = false;
                characters = [];
                characters_ready = false;
                character_selected = -1;
                create_pending = false;
                enter_pending = false;
                test_enter_sent = false;
                form_open = false;
                status_text = "Cargando personajes de tu cuenta...";
                room_goto(rm_seleccionarPJ);

                break;
            case "characters":
                if (!authenticated || playing || !variable_struct_exists(_message, "slots")
                    || !is_array(_message.slots) || array_length(_message.slots) > 9) {
                    status_text = "Respuesta de personajes inválida";
                    break;
                }
                var _selected_name = "";
                if (character_selected >= 0 && character_selected < array_length(characters))
                    _selected_name = characters[character_selected].nombre;
                characters = [];
                character_selected = -1;
                for (var _i = 0; _i < array_length(_message.slots); _i++) {
                    var _slot = _message.slots[_i];
                    if (!is_struct(_slot) || !variable_struct_exists(_slot, "nombre")
                        || !is_string(_slot.nombre)) continue;
                    array_push(characters, _slot);
                    if (_selected_name == _slot.nombre) character_selected = array_length(characters) - 1;
                    if (character_create_name == _slot.nombre && create_pending)
                        character_selected = array_length(characters) - 1;
                }
                characters_ready = true;
                show_debug_message("ONLINE_LOGIN_PHASE characters_ready count=" + string(array_length(characters)));
                if (create_pending) {
                    create_pending = false;
                    if (online_creacion_activa()) online_creacion_volver();
                    keyboard_string = "";
                    if (os_type == os_android || os_type == os_ios) keyboard_virtual_hide();
                }
                if (instance_exists(obj_control_seleccionarPJ))
                    obj_control_seleccionarPJ.elegido = character_selected + 1;
                status_text = "Seleccioná un personaje o creá uno nuevo";
                break;
            case "entered":
                show_debug_message("ONLINE_LOGIN_PHASE entered");
                enter_started_at = 0;
                playing = true;
                enter_pending = false;
                global.online_modo = true;
                status_text = "Conectado";
                break;
            case "world_reset": online_world_reset(_message); break;
            case "self_state":
                online_self_state(_message);
                if (variable_struct_exists(_message, "full") && _message.full == true
                    && variable_struct_exists(_message, "self")
                    && is_struct(_message.self) && variable_struct_exists(_message.self, "id"))
                    online_comercio_reintentar(_message.self.id);
                break;
            case "actor_spawn": online_actor_spawn(_message); break;
            case "actor_patch": online_actor_patch(_message); break;
            case "actor_remove": online_actor_remove(_message); break;
            case "ack":
                online_actualizar_ack(_message);
                online_guardado_responder(_message);
                online_comercio_responder(_message);
                break;
            case "position":
                if (!online_evento_entidad_listo(_message)) break;
                if (!ds_map_exists(actors, _message.id)) {
                    online_solicitar_resync();
                    break;
                }
                var _actor = actors[? _message.id];
                if (!instance_exists(_actor) || is_undefined(_actor.data) || _actor.data.kind != "player") break;
                if (_message.position_epoch < _actor.data.position_epoch) break;
                var _teleported = _message.position_epoch != _actor.data.position_epoch;
                if (_teleported) {
                    _actor.x = _message.x;
                    _actor.y = _message.y;
                    _actor.last_step_x = _message.x;
                    _actor.last_step_y = _message.y;
                    _actor.walk_frame = 0;
                }
                _actor.data.x = _message.x;
                _actor.data.y = _message.y;
                _actor.data.direccion = _message.direccion;
                _actor.data.position_epoch = _message.position_epoch;
                _actor.received_at = current_time;
                break;
            case "error":
                status_text = _message.message;
                online_guardado_responder(_message);
                online_comercio_responder(_message);
                if (playing && pending_spell_sequence > 0) online_solicitar_resync();
                if (!playing && (enter_pending || create_pending || global.online_elegir)) {
                    enter_pending = false;
                    create_pending = false;
                    global.online_modo = false;
                } else if (!playing && global.online_modo) failed_entry = true;
                break;
            case "damage":
                if (!online_evento_visual_listo(_message)) break;
                var _target = noone;
                if (playing && !is_undefined(state) && state.id == _message.target) _target = obj_pj;
                else if (ds_map_exists(actors, _message.target)) _target = actors[? _message.target];
                var _has_hit_position = variable_struct_exists(_message, "x") && variable_struct_exists(_message, "y");
                var _follow = _has_hit_position ? online_impacto_padre(_target, _message.x, _message.y) : _target;
                var _target_exists = instance_exists(_target);
                if (instance_exists(_follow) || _has_hit_position) {
                    var _hit_x = _has_hit_position ? _message.x : _follow.x;
                    var _hit_y = _has_hit_position ? _message.y : _follow.y;
                    var _damage = crearTextoDano(_hit_x, _hit_y - HALF_TILE, _message.amount, _follow);
                    if (instance_exists(_follow) && _follow.object_index == obj_online_actor
                        && _follow.data.kind == "npc") array_push(_follow.online_impact_effects, _damage);
                    if (variable_struct_exists(_message, "critical") && _message.critical) _damage.color = ONLINE_STAB_COLOR;
                    if (variable_struct_exists(_message, "cause") && _message.cause != "combat") {
                        _damage.color = _message.cause == "poison" ? c_lime : ONLINE_COLD_COLOR;
                        _damage.fuente = fnt_Vedrana_8_bold;
                        if (_target_exists && _target.object_index == obj_pj) vibrarPantalla();
                    } else {
                        // El sonido pertenece al daño, no a la animación del ataque.
                        // El texto existe incluso si la víctima murió y ya fue removida.
                        var _humano = string_pos("p:", _message.target) == 1 || string_pos("b:", _message.target) == 1;
                        with (_damage) reproducirSonido(_humano ? snd_golpeRecibido : snd_golpeANPC, false, false);
                    }
                }
                damage_events++;
                break;
            case "skill_gain":
                if (!is_undefined(state) && state.id == _message.target && instance_exists(obj_pj)) {
                    obj_skills_libres.mostrado = false;
                    var _skill_info = crearTextoSubirSkill(_message.skill);
                    if (variable_struct_exists(_message, "amount")) _skill_info.texto = textoSkill(_message.skill) + " +" + string(_message.amount);
                }
                break;
            case "speech":
                if (!online_evento_visual_listo(_message)) break;
                var _speaker = online_entidad(_message.target);
                if (instance_exists(_speaker)) {
                    var _info = instance_create_depth(_speaker.x, _speaker.y, DEPTH_FLOAT_TEXT, obj_INFO);
                    _info.padre = _speaker;
                    _info.texto = _message.text;
                    _info.tiempo = SECOND * ONLINE_SPEECH_SECONDS;
                }
                break;
            case "action":
                if (!online_evento_visual_listo(_message)) break;
                if (_message.kind == "teleport") array_push(pending_teleports, _message);
                else online_efecto(_message);
                break;
            case "level":
                if (!is_undefined(state) && state.id == _message.target && instance_exists(obj_pj)) {
                    instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_efecto_subir_lvl);
                    with (obj_pj) reproducirSonido(snd_subirNivel, false, false);
                    var _level_info = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
                    _level_info.padre = obj_pj.id;
                    _level_info.texto = "¡Nuevo nivel " + string(_message.level) + "!#+" + string(_message.hp_gain) + " Vida";
                    if (_message.mana_gain > 0) _level_info.texto += "  +" + string(_message.mana_gain) + " Maná";
                    _level_info.color = c_yellow;
                    _level_info.fuente = fnt_Vedrana_8_bold;
                    _level_info.tiempo = 300;
                    _level_info.limite = 20;
                    _level_info.desfaseY = 65;
                }
                break;
            case "chat":
                if (variable_struct_exists(_message, "paused")) server_paused = _message.paused;
                if (playing && variable_struct_exists(_message, "cleanup_seconds")
                    && is_numeric(_message.cleanup_seconds)
                    && _message.cleanup_seconds >= 1 && _message.cleanup_seconds <= ONLINE_CLEANUP_WARNING_SECONDS) {
                    cleanup_seconds = _message.cleanup_seconds;
                    cleanup_received_at = current_time;
                } else if (playing && variable_struct_exists(_message, "cleanup_done") && _message.cleanup_done == true) {
                    cleanup_seconds = 0;
                    cleanup_received_at = current_time;
                }
                if (!_cleanup_notice) status_text = _message.name + ": " + _message.text;
                break;
            case "left":
                if (playing && global.online_modo) {
                    online_comercio_marcar_reintentos();
                    online_volver_menu(false);
                    break;
                }
                online_comercio_marcar_reintentos();
                playing = false;
                server_paused = false;
                state = undefined;
                world_room = "";
                world_generation = -1;
                changing_room = false;
                room_reset_pending = false;
                pending_room_events = [];
                pending_teleports = [];
                pending_self_apply = false;
                pending_self_teleport = false;
                break;
        }
    }
}

function online_evento_visual_listo(_message) {
    if (!obj_online.playing || !variable_struct_exists(_message, "room")
        || _message.room != obj_online.world_room
        || !variable_struct_exists(_message, "generation")
        || _message.generation != obj_online.world_generation) return false;
    if (obj_online.changing_room || obj_online.room_reset_pending || is_undefined(obj_online.state)
        || _message.room != room_get_name(room)) {
        online_encolar_evento_sala(_message);
        return false;
    }
    return true;
}

function online_impacto_padre(_target, _x, _y) {
    if (!instance_exists(_target)) return noone;
    if (_target.object_index != obj_online_actor || is_undefined(_target.data)
        || _target.data.kind != "npc") return _target;
    if (_target.data.salud <= 0
        || point_distance(_target.data.x, _target.data.y, _x, _y) > TILE_SIZE
        || (variable_instance_exists(_target, "online_respawn_received_at")
            && current_time - _target.online_respawn_received_at <= ONLINE_NPC_RESPAWN_FX_WINDOW_MS))
        return noone;
    return _target;
}

function online_entidad(_id) {
    if (!is_undefined(obj_online.state) && obj_online.state.id == _id) return instance_find(obj_pj, 0);
    if (ds_map_exists(obj_online.actors, _id)) return obj_online.actors[? _id];
    var _local = noone;
    with (obj_npc_basic) {
        if (!hostil && _id == "n:" + room_get_name(room) + ":" + string(online_npc_index(id))) _local = id;
    }
    return _local;
}

function online_efecto(_message) {
    var _source = online_entidad(_message.source);
    var _target = online_entidad(_message.target);
    var _has_target_position = _message.kind == "cast"
        && variable_struct_exists(_message, "target_x")
        && variable_struct_exists(_message, "target_y");
    if (!instance_exists(_source) && !(_message.kind == "cast" && _has_target_position)) return;
    var _follow = _has_target_position
        ? online_impacto_padre(_target, _message.target_x, _message.target_y) : _target;
    var _sound = -1, _effect = -1;
    switch (_message.kind) {
        case "cast":
            var _effects = [obj_curar_veneno, obj_curar_heridas_leves, obj_curar_heridas_graves, -1, obj_invisibilidad,
                obj_dardo_magico, obj_flecha_magica, obj_flecha_electrica, obj_misil_magico, obj_tormenta_de_fuego,
                obj_descarga_electrica, obj_apocalipsis, obj_paralizar, obj_inmovilizar];
            var _sounds = [snd_dardoMagico, snd_curarHeridasLeves, snd_curarHeridasGraves, snd_dardoMagico, snd_dardoMagico,
                snd_dardoMagico, snd_dardoMagico, snd_dardoMagico, snd_misilMagico, snd_tormentaDeFuego,
                snd_descargaElectrica, snd_apocalipsis, snd_dardoMagico, snd_inmovilizar];
            if (_message.spell < array_length(_effects)) {
                _effect = _effects[_message.spell];
                _sound = _sounds[_message.spell];
            } else _sound = snd_logueo;
            if (instance_exists(_source) && variable_struct_exists(_message, "words") && _message.words != "") with (_source) {
                palabrasMagicas = _message.words;
                dicePalabrasMagicas = true;
                if (object_index == obj_pj) alarm[6] = SECOND * ONLINE_WORDS_SECONDS;
                else words_until = current_time + ONLINE_WORDS_SECONDS * 1000;
            }
            break;
        case "melee":
            // El evento damage reproduce una sola vez el sonido de la víctima.
            with (_source) {
                if (object_index == obj_pj) { frameArma = 0; alarm[8] = 1; }
                else { weapon_frame = 0; attack_until = current_time + ONLINE_ATTACK_ANIMATION_MS; }
            }
            break;
        case "bow":
            if (!variable_struct_exists(_message, "hit") || _message.hit) _sound = snd_flechaAcertada;
            break;
        case "work":
            _sound = _message.profession == "tala" ? snd_talar : (_message.profession == "pesca" ? snd_pescar : snd_minar);
            break;
        case "speech": break;
        case "death": _sound = snd_muerte; break;
        case "miss":
            _sound = snd_fallo;
            var _info = instance_create_depth(_source.x, _source.y, 0, obj_INFO);
            _info.padre = _source;
            _info.texto = _source.object_index == obj_pj ? "¡Fallás!" : "¡Falla!";
            _info.color = c_red;
            break;
        case "shield":
            _sound = snd_defensaEscudo;
            if (instance_exists(_target)) {
                var _shield_info = instance_create_depth(_target.x, _target.y, 0, obj_INFO);
                _shield_info.padre = _target;
                _shield_info.texto = "¡Defendido con escudo!";
                _shield_info.color = c_red;
            }
            break;
        case "book": _sound = snd_dardoMagico; break;
        case "potion":
            _sound = snd_tomarPocion;
            if (variable_struct_exists(_message, "item") && _message.item == 221) _effect = obj_invisibilidad;
            break;
        case "food": _sound = snd_comerComida; break;
        case "drink": _sound = snd_tomarBebida; break;
        case "resurrect": _sound = snd_resucitar; break;
        case "teleport": _effect = obj_efecto_login; _sound = snd_logueo; break;
    }
    if (_sound >= 0 && instance_exists(_source)) with (_source) reproducirSonido(_sound, false, false);
    if (_effect >= 0 && (instance_exists(_follow) || _has_target_position)) {
        var _fx_x = _has_target_position ? _message.target_x : _follow.x;
        var _fx_y = _has_target_position ? _message.target_y : _follow.y;
        var _fx_depth = instance_exists(_follow) ? _follow.depth - 2 : DEPTH_FLOAT_TEXT;
        var _fx = instance_create_depth(_fx_x, _fx_y, _fx_depth, _effect);
        _fx.padre = _follow;
        if (instance_exists(_follow) && _follow.object_index == obj_online_actor
            && _follow.data.kind == "npc") array_push(_follow.online_impact_effects, _fx);
        obj_online.effect_events++;
    }
    obj_online.action_events++;
}

function online_dibujar_barras(_x, _y, _salud, _saludMax, _mana, _manaMax, _siempre) {
    if (_salud <= 0 || _saludMax <= 0 || (!_siempre && _salud >= _saludMax)) return;
    var _left = _x - HALF_TILE;
    var _top = _y - TILE_SIZE * 2 - ONLINE_BAR_TOP_OFFSET;
    var _health_fill = clamp(real(_salud) / real(_saludMax), 0.0, 1.0);
    draw_set_color(c_black);
    draw_rectangle(_left, _top, _left + TILE_SIZE, _top + ONLINE_BAR_HEIGHT, false);
    draw_set_color(c_red);
    draw_rectangle(_left, _top, _left + TILE_SIZE * _health_fill, _top + ONLINE_BAR_HEIGHT, false);
    if (_manaMax > 0) {
        _top += ONLINE_BAR_HEIGHT + ONLINE_BAR_GAP;
        var _mana_fill = clamp(real(_mana) / real(_manaMax), 0.0, 1.0);
        draw_set_color(c_black);
        draw_rectangle(_left, _top, _left + TILE_SIZE, _top + ONLINE_BAR_HEIGHT, false);
        draw_set_color(c_aqua);
        draw_rectangle(_left, _top, _left + TILE_SIZE * _mana_fill, _top + ONLINE_BAR_HEIGHT, false);
    }
    draw_set_color(c_white);
}
