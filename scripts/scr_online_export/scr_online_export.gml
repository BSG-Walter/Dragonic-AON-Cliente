
function online_prop(_id, _name, _default) {
    return variable_instance_exists(_id, _name) ? variable_instance_get(_id, _name) : _default;
}

function online_export_map() {
    var _map = {name: room_get_name(room), width: room_width div TILE_SIZE, height: room_height div TILE_SIZE,
        safe: obj_mapas_mundo.mapas[room], cells: "", portals: [], npcs: [], resources: [], polar: []};
    var _cells = "";
    var _spawns = "";
    with (obj_pj) {
        for (var _row = 0; _row < _map.height; _row++) {
            for (var _col = 0; _col < _map.width; _col++) {
                var _px = HALF_TILE + _col * TILE_SIZE;
                var _py = HALF_TILE + _row * TILE_SIZE;
                var _cell = "1";
                if (place_meeting(_px, _py, obj_bloque_basic)) _cell = "0";
                else if (place_meeting(_px, _py, obj_bloqueo_agua)) _cell = "2";
                else if (place_meeting(_px, _py, obj_bloqueo_tierra)) _cell = "1";
                else if (hayAguaEn(_px, _py)) _cell = "2";
                if (instance_position(_px, _py - HALF_TILE, obj_npc_basic) != noone) {
                    var _npc = instance_position(_px, _py - HALF_TILE, obj_npc_basic);
                    if (!online_prop(_npc, "hostil", true)) _cell = "0";
                }
                _cells += _cell;
                var _spawn = _cell;
                if (_spawn == "1" && tile_layer_find(TILE_LAYER_GRASS, _px, _py) == -1) _spawn = "0";
                if (place_meeting(_px, _py, obj_telep)) _spawn = "0";
                _spawns += _spawn;
            }
        }
    }
    _map.cells = _cells;
    _map.spawnCells = _spawns;
    with (obj_telep) {
        if (roomTP != -1) {
            array_push(_map.portals, {left: bbox_left, right: bbox_right, top: bbox_top, bottom: bbox_bottom,
                target: room_get_name(roomTP), x: online_prop(id, "xTP", -1), y: online_prop(id, "yTP", -1),
                fixed: object_index == obj_tp, level: nivelRequerido});
        }
    }
    with (obj_npc_basic) {
        if (object_index != obj_persona) {
            var _record = online_export_npc();
            array_push(_map.npcs, _record);
        }
    }
    with (obj_arbol_basic) {
        array_push(_map.resources, {kind: "tala", x: x, y: y});
    }
    with (obj_minas) {
        array_push(_map.resources, {kind: "mineria", x: x, y: y, mineral: tipo});
    }
    with (obj_fragua) {
        array_push(_map.resources, {kind: "fragua", x: x, y: y});
    }
    with (obj_bloqueo_polo_entrada) array_push(_map.polar, {left: bbox_left, right: bbox_right, top: bbox_top, bottom: bbox_bottom, enter: true});
    with (obj_bloqueo_polo_salida) array_push(_map.polar, {left: bbox_left, right: bbox_right, top: bbox_top, bottom: bbox_bottom, enter: false});
    array_push(world.maps, _map);
    show_debug_message("ONLINE_EXPORT " + _map.name);
}

function online_export_npc() {
    var _record = {asset: object_get_name(object_index), name: online_prop(id, "nombre", object_get_name(object_index)),
        sprite: sprite_get_name(sprite_index), frames: online_prop(id, "index", [[0], [0], [0], [0]]), x: x, y: y, hostil: hostil,
        hp: online_prop(id, "saludMax", 1), attack: online_prop(id, "ataque", 1),
        damageMin: online_prop(id, "danoMeleeMin", 1), damageMax: online_prop(id, "danoMeleeMax", 1),
        xp: online_prop(id, "experiencia", 0), gold: online_prop(id, "oro", 0),
        evasion: online_prop(id, "evasion", 0), poison: online_prop(id, "envenena", false),
        magicMin: online_prop(id, "danoHechizoMin", 0), magicMax: online_prop(id, "danoHechizoMax", 0),
        moveInterval: (TILE_SIZE / max(1, online_prop(id, "spd", ONLINE_NPC_DEFAULT_SPEED)) + ONLINE_NPC_MOVE_REST_FRAMES) / SECOND,
        poisonDamage: online_prop(id, "veneno", 0), attackInterval: online_prop(id, "intervaloAtaque", SECOND * 2) / SECOND,
        spell: online_prop(id, "nroHechizo", 11), paralyzes: object_is_ancestor(object_index, obj_npc_basic_paraliza),
        drop: online_prop(id, "dropeaItem", false) ? online_prop(id, "indItem", -1) : -1,
        dropCount: online_prop(id, "cantItem", 1), tame: online_prop(id, "puntosDomaNPC", -1),
        water: object_is_ancestor(object_index, obj_npc_basic_acuatico), shop: []};
    if (variable_instance_exists(id, "slots")) {
        for (var _i = 0; _i < MAX_SLOTS; _i++) {
            if (slots[_i].indice != -1) array_push(_record.shop, slots[_i].indice);
        }
    }
    var _effect = online_prop(id, "objHechizo", noone);
    _record.spell = _effect == obj_dardo_magico ? 5 : (_effect == obj_misil_magico ? 8 : (_effect == obj_tormenta_de_fuego ? 9 : (_effect == obj_apocalipsis ? 11 : 10)));
    return _record;
}
