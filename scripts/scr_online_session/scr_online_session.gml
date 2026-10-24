function online_activo() { return global.online_modo; }

function online_wire_opcodes() {
    static _names = [
        "hello", "login", "authenticated", "ping", "pong", "enter", "entered", "leave", "left",
        "world_reset", "self_state", "actor_spawn", "actor_patch", "actor_remove", "ack",
        "position", "error", "damage", "skill_gain", "speech", "action", "level", "chat",
        "move", "attack", "cast", "work", "drop", "pickup", "use", "equip", "swap",
        "spell_order", "resync", "tame", "smelt", "work_selection", "next_arena_bot", "turn",
        "safe", "save", "resurrect", "home", "meditate", "stop_work", "arena_bot",
        "buy", "sell", "deposit", "withdraw", "skill_open", "skill", "craft", "faction",
        "dragonic", "characters", "create_character", "delete_character"
    ];
    return _names;
}

function online_wire_opcode(_name) {
    var _names = online_wire_opcodes();
    for (var _i = 0; _i < array_length(_names); _i++) {
        if (_names[_i] == _name) return _i + 1;
    }
    throw ("Opcode desconocido");
}

function online_wire_write(_buf, _type, _value, _bytes) {
    if (buffer_tell(_buf) + _bytes > ONLINE_MAX_MESSAGE
        || buffer_write(_buf, _type, _value) != 0)
        throw ("Paquete binario demasiado grande o inválido");
}

function online_wire_write_string(_buf, _value) {
    if (!is_string(_value))
        throw ("Cadena de protocolo inválida");
    var _bytes = string_byte_length(_value) + 1;
    var _start = buffer_tell(_buf);
    online_wire_write(_buf, buffer_string, _value, _bytes);
    if (buffer_tell(_buf) != _start + _bytes)
        throw ("Cadena de protocolo inválida");
    for (var _i = _start; _i < _start + _bytes - 1; _i++) {
        if (buffer_peek(_buf, _i, buffer_u8) == 0)
            throw ("Cadena de protocolo inválida");
    }
}

function online_wire_write_map(_buf, _value, _depth, _skip_op) {
    if (_depth > ONLINE_WIRE_MAX_DEPTH || !is_struct(_value))
        throw ("Mapa fuera de los límites del protocolo");
    var _keys = variable_struct_get_names(_value);
    var _count = array_length(_keys) - (_skip_op ? 1 : 0);
    if (_count < 0 || _count > ONLINE_WIRE_MAX_COUNT)
        throw ("Mapa demasiado grande");
    online_wire_write(_buf, buffer_u8, 7, 1);
    online_wire_write(_buf, buffer_u16, _count, 2);
    for (var _i = 0; _i < array_length(_keys); _i++) {
        var _key = _keys[_i];
        if (_skip_op && _key == "op") continue;
        online_wire_write_string(_buf, _key);
        online_wire_write_value(_buf, variable_struct_get(_value, _key), _depth + 1);
    }
}

function online_wire_write_value(_buf, _value, _depth) {
    if (_depth > ONLINE_WIRE_MAX_DEPTH)
        throw ("Profundidad máxima de protocolo excedida");
    if (is_undefined(_value)) {
        online_wire_write(_buf, buffer_u8, 0, 1);
    } else if (is_bool(_value)) {
        online_wire_write(_buf, buffer_u8, _value ? 2 : 1, 1);
    } else if (is_string(_value)) {
        online_wire_write(_buf, buffer_u8, 5, 1);
        online_wire_write_string(_buf, _value);
    } else if (is_array(_value)) {
        var _len = array_length(_value);
        if (_len > ONLINE_WIRE_MAX_COUNT) throw ("Array demasiado grande");
        online_wire_write(_buf, buffer_u8, 6, 1);
        online_wire_write(_buf, buffer_u16, _len, 2);
        for (var _i = 0; _i < _len; _i++)
            online_wire_write_value(_buf, _value[_i], _depth + 1);
    } else if (is_struct(_value)) {
        online_wire_write_map(_buf, _value, _depth, false);
    } else if (is_numeric(_value)) {
        if (is_nan(_value) || is_infinity(_value))
            throw ("Número no finito en protocolo");
        if (_value >= ONLINE_WIRE_INT32_MIN && _value <= ONLINE_WIRE_INT32_MAX
            && floor(_value) == _value) {
            online_wire_write(_buf, buffer_u8, 3, 1);
            online_wire_write(_buf, buffer_s32, _value, 4);
        } else {
            online_wire_write(_buf, buffer_u8, 4, 1);
            online_wire_write(_buf, buffer_f64, _value, 8);
        }
    } else {
        throw ("Tipo de campo no admitido por protocolo");
    }
}

