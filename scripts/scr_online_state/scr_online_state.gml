function online_capturar() {
    var _state = {};
    var _fields = ["nombre", "clase", "genero", "nroRaza", "nivel", "experiencia", "saludMax", "salud",
        "manaMax", "mana", "energiaMax", "energia", "oro", "hambre", "sed", "skillsLibres", "skills", "atributos",
        "pk", "muerto", "navega", "esArmada", "esLegion", "rangoFaccion", "puntosPK", "insigniaPionero",
        "ciudadanosMatados", "criminalesMatados", "x", "y", "danoMin", "danoMax", "modDanoLvl",
        "modDanoCuerpoACuerpo", "modDanoArco", "modProbCuerpoACuerpo", "modProbArco", "modEvasion", "modEvasionEscu"];
    for (var _i = 0; _i < array_length(_fields); _i++)
        variable_struct_set(_state, _fields[_i], variable_instance_get(instance_find(obj_pj, 0), _fields[_i]));
    _state.room = room_get_name(room);
    _state.home = room_get_name(obj_pj.roomRuna);
    _state.home_x = obj_pj.xRuna;
    _state.home_y = obj_pj.yRuna;
    _state.sprCabeza = sprite_get_name(obj_pj.sprCabeza);
    _state.sprite_index = sprite_get_name(obj_pj.sprite_index);
    _state.inventory = [];
    _state.bank = [];
    _state.spells = [];
    _state.spell_slots = [];
    _state.pets = [];
    _state.estaEnPolo = obj_pj.estaEnPolo;
    _state.dragonic_ready = 0;
    if (yaHizoPedidoHerrero()) {
        var _deadline = fechaDeTerminacionHerrero();
        if (_deadline > 0) _state.dragonic_ready = date_second_span(date_create_datetime(1970, 1, 1, 0, 0, 0), _deadline);
    }
    for (var _i = 0; _i < MAX_SLOTS; _i++) {
        var _slot = obj_inventario.slots[_i];
        array_push(_state.inventory, {indice: _slot.indice, cant: _slot.cant, equipado: _slot.equipado});
        var _bank = obj_banco.slots[_i];
        array_push(_state.bank, {indice: _bank.indice, cant: _bank.cant, equipado: false});
        var _spell = obj_hechizos.hechizos[_i].indice;
        array_push(_state.spell_slots, _spell);
        if (_spell >= 0) array_push(_state.spells, _spell);
    }
    for (var _i = 0; _i < 3; _i++) {
        var _asset = obj_pj.criaturasHijas[_i, 1];
        if (_asset >= 0) array_push(_state.pets, {asset: object_get_name(_asset), salud: obj_pj.criaturasHijas[_i, 2]});
    }
    return _state;
}

function online_limpiar_mapa() {
    with (obj_npc_basic) {
        if (online_prop(id, "hostil", true)) instance_destroy();
    }
    with (obj_persona) instance_destroy();
    with (obj_item_basic) instance_destroy();
    with (obj_online_actor) instance_destroy();
    ds_map_clear(obj_online.actors);
    // El primer ingreso online todavía no creó obj_pj cuando llega world_reset.
    if (instance_exists(obj_pj)) obj_pj.alarm[9] = -1;
}

