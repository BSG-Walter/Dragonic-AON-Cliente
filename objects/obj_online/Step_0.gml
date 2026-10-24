
if (global.online_exportando) exit;
if (status_text != status_last_text) {
    status_last_text = status_text;
    status_expire_at = current_time + ONLINE_STATUS_DURATION_MS;
}
if (status_text != "" && current_time >= status_expire_at) {
    status_text = "";
    status_last_text = "";
}
if (socket >= 0 && connected && !characters_ready && !playing
    && current_time - login_phase_started_at > ONLINE_TIMEOUT_MS) {
    show_debug_message("ONLINE_LOGIN_TIMEOUT handshake/authentication/characters");
    online_desconectar("No se completó el inicio de sesión");
    if (room == rm_seleccionarPJ) room_goto(rm_menuPrincipal);
}
if (socket >= 0 && enter_pending
    && current_time - enter_started_at > ONLINE_TIMEOUT_MS) {
    show_debug_message("ONLINE_LOGIN_TIMEOUT entering_character");
    online_desconectar("No se recibió la entrada del personaje");
    if (room == rm_seleccionarPJ) room_goto(rm_menuPrincipal);
}
if (socket >= 0 && create_pending
    && current_time - create_started_at > ONLINE_TIMEOUT_MS) {
    show_debug_message("ONLINE_LOGIN_TIMEOUT creating_character");
    online_desconectar("No se confirmó la creación del personaje; volvé a iniciar sesión para verificarlo");
}
if (socket >= 0 && resync_requested && current_time - resync_started_at >= ONLINE_TIMEOUT_MS)
    online_solicitar_resync();
if (socket >= 0 && current_time - last_receive > ONLINE_TIMEOUT_MS) online_desconectar("El servidor dejó de responder");
if (connected && current_time - last_ping >= ONLINE_TIMEOUT_MS div 3) {
    last_ping = current_time;
    online_enviar({op: "ping"});
}
if (save_state == 1 && current_time - save_started_at >= ONLINE_TIMEOUT_MS)
    online_guardado_estado(4, "Guardado sin confirmar: el servidor no respondió");
if (test_role != "") online_prueba_step();
if (instance_exists(obj_pausa)) exit;
var _gx = device_mouse_x_to_gui(0), _gy = device_mouse_y_to_gui(0);
var _pressed = device_mouse_check_button_pressed(0, mb_left);
if (room == rm_menuPrincipal && !form_open) {
    if (_pressed && _gx > ONLINE_UI_RIGHT && _gy < ONLINE_UI_TOP) {
        if (authenticated) { online_desconectar("Sesión cerrada"); }
        form_open = true;
        status_text = "";
    }
}
if (form_open) {
    if (form_field >= 0) form_values[form_field] = string_copy(keyboard_string, 1, form_field == 3 ? 128 : 100);
    if (_pressed && _gx >= ONLINE_UI_LOCAL_BUTTON_X && _gx <= ONLINE_UI_RIGHT
        && _gy >= ONLINE_UI_TOP && _gy <= ONLINE_UI_TOP + ONLINE_UI_BUTTON_HEIGHT) {
        form_values[0] = ONLINE_LOCAL_HOST;
        form_values[1] = string(ONLINE_LOCAL_PORT);
        form_field = -1;
        keyboard_string = "";
        if (os_type == os_android || os_type == os_ios) keyboard_virtual_hide();
    }
    if (_pressed && _gx > ONLINE_UI_FIELD_LEFT && _gx < ONLINE_UI_RIGHT) {
        for (var _i = 0; _i < 4; _i++) {
            var _y = ONLINE_UI_TOP + ONLINE_UI_ROW * (_i + 1);
            if (_gy > _y && _gy < _y + ONLINE_UI_BUTTON_HEIGHT) {
                form_field = _i;
                keyboard_string = form_values[_i];
                if (os_type == os_android || os_type == os_ios)
                    keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
            }
        }
    }
    if (_pressed && _gy > ONLINE_UI_BUTTON_Y && _gy < ONLINE_UI_BUTTON_Y + ONLINE_UI_BUTTON_HEIGHT) {
        if (_gx > ONLINE_UI_LEFT && _gx < ONLINE_UI_FIELD_LEFT + ONLINE_UI_ROW) online_conectar(false);
        else if (_gx > ONLINE_UI_RIGHT - ONLINE_UI_FIELD_LEFT && _gx < ONLINE_UI_RIGHT) online_conectar(true);
    }
    if (_pressed && _gy > ONLINE_UI_CANCEL_Y && _gy < ONLINE_UI_CANCEL_Y + ONLINE_UI_BUTTON_HEIGHT) {
        form_open = false;
        form_field = -1;
        form_values[3] = "";
        keyboard_string = "";
        if (os_type == os_android || os_type == os_ios) keyboard_virtual_hide();
    }
}
if (global.online_modo && !connected && _pressed && _gy < ONLINE_UI_TOP) online_volver_menu();