function online_wire_encode(_message) {
    if (!is_struct(_message) || !variable_struct_exists(_message, "op"))
        throw ("Mensaje de red inválido");
    var _buf = buffer_create(256, buffer_grow, 1);
    try {
        online_wire_write(_buf, buffer_u16, online_wire_opcode(_message.op), 2);
        online_wire_write_map(_buf, _message, 0, true);
        return _buf;
    } catch (_error) {
        buffer_delete(_buf);
        throw (_error);
    }
}

function online_wire_require(_reader, _count) {
    if (_count < 0 || _reader.pos + _count > _reader.size)
        throw ("Trama binaria truncada");
}

function online_wire_read_u8(_reader) {
    online_wire_require(_reader, 1);
    var _result = buffer_peek(_reader.buf, _reader.pos, buffer_u8);
    _reader.pos++;
    return _result;
}

function online_wire_read_u16(_reader) {
    var _low = online_wire_read_u8(_reader);
    return _low + 256 * online_wire_read_u8(_reader);
}

function online_wire_read_u32(_reader) {
    var _a = online_wire_read_u16(_reader);
    return _a + 65536 * online_wire_read_u16(_reader);
}

function online_wire_read_string(_reader) {
    var _start = _reader.pos;
    while (true) {
        var _first = online_wire_read_u8(_reader);
        if (_first == 0) break;
        if (_first < 128) continue;
        var _count = 0;
        var _lowest = 128;
        var _highest = 191;
        if (_first >= 194 && _first <= 223) {
            _count = 1;
        } else if (_first >= 224 && _first <= 239) {
            _count = 2;
            if (_first == 224) _lowest = 160;
            if (_first == 237) _highest = 159;
        } else if (_first >= 240 && _first <= 244) {
            _count = 3;
            if (_first == 240) _lowest = 144;
            if (_first == 244) _highest = 143;
        } else {
            throw ("Cadena UTF-8 inválida");
        }
        for (var _i = 0; _i < _count; _i++) {
            var _next = online_wire_read_u8(_reader);
            if (_next < _lowest || _next > _highest)
                throw ("Cadena UTF-8 inválida");
            _lowest = 128;
            _highest = 191;
        }
    }
    buffer_seek(_reader.buf, buffer_seek_start, _start);
    return buffer_read(_reader.buf, buffer_string);
}

function online_wire_read_value(_reader, _depth) {
    if (_depth > ONLINE_WIRE_MAX_DEPTH)
        throw ("Profundidad máxima de protocolo excedida");
    var _tag = online_wire_read_u8(_reader);
    switch (_tag) {
        case 0: return undefined;
        case 1: return false;
        case 2: return true;
        case 3:
            var _word = online_wire_read_u32(_reader);
            return _word >= 2147483648 ? _word - 4294967296 : _word;
        case 4:
            online_wire_require(_reader, 8);
            var _value = buffer_peek(_reader.buf, _reader.pos, buffer_f64);
            _reader.pos += 8;
            if (is_nan(_value) || is_infinity(_value))
                throw ("Número no finito en protocolo");
            return _value;
        case 5: return online_wire_read_string(_reader);
        case 6:
            var _len = online_wire_read_u16(_reader);
            if (_len > (_reader.size - _reader.pos))
                throw ("Array fuera de los límites de la trama");
            var _items = array_create(_len);
            for (var _i = 0; _i < _len; _i++)
                _items[_i] = online_wire_read_value(_reader, _depth + 1);
            return _items;
        case 7: return online_wire_read_map(_reader, _depth, true);
    }
    throw ("Etiqueta binaria desconocida");
}