function online_aplicar(_state, _teleport) {
    var _fields = ["nombre", "clase", "genero", "nroRaza", "nivel", "experiencia", "saludMax", "salud",
        "manaMax", "mana", "energiaMax", "energia", "oro", "hambre", "sed", "skillsLibres", "skills", "atributos",
        "pk", "muerto", "navega", "esArmada", "esLegion", "rangoFaccion", "puntosPK", "insigniaPionero",
        "ciudadanosMatados", "criminalesMatados", "estaEnPolo", "veneno", "trabajando", "meditando", "invisible", "inmovilizado", "envenenado",
        "armaActual", "armaEnInv", "ropaActual", "ropaEnInv", "cascoActual", "cascoEnInv", "escudoActual", "escudoEnInv",
        "flechaActual", "flechaEnInv", "trabajoActual", "trabajoEnInv", "laudActual", "laudEnInv", "desnudo",
        "laudEquipado", "trabajoEquipado", "dopaFuerza", "dopaAgilidad", "tiempoDopa", "tiempoDopaMax", "maximoDopa",
        "danoMin", "danoMax", "modDanoLvl", "modDanoCuerpoACuerpo", "modDanoArco",
        "modProbCuerpoACuerpo", "modProbArco", "modEvasion", "modEvasionEscu"];
    for (var _i = 0; _i < array_length(_fields); _i++) {
        if (variable_struct_exists(_state, _fields[_i]))
            variable_instance_set(instance_find(obj_pj, 0), _fields[_i], variable_struct_get(_state, _fields[_i]));
    }
    static _razas = ["Humano", "Elfo", "Elfo Oscuro", "Enano", "Gnomo"];
    obj_pj.raza = _razas[obj_pj.nroRaza];
    obj_pj.roomRuna = asset_get_index(_state.home);
    if (variable_struct_exists(_state, "home_x")) obj_pj.xRuna = _state.home_x;
    if (variable_struct_exists(_state, "home_y")) obj_pj.yRuna = _state.home_y;
    obj_pj.sprCabeza = asset_get_index(_state.sprCabeza);
    obj_pj.sprArma = obtenerSpriteArma(obj_pj.armaActual);
    obj_pj.sprEscudo = obtenerSpriteEscudo(obj_pj.escudoActual);
    obj_pj.ropaIndexada = false;
    obj_pj.puedeAtacar = true;
    obj_pj.teletransporta = false;
    if (_teleport) obj_pj.direccion = _state.direccion;
    if (_teleport) { obj_pj.x = _state.x; obj_pj.y = _state.y; obj_pj.pasos = 0; obj_pj.puedeMoverse = true; }
    for (var _i = 0; _i < MAX_SLOTS; _i++) {
        var _slot = _state.inventory[_i];
        var _old = obj_inventario.slots[_i];
        if (_old.indice != _slot.indice || _old.cant != _slot.cant || _old.equipado != _slot.equipado)
            obj_inventario.slots[_i] = crearSlotInv(_slot.indice, _slot.cant, _slot.equipado);
        var _bank = _state.bank[_i];
        obj_banco.slots[_i] = crearSlotNpc(_bank.indice, _bank.cant, configurarItem(_bank.indice).nombre);
    }
    if (obj_inventario.posSeleccionado >= 0)
        obj_inventario.seleccionado = obj_inventario.slots[obj_inventario.posSeleccionado].indice;
    if (obj_pj.muerto && obj_inventario.posSeleccionado >= 0) {
        var _selectedType = obj_inventario.slots[obj_inventario.posSeleccionado].tipo;
        if (_selectedType != "runa" && _selectedType != "barca") {
            obj_inventario.posSeleccionado = -1;
            obj_inventario.seleccionado = -1;
        }
    }
    var _slotsHechizos = variable_struct_exists(_state, "spell_slots") ? _state.spell_slots : _state.spells;
    var _changed = obj_online.spell_count != array_length(_state.spells);
    if (!_changed && obj_online.pending_spell_sequence == 0 && !obj_hechizos.moviendoHechizo) {
        for (var _i = 0; _i < MAX_SLOTS; _i++) {
            var _index = _i < array_length(_slotsHechizos) ? _slotsHechizos[_i] : -1;
            if (obj_hechizos.hechizos[_i].indice != _index) { _changed = true; break; }
        }
    }
    if (_changed && obj_online.pending_spell_sequence == 0) {
        var _selectedSpell = obj_hechizos.seleccionado;
        for (var _i = 0; _i < MAX_SLOTS; _i++) obj_hechizos.hechizos[_i] = hechizoVacio();
        for (var _i = 0; _i < array_length(_slotsHechizos); _i++) {
            var _spellIndex = _slotsHechizos[_i];
            if (_spellIndex < 0) continue;
            agregarHechizo(SPELL_INDEX_BASE + _spellIndex);
            for (var _j = 0; _j < MAX_SLOTS; _j++) {
                if (obj_hechizos.hechizos[_j].indice == _spellIndex) {
                    if (_j != _i) {
                        obj_hechizos.hechizos[_i] = obj_hechizos.hechizos[_j];
                        obj_hechizos.hechizos[_j] = hechizoVacio();
                    }
                    break;
                }
            }
        }
        obj_online.spell_count = array_length(_state.spells);
        var _firstSlot = -1, _selectedSlot = -1;
        for (var _i = 0; _i < MAX_SLOTS; _i++) {
            if (obj_hechizos.hechizos[_i].indice < 0) continue;
            if (_firstSlot < 0) _firstSlot = _i;
            if (obj_hechizos.hechizos[_i].indice == _selectedSpell) _selectedSlot = _i;
        }
        obj_hechizos.posSeleccionado = _selectedSlot >= 0 ? _selectedSlot : _firstSlot;
        obj_hechizos.seleccionado = obj_hechizos.posSeleccionado < 0 ? -1
            : obj_hechizos.hechizos[obj_hechizos.posSeleccionado].indice;
    }
    obj_seguro.activo = _state.safe_attack;
    if (variable_struct_exists(_state, "multiExp")) obj_opciones.multiExp = _state.multiExp;
    if (variable_struct_exists(_state, "multiOro")) obj_opciones.multiOro = _state.multiOro;
}

