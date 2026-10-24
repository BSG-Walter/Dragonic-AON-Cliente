
if (async_load[? "id"] != socket) exit;
switch (async_load[? "type"]) {
    case network_type_non_blocking_connect:
        if (!async_load[? "succeeded"]) { online_desconectar("No se pudo conectar al servidor"); exit; }
        connected = true;
        last_receive = current_time;
        show_debug_message("ONLINE_SOCKET_CONNECTED");
        break;
    case network_type_data:
        var _buffer = async_load[? "buffer"];
        var _size = async_load[? "size"];
        if (ds_map_exists(async_load, "message_type")
            && async_load[? "message_type"] != network_send_binary) {
            online_desconectar("El servidor envió texto en lugar de datos binarios");
            exit;
        }
        if (_size <= 0 || _size > ONLINE_MAX_MESSAGE) { online_desconectar("Paquete inválido"); exit; }
        try {
            online_recibir(online_wire_decode(_buffer, _size));
        } catch (_error) {
            show_debug_message("ONLINE_WIRE_DECODE_ERROR " + string(_error));
            online_desconectar("No se pudo procesar la respuesta del servidor");
        }
        break;
    case network_type_disconnect: online_desconectar("Se cerró la conexión"); break;
}