function online_wire_read_map(_reader, _depth, _tag_read = false) {
    if (_depth > ONLINE_WIRE_MAX_DEPTH || (!_tag_read && online_wire_read_u8(_reader) != 7))
        throw ("Mapa de protocolo inválido");
    var _len = online_wire_read_u16(_reader);
    if (_len > (_reader.size - _reader.pos) div 2)
        throw ("Mapa fuera de los límites de la trama");
    var _result = {};
    for (var _i = 0; _i < _len; _i++) {
        var _key = online_wire_read_string(_reader);
        if (variable_struct_exists(_result, _key))
            throw ("Campo binario duplicado");
        variable_struct_set(_result, _key, online_wire_read_value(_reader, _depth + 1));
    }
    return _result;
}

function online_wire_decode(_buf, _size) {
    if (_size < 5 || _size > ONLINE_MAX_MESSAGE || _size > buffer_get_size(_buf))
        throw ("Tamaño de trama binaria inválido");
    var _reader = {buf: _buf, size: _size, pos: 0};
    var _opcode = online_wire_read_u16(_reader);
    var _names = online_wire_opcodes();
    if (_opcode < 1 || _opcode > array_length(_names))
        throw ("Opcode de red desconocido");
    var _result = online_wire_read_map(_reader, 0);
    if (_reader.pos != _size || variable_struct_exists(_result, "op"))
        throw ("Trama de red con bytes o campos extra");
    _result.op = _names[_opcode - 1];
    return _result;
}

function online_enviar(_message) {
    if (!instance_exists(obj_online) || !obj_online.connected) return false;
    var _buffer;
    try {
        _buffer = online_wire_encode(_message);
    } catch (_error) {
        if (obj_online.test_role != "")
            show_debug_message("ONLINE_WIRE_ENCODE_ERROR " + string(_error));
        online_desconectar("No se pudo preparar el paquete binario");
        return false;
    }
    var _size = buffer_tell(_buffer);
    var _sent = network_send_raw(obj_online.socket, _buffer, _size, network_send_binary);
    buffer_delete(_buffer);
    if (_message.op == "ping")
        show_debug_message("ONLINE_PING_SENT result=" + string(_sent)
            + " ms_since_receive=" + string(current_time - obj_online.last_receive));
    if (_sent < 0) { online_desconectar("Se perdió la conexión"); return false; }
    return true;
}

function online_accion(_message) {
    if (!global.online_modo || !obj_online.playing) return false;
    if (obj_online.server_paused && _message.op != "resync" && _message.op != "save" && _message.op != "chat" && _message.op != "stop_work") return false;
    obj_online.sequence++;
    _message.sequence = obj_online.sequence;
    return online_enviar(_message);
}

function online_comercio_solicitar(_message) {
    if (!instance_exists(obj_online) || !global.online_modo || !obj_online.playing
        || !obj_online.connected || obj_online.server_paused || is_undefined(obj_online.state)
        || !is_struct(obj_online.state) || !variable_struct_exists(obj_online.state, "id")
        || array_length(obj_online.commerce_pending) >= 64) return false;
    // Record the intention BEFORE sending: a network failure can happen
    // after the server committed the trade but before the ACK arrives.
    var _pending = {player: obj_online.state.id, message: _message, retry: false};
    array_push(obj_online.commerce_pending, _pending);
    if (online_accion(_message)) return true;
    _pending.retry = true;
    return false;
}

function online_comercio_responder(_message) {
    if (!instance_exists(obj_online)
        || !variable_struct_exists(_message, "commerce_request_id")) return;
    var _id = _message.commerce_request_id;
    for (var _i = array_length(obj_online.commerce_pending) - 1; _i >= 0; _i--) {
        if (obj_online.commerce_pending[_i].message.request_id == _id) {
            array_delete(obj_online.commerce_pending, _i, 1);
            break;
        }
    }
}

function online_comercio_marcar_reintentos() {
    if (!instance_exists(obj_online)) return;
    for (var _i = 0; _i < array_length(obj_online.commerce_pending); _i++)
        obj_online.commerce_pending[_i].retry = true;
}

