
if (!started) {
    if (room != rm_menuPrincipal) exit;
    started = true;
    crearObjetosBasicos(-1);
    with (obj_pj) {
        alarm[9] = -1;
        for (var _i = 0; _i < array_length(expLvl); _i++) array_push(other.world.experience, expLvl[_i]);
        for (var _i = 0; _i < array_length(skillsNaturales); _i++) array_push(other.world.skillCaps, skillsNaturales[_i]);
    }
    for (var _i = 0; _i <= ONLINE_MAX_ITEM; _i++) {
        var _item = configurarItem(_i);
        var _desc = descripcionItem(_i);
        _item.index = _i;
        _item.description = _desc.desc;
        _item.price = _desc.precio;
        _item.sprite = sprite_get_name(obtenerSpriteRopa(_i));
        var _recipe = datosTrabajo(_i);
        if (_recipe.consume1 > 0) _item.recipe = _recipe;
        array_push(world.items, _item);
    }
    for (var _i = SPELL_INDEX_BASE; _i < SPELL_INDEX_BASE + MAX_SLOTS; _i++) agregarHechizo(_i);
    world.spells = obj_hechizos.hechizos;
    world.multiExp = 1;
    world.multiOro = 1;
    room_goto(rm_3);
    exit;
}
if (settle > 0) { settle--; exit; }
online_export_map();
map_number++;
if (map_number > 160) {
    world.summons = [];
    var _assets = [obj_npc_lobo_invocado, obj_npc_zombie_invocado, obj_npc_ele_agua_invocado, obj_npc_ele_tierra_invocado, obj_npc_ele_fuego_invocado];
    for (var _i = 0; _i < array_length(_assets); _i++) {
        var _npc = instance_create_depth(ONLINE_SPAWN_X, ONLINE_SPAWN_Y, 0, _assets[_i]);
        with (_npc) array_push(other.world.summons, online_export_npc());
        with (_npc) instance_destroy();
    }
    var _file = file_text_open_write(ONLINE_EXPORT_FILE);
    file_text_write_string(_file, json_stringify(world));
    file_text_close(_file);
    show_debug_message("ONLINE_EXPORT_DONE " + working_directory + ONLINE_EXPORT_FILE);
    game_end();
} else {
    room_goto(map_number == 160 ? rm_arena : asset_get_index("rm_" + string(map_number)));
    settle = ONLINE_EXPORT_SETTLE;
}
