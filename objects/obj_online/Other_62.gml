if (async_load[? "id"] != actualizacion_request) exit;
actualizacion_request = -1;
var _http_status = async_load[? "http_status"];
if (_http_status == 404) {
    actualizacion_estado = 1;
    exit;
}
if (async_load[? "status"] != 0 || _http_status != 200) {
    actualizacion_estado = 3;
    exit;
}

try {
    var _release = json_parse(async_load[? "result"]);
    if (!is_struct(_release) || !variable_struct_exists(_release, "tag_name")
        || !is_string(_release.tag_name)) {
        actualizacion_estado = 3;
        exit;
    }
    actualizacion_estado = 1;
    if (!actualizacion_version_mayor(_release.tag_name, CLIENT_VERSION)) exit;

    var _apk = "";
    if (variable_struct_exists(_release, "assets") && is_array(_release.assets)) {
        for (var _i = 0; _i < array_length(_release.assets); _i++) {
            var _asset = _release.assets[_i];
            if (!is_struct(_asset) || !variable_struct_exists(_asset, "name")
                || !variable_struct_exists(_asset, "browser_download_url")
                || !is_string(_asset.name) || !is_string(_asset.browser_download_url)) continue;
            var _name = string_lower(_asset.name);
            if (string_length(_name) >= 4
                && string_copy(_name, string_length(_name) - 3, 4) == ".apk") {
                _apk = _asset.browser_download_url;
                break;
            }
        }
    }

    actualizacion_version = _release.tag_name;
    actualizacion_es_apk = (_apk != "");
    actualizacion_url = actualizacion_es_apk ? _apk : ACTUALIZACIONES_WEB;
    actualizacion_estado = 2;
} catch (_error) {
    actualizacion_estado = 3;
    show_debug_message("No se pudo leer el release de GitHub: " + string(_error));
}