function online_comercio_reintentar(_player) {
    if (!instance_exists(obj_online) || !obj_online.playing) return;
    for (var _i = 0; _i < array_length(obj_online.commerce_pending); _i++) {
        var _pending = obj_online.commerce_pending[_i];
        if (_pending.player != _player || !_pending.retry) continue;
        // Reuse the original request_id and payload; online_accion assigns
        // a fresh sequence for this WebSocket session only.
        _pending.retry = false;
        if (!online_accion(_pending.message)) {
            _pending.retry = true;
            return;
        }
    }
}

function online_guardado_estado(_estado, _texto) {
    obj_online.save_state = _estado;
    obj_online.save_feedback = _texto;
    obj_online.save_feedback_until = current_time + ONLINE_STATUS_DURATION_MS;
    if (_estado != 1) {
        obj_online.status_text = _texto;
        obj_online.status_expire_at = obj_online.save_feedback_until;
    }
}

function online_guardado_solicitar() {
    if (!instance_exists(obj_online) || !obj_online.playing) return false;
    if (obj_online.save_state == 1) return true;
    if (!online_accion({op: "save"}) || !obj_online.playing) {
        online_guardado_estado(3, "No se pudo solicitar el guardado");
        return false;
    }
    obj_online.save_sequence = obj_online.sequence;
    obj_online.save_started_at = current_time;
    online_guardado_estado(1, "Guardando en el servidor...");
    return true;
}

function online_guardado_responder(_message) {
    if (obj_online.save_sequence <= 0 || obj_online.save_state == 2 || obj_online.save_state == 3) return;
    if (_message.op == "ack" && variable_struct_exists(_message, "saved_sequence")
        && is_numeric(_message.saved_sequence) && _message.saved_sequence == obj_online.save_sequence) {
        online_guardado_estado(2, "Partida guardada");
    } else if (_message.op == "error" && variable_struct_exists(_message, "save_sequence")
        && is_numeric(_message.save_sequence) && _message.save_sequence == obj_online.save_sequence) {
        online_guardado_estado(3, "No se pudo guardar: " + string(_message.message));
    }
}

function online_desconectar(_reason) {
    online_comercio_marcar_reintentos();
    if (instance_exists(obj_online) && (obj_online.save_state == 1 || obj_online.save_state == 4))
        online_guardado_estado(4, "Guardado sin confirmar: se interrumpió la conexión");
    if (instance_exists(obj_online) && obj_online.socket >= 0)
        show_debug_message("ONLINE_DISCONNECT " + _reason + "; sin recibir ms=" + string(current_time - obj_online.last_receive));
    if (global.online_elegir && (room == rm_crearPJ || room == rm_nombrePJ)) {
        online_creacion_limpiar();
        room_goto(rm_menuPrincipal);
    }
    global.online_elegir = false;
    with (obj_online) {
        if (socket >= 0) network_destroy(socket);
        socket = -1;
        connected = false;
        authenticated = false;
        playing = false;
        online_count = 0;
        server_paused = false;
        cleanup_seconds = -1;
        cleanup_received_at = 0;
        characters_ready = false;
        enter_pending = false;
        create_pending = false;
        delete_pending = false;
        delete_name = "";
        status_text = _reason;
        save_sequence = 0;
        form_values[3] = "";
        state = undefined;
        attack_ready_at = 0;
        pending_spell_sequence = 0;
        pending_teleports = [];
        pending_room_events = [];
        pending_self_apply = false;
        pending_self_teleport = false;
        changing_room = false;
        room_reset_pending = false;
        world_room = "";
        world_generation = -1;
        resync_requested = false;
        resync_started_at = 0;
        create_started_at = 0;
        form_open = false;
        ds_map_clear(actors);
    }
    with (obj_online_actor) instance_destroy();
    if (global.online_modo) {
        global.online_pendiente = false;
        with (obj_pj) { upKey = false; downKey = false; leftKey = false; rightKey = false; }
    }
}