function online_actualizar_ack(_message) {
    if (variable_struct_exists(_message, "sequence")) {
        obj_online.last_ack = max(obj_online.last_ack, _message.sequence);
        if (obj_online.pending_spell_sequence > 0 && obj_online.last_ack >= obj_online.pending_spell_sequence)
            obj_online.pending_spell_sequence = 0;
    }
    if (variable_struct_exists(_message, "attack_remaining"))
        obj_online.attack_ready_at = current_time + max(0, _message.attack_remaining) * ONLINE_MS_PER_SECOND;
}

function online_solicitar_resync() {
    if (!obj_online.playing || (obj_online.resync_requested
        && current_time - obj_online.resync_started_at < ONLINE_TIMEOUT_MS)) return;
    if (online_accion({op: "resync"})) {
        obj_online.resync_requested = true;
        obj_online.resync_started_at = current_time;
    }
}

function online_encolar_evento_sala(_message) {
    if (array_length(obj_online.pending_room_events) >= ONLINE_ROOM_EVENT_BUFFER_LIMIT) {
        online_solicitar_resync();
        return;
    }
    array_push(obj_online.pending_room_events, _message);
}

function online_world_reset(_message) {
    if (!global.online_modo || !obj_online.playing) return;
    if (!variable_struct_exists(_message, "generation")
        || _message.generation <= obj_online.world_generation) return;
    var _room = asset_get_index(_message.room);
    if (_room < 0) {
        online_desconectar("Mapa del servidor desconocido");
        return;
    }
    with (obj_online) {
        server_paused = variable_struct_exists(_message, "paused") && _message.paused;
        var _transition_pending = room_reset_pending;
        online_actualizar_ack(_message);
        world_room = _message.room;
        world_generation = _message.generation;
        state = undefined;
        resync_requested = false;
        resync_started_at = 0;
        pending_room_events = [];
        pending_teleports = [];
        pending_self_apply = false;
        pending_self_teleport = false;
        attack_ready_at = 0;
        spell_count = -1;
        online_limpiar_mapa();
        changing_room = _room != room || _transition_pending;
        room_reset_pending = changing_room;
        if (changing_room) room_goto(_room);
    }
}

