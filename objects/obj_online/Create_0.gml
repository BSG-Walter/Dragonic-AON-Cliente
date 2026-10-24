
socket = -1;
connected = false;
authenticated = false;
playing = false;
online_count = 0;
server_paused = false;
state = undefined;
last_receive = current_time;
login_phase_started_at = current_time;
enter_started_at = 0;
create_started_at = 0;
last_move = 0;
last_ping = 0;
sequence = 0;
last_ack = 0;
save_state = 0;
save_sequence = 0;
save_started_at = 0;
save_feedback = "";
save_feedback_until = 0;
commerce_nonce = sha1_string_utf8(string(date_current_datetime()) + ":" + string(get_timer()) + ":" + string(random(1)));
commerce_next_id = 0;
commerce_pending = [];
attack_ready_at = 0;
actors = ds_map_create();
status_text = "";
status_last_text = "";
status_expire_at = 0;
cleanup_seconds = -1;
cleanup_received_at = 0;
form_open = false;
form_field = -1;
form_values = ["wss://antibody-thumb-foods-raymond.trycloudflare.com", "443", "", ""];
test_role = "";
test_players_seen = 0;
test_npc_damage = 0;
test_npc = noone;
test_capture = false;
test_save_roundtrip = false;
test_selection_flow = false;
test_interval_room_fallback_ok = false;
test_interaction_checks = undefined;
test_interaction_complete = false;
test_stage = 0;
test_started = current_time;
local_slot = -1;
characters = [];
characters_ready = false;
character_selected = -1;
character_create_name = "";
create_pending = false;
delete_pending = false;
delete_name = "";
enter_pending = false;
test_enter_sent = false;
for (var _i = 1; _i <= parameter_count(); _i++) {
    if (parameter_string(_i) == "--export-online") instance_create_depth(0, 0, ONLINE_DEPTH, obj_online_export);
}

display_set_gui_size(RESOLUTION_WIDTH, RESOLUTION_HEIGHT);
register_account = false;
changing_room = false;
room_reset_pending = false;
world_room = "";
world_generation = -1;
pending_room_events = [];
pending_self_apply = false;
pending_self_teleport = false;
resync_requested = false;
resync_started_at = 0;
pending_teleports = [];
failed_entry = false;
spell_count = -1;
pending_spell_sequence = 0;
damage_events = 0;
menu_editing_count = false;
menu_open = false;
menu_npc = noone;
menu_selection = 0;
menu_side = 0;
menu_count = "1";
last_inventory_click = 0;
catalog = undefined;
if (file_exists("online_catalog.json")) {
    var _catalog_buffer = buffer_load("online_catalog.json");
    catalog = json_parse(buffer_read(_catalog_buffer, buffer_string));
    buffer_delete(_catalog_buffer);
}
if (file_exists("online.ini")) {
    ini_open("online.ini");
    //form_values[0] = ini_read_string("server", "host", form_values[0]);
    //form_values[1] = ini_read_string("server", "port", form_values[1]);
    form_values[2] = ini_read_string("server", "account", "");
    ini_close();
}
if (form_values[1] == string(ONLINE_PREVIOUS_PORT)) form_values[1] = string(ONLINE_PORT);
for (var _i = 1; _i <= parameter_count(); _i++) {
    if (parameter_string(_i) == "--online-ui-test" && _i < parameter_count()) test_role = parameter_string(_i + 1);
    if (parameter_string(_i) == "--offline-test") test_role = "offline";
    if (parameter_string(_i) == "--online-test" && _i < parameter_count()) {
        test_role = parameter_string(_i + 1);
        form_values = ["ws://127.0.0.1", string(ONLINE_TEST_PORT), "smoke_" + test_role, "DragonicTest123"];
    }
}

action_events = 0;
effect_events = 0;

test_last_live = 0;
audio_events = 0;

test_action_count = 0;
test_dopa_strength_sent = false;
test_dopa_seen = false;

last_tame_target = "";
last_tame_click = 0;

actualizacion_request = -1;
actualizacion_version = "";
actualizacion_url = "";
actualizacion_es_apk = false;
actualizacion_estado = (os_type == os_android && test_role == "") ? 0 : 1;
actualizacion_iniciada = current_time;
if (actualizacion_estado == 0) {
    var _headers = ds_map_create();
    ds_map_add(_headers, "User-Agent", "Dragonic-AON-Cliente");
    ds_map_add(_headers, "Accept", "application/vnd.github+json");
    actualizacion_request = http_request(ACTUALIZACIONES_API, "GET", _headers, "");
    ds_map_destroy(_headers);
}