function online_host_lan(_host) {
    if (_host == "ws://localhost" || _host == "ws://127.0.0.1") return true;
    if (string_pos("ws://", _host) != 1) return false;

    var _octets = string_split(string_delete(_host, 1, string_length("ws://")), ".");
    if (array_length(_octets) != 4) return false;
    for (var _i = 0; _i < 4; _i++) {
        if (_octets[_i] == "" || string_length(_octets[_i]) > 3
            || string_digits(_octets[_i]) != _octets[_i]) return false;
        var _octet = real(_octets[_i]);
        if (_octet > 255) return false;
        _octets[_i] = _octet;
    }
    return _octets[0] == 10
        || (_octets[0] == 172 && _octets[1] >= 16 && _octets[1] <= 31)
        || (_octets[0] == 192 && _octets[1] == 168);
}

function online_conectar(_register) {
    if (ONLINE_DISCOVERY_URL != "" && obj_online.test_role == ""
        && obj_online.form_values[0] == obj_online.discovery_host) {
        if (obj_online.discovery_request >= 0) {
            obj_online.status_text = "Buscando servidor online...";
            return;
        }
        obj_online.discovery_register = _register;
        obj_online.discovery_request = http_get(ONLINE_DISCOVERY_URL + "/server");
        obj_online.status_text = obj_online.discovery_request >= 0
            ? "Buscando servidor online..." : "No se pudo consultar el servidor público";
        return;
    }
    online_conectar_directo(_register);
}

function online_conectar_directo(_register) {
    if (obj_online.actualizacion_estado != 1) {
        if (obj_online.actualizacion_estado == 0)
            obj_online.status_text = "Comprobando la última versión. Intentá nuevamente...";
        else if (obj_online.actualizacion_estado == 2)
            obj_online.status_text = "Actualizá el cliente a " + obj_online.actualizacion_version + " para entrar online";
        else
            obj_online.status_text = "No se pudo comprobar la versión. Verificá Internet y reiniciá el juego";
        return;
    }
    with (obj_online) {
        login_phase_started_at = current_time;
        enter_started_at = 0;
        create_started_at = 0;
        if (socket >= 0) network_destroy(socket);
        socket = -1;
        connected = false;
        authenticated = false;
        playing = false;
        characters_ready = false;
        enter_pending = false;
        create_pending = false;
        server_paused = false;
        cleanup_seconds = -1;
        cleanup_received_at = 0;
        state = undefined;
        world_room = "";
        world_generation = -1;
        changing_room = false;
        room_reset_pending = false;
        pending_room_events = [];
        pending_teleports = [];
        pending_self_apply = false;
        pending_self_teleport = false;
        resync_requested = false;
        resync_started_at = 0;
        save_state = 0;
        save_sequence = 0;
        save_feedback = "";
        register_account = _register;
        var _host = string_trim(form_values[0]);
        if (string_pos("wss://", _host) != 1 && string_pos("ws://", _host) != 1) {
            status_text = "Usá ws:// para LAN o wss:// para Internet";
            return;
        }
        if (string_pos("ws://", _host) == 1 && !online_host_lan(_host)) {
            status_text = "Para Internet usá wss://; en LAN usá ws://IP privada";
            return;
        }
        if (string_digits(form_values[1]) != form_values[1] || string_length(form_values[1]) == 0) { status_text = "Puerto inválido"; return; }
        var _port = real(form_values[1]);
        if (_port < 1 || _port > 65535 || floor(_port) != _port) {
            status_text = "Puerto inválido";
            return;
        }
        socket = network_create_socket(string_pos("wss://", _host) == 1 ? network_socket_wss : network_socket_ws);
        if (socket < 0 || network_connect_raw_async(socket, _host, _port) < 0) {
            online_desconectar("No se pudo conectar");
            return;
        }
        last_receive = current_time;
        status_text = "Conectando...";
        if (os_type == os_android || os_type == os_ios) keyboard_virtual_hide();
        form_field = -1;
        keyboard_string = "";
        if (test_role != "") return;
        ini_open("online.ini");
        ini_write_string("server", "host", form_values[0]);
        ini_write_string("server", "port", form_values[1]);
        ini_write_string("server", "account", form_values[2]);
        ini_close();
    }
}