function online_self_state(_message) {
    if (!global.online_modo || !obj_online.playing || !variable_struct_exists(_message, "self")
        || !is_struct(_message.self)) return;
    if (variable_struct_exists(_message, "generation")
        && _message.generation != obj_online.world_generation) return;
    with (obj_online) {
        online_actualizar_ack(_message);
        var _next = _message.self;
        var _full = is_undefined(state) || (variable_struct_exists(_message, "full") && _message.full);
        if (_full) {
            if (!variable_struct_exists(_next, "room") || !variable_struct_exists(_next, "inventory")
                || !variable_struct_exists(_next, "bank") || !variable_struct_exists(_next, "spells")) {
                online_solicitar_resync();
                return;
            }
            state = _next;
            pending_self_teleport = true;
            pending_self_apply = true;
        } else {
            var _old_epoch = state.position_epoch;
            var _refresh = online_self_requiere_aplicar(_next);
            online_fusionar_campos(state, _next);
            if (variable_struct_exists(_message, "removed")) {
                for (var _i = 0; _i < array_length(_message.removed); _i++) {
                    var _name = _message.removed[_i];
                    if (variable_struct_exists(state, _name)) variable_struct_remove(state, _name);
                }
            }
            if (_old_epoch != state.position_epoch) pending_self_teleport = true;
            if (_refresh || pending_self_teleport) pending_self_apply = true;
        }
        if (state.room != world_room) {
            online_solicitar_resync();
            return;
        }
        online_room_listo();
    }
}

function online_room_listo() {
    with (obj_online) {
        if (!playing || is_undefined(state) || state.room != world_room || room_get_name(room) != world_room
            || room_reset_pending
            || !instance_exists(obj_pj) || !instance_exists(obj_inventario)) return;
        if (pending_self_apply) {
            online_aplicar(state, pending_self_teleport);
            pending_self_apply = false;
            pending_self_teleport = false;
        }
        changing_room = false;
        var _events = pending_room_events;
        pending_room_events = [];
        for (var _i = 0; _i < array_length(_events); _i++)
            online_recibir(_events[_i]);
        online_teleportes_pendientes();
    }
}

function online_evento_entidad_listo(_message) {
    if (!obj_online.playing || obj_online.world_room == ""
        || !variable_struct_exists(_message, "generation")
        || _message.generation != obj_online.world_generation
        || (variable_struct_exists(_message, "room") && _message.room != obj_online.world_room))
        return false;
    if (obj_online.changing_room || obj_online.room_reset_pending || is_undefined(obj_online.state)
        || room_get_name(room) != obj_online.world_room) {
        online_encolar_evento_sala(_message);
        return false;
    }
    return true;
}

function online_congelar_efectos_npc(_npc) {
    if (!instance_exists(_npc) || is_undefined(_npc.data) || _npc.data.kind != "npc") return;
    var _links = _npc.online_impact_effects;
    for (var _i = 0; _i < array_length(_links); _i++) {
        var _fx = _links[_i];
        if (instance_exists(_fx) && variable_instance_exists(_fx, "padre") && _fx.padre == _npc) {
            _fx.x = _npc.x;
            _fx.y = _npc.y;
            _fx.padre = noone;
        }
    }
    _npc.online_impact_effects = [];
}

function online_npc_cabeza(_asset) {
    var _sprite = -1, _x = 0, _y = 36, _gira = false;
    switch (_asset) {
        case "obj_npc_bandido": _sprite = spr_cabeza_comerciantes; _gira = true; break;
        case "obj_npc_asesino": _sprite = spr_cabeza_33; _gira = true; break;
        case "obj_npc_bruja": _sprite = spr_cabeza_47; _gira = true; break;
        case "obj_npc_mago_malvado": _sprite = spr_cabeza_53; _y = 27; _gira = true; break;
        case "obj_npc_armaduras":
        case "obj_npc_cascos_escudos": _sprite = spr_cabeza_19; _y = 35; break;
        case "obj_npc_hechizos":
        case "obj_npc_mago": _sprite = spr_cabeza_19; _x = 1; break;
        case "obj_npc_carpintero":
        case "obj_npc_herrero": _sprite = spr_cabeza_comerciantes; _x = 1; break;
        case "obj_npc_comidas":
        case "obj_npc_pescador": _sprite = spr_cabeza_16; break;
        case "obj_npc_cura": _sprite = spr_cabeza_2; break;
        case "obj_npc_herrero_experto": _sprite = spr_cabeza_5; _y = 35; break;
        case "obj_npc_sastre": _sprite = spr_cabeza_26; break;
        case "obj_npc_sastre_bajos": _sprite = spr_cabeza_59; _x = 1; _y = 27; break;
        case "obj_npc_sastre_tunicas": _sprite = spr_cabeza_28; break;
        case "obj_rey": _sprite = spr_cabeza_1; _x = 1; break;
    }
    return {sprite: _sprite, x: _x, y: _y, gira: _gira};
}

function online_actor_spawn(_message) {
    if (!online_evento_entidad_listo(_message)) return;
    if (!variable_struct_exists(_message, "entity") || !is_struct(_message.entity)) {
        online_solicitar_resync();
        return;
    }
    var _entity = _message.entity;
    if (!variable_struct_exists(_entity, "id") || !variable_struct_exists(_entity, "kind")
        || !variable_struct_exists(_entity, "x") || !variable_struct_exists(_entity, "y")) {
        online_solicitar_resync();
        return;
    }
    with (obj_online) {
        var _actor = ds_map_exists(actors, _entity.id) ? actors[? _entity.id] : noone;
        var _created = !instance_exists(_actor);
        if (!_created && !is_undefined(_actor.data) && _entity.kind == "npc"
            && variable_struct_exists(_entity, "spawn_epoch")
            && variable_struct_exists(_actor.data, "spawn_epoch")
            && _entity.spawn_epoch != _actor.data.spawn_epoch) {
            online_congelar_efectos_npc(_actor);
            _actor.online_respawn_received_at = current_time;
        }
        if (_created) {
            _actor = instance_create_depth(_entity.x, _entity.y, 0, obj_online_actor);
            ds_map_set(actors, _entity.id, _actor);
        }
        _actor.x = _entity.x;
        _actor.y = _entity.y;
        _actor.last_step_x = _entity.x;
        _actor.last_step_y = _entity.y;
        _actor.walk_frame = 0;
        _actor.catching_up = false;
        _actor.data = _entity;
        if (_entity.kind == "npc")
            _actor.npc_head = online_npc_cabeza(variable_struct_exists(_entity, "asset") ? _entity.asset : "");
        _actor.received_at = current_time;
        if (_created && _entity.kind == "npc") _actor.online_respawn_received_at = current_time;
        if (_entity.kind != "drop") _actor.sprite_index = asset_get_index(_entity.sprite_index);
        if (_created && _entity.kind == "npc" && variable_struct_exists(_entity, "owner") && _entity.owner != "") {
            var _fx = instance_create_depth(_entity.x, _entity.y, _actor.depth - 2, obj_efecto_login);
            _fx.padre = _actor;
            effect_events++;
        }
    }
}

function online_actor_patch(_message) {
    if (!online_evento_entidad_listo(_message)) return;
    if (variable_struct_exists(_message, "batch")) {
        if (!is_array(_message.batch) || array_length(_message.batch) > ONLINE_ACTOR_BATCH_EVENTS) {
            online_solicitar_resync();
            return;
        }
        for (var _i = 0; _i < array_length(_message.batch); _i++) {
            var _event = _message.batch[_i];
            if (!is_struct(_event) || !variable_struct_exists(_event, "op")
                || variable_struct_exists(_event, "batch")
                || !variable_struct_exists(_event, "generation")
                || _event.generation != _message.generation) {
                online_solicitar_resync();
                return;
            }
            switch (_event.op) {
                case "actor_spawn": online_actor_spawn(_event); break;
                case "actor_patch": online_actor_patch(_event); break;
                case "actor_remove": online_actor_remove(_event); break;
                default: online_solicitar_resync(); return;
            }
        }
        return;
    }
    with (obj_online) {
        if (!ds_map_exists(actors, _message.id)) {
            online_solicitar_resync();
            return;
        }
        var _actor = actors[? _message.id];
        if (!instance_exists(_actor) || is_undefined(_actor.data)) {
            online_solicitar_resync();
            return;
        }
        var _changes = _message.changes;
        if (!is_struct(_changes)) {
            online_solicitar_resync();
            return;
        }
        var _previous = _actor.data;
        var _npc_respawn = _previous.kind == "npc"
            && variable_struct_exists(_changes, "spawn_epoch")
            && variable_struct_exists(_previous, "spawn_epoch")
            && _changes.spawn_epoch != _previous.spawn_epoch;
        if (_npc_respawn || (_previous.kind == "npc" && variable_struct_exists(_changes, "salud")
            && _changes.salud <= 0)) {
            online_congelar_efectos_npc(_actor);
            if (_npc_respawn) _actor.online_respawn_received_at = current_time;
        }
        var _epoch_changed = _npc_respawn
            || (variable_struct_exists(_changes, "position_epoch")
            && variable_struct_exists(_previous, "position_epoch")
            && _changes.position_epoch != _previous.position_epoch);
        online_fusionar_campos(_previous, _changes);
        if (variable_struct_exists(_message, "removed")) {
            for (var _i = 0; _i < array_length(_message.removed); _i++) {
                var _name = _message.removed[_i];
                if (variable_struct_exists(_previous, _name)) variable_struct_remove(_previous, _name);
            }
        }
        if (_epoch_changed) {
            _actor.x = _previous.x;
            _actor.y = _previous.y;
            _actor.last_step_x = _previous.x;
            _actor.last_step_y = _previous.y;
            _actor.walk_frame = 0;
            _actor.catching_up = false;
        }
        if (_previous.kind != "drop" && variable_struct_exists(_changes, "sprite_index"))
            _actor.sprite_index = asset_get_index(_previous.sprite_index);
        _actor.received_at = current_time;
    }
}

function online_actor_remove(_message) {
    if (!online_evento_entidad_listo(_message)) return;
    with (obj_online) {
        if (!ds_map_exists(actors, _message.id)) return;
        var _actor = actors[? _message.id];
        if (instance_exists(_actor)) {
            online_congelar_efectos_npc(_actor);
            with (_actor) instance_destroy();
        }
        ds_map_delete(actors, _message.id);
    }
}

function online_teleportes_pendientes() {
    with (obj_online) {
        for (var _i = 0; _i < array_length(pending_teleports); _i++) {
            if (pending_teleports[_i].room == room_get_name(room)) online_efecto(pending_teleports[_i]);
        }
        pending_teleports = [];
    }
}

function online_fusionar_campos(_destino, _cambios) {
    var _nombres = variable_struct_get_names(_cambios);
    for (var _i = 0; _i < array_length(_nombres); _i++) {
        var _nombre = _nombres[_i];
        variable_struct_set(_destino, _nombre, variable_struct_get(_cambios, _nombre));
    }
}

function online_self_requiere_aplicar(_cambios) {
    var _nombres = variable_struct_get_names(_cambios);
    for (var _i = 0; _i < array_length(_nombres); _i++) {
        switch (_nombres[_i]) {
            case "x": case "y": case "direccion":
            case "next_move": case "moving_until": case "next_attack":
            case "next_bow": case "next_spell": case "next_chat":
            case "next_priest": case "next_cold": case "next_hunger":
            case "next_regen": case "next_meditate": case "next_poison":
            case "frozen_until": case "next_arena_bot":
                break;
            default:
                return true;
        }
    }
    return false;
}
