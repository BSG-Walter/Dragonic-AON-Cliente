
function partida_archivo_texto(_archivo) {
    if (!file_exists(_archivo)) return undefined;
    var _file = -1;
    try {
        _file = file_text_open_read(_archivo);
        if (_file < 0) return undefined;
        var _raw = "";
        while (!file_text_eof(_file)) {
            _raw += file_text_read_string(_file) + "\n";
            file_text_readln(_file);
        }
        file_text_close(_file);
        return _raw;
    } catch (_error) {
        if (_file >= 0) {
            try { file_text_close(_file); } catch (_close_error) {}
        }
        return undefined;
    }
}

function partida_texto(_archivo) {
    var _raw = partida_archivo_texto(_archivo);
    if (is_undefined(_raw)) return "";
    if (string_pos("[obj_pj]", _raw) > 0) return _raw;
    var _lines = string_split(_raw, "\n"), _decoded = "";
    for (var _i = 0; _i < array_length(_lines); _i++) {
        _decoded += base64_decode(_lines[_i]) + "\n";
    }
    return _decoded;
}

function partida_abrir(_archivo) {
    ini_open_from_string(partida_texto(_archivo));
}

function partida_temporal(_archivo, _extension) {
    static _suffix = string(get_timer()) + "_" + string(irandom(ONLINE_SAVE_NONCE_MAX));
    static _serial = 0;
    return _archivo + "_" + _suffix + "_" + string(_serial++) + _extension;
}

function partida_copiar_verificada(_origen, _destino) {
    var _contenido = partida_archivo_texto(_origen);
    if (is_undefined(_contenido)) return false;
    var _anterior = partida_archivo_texto(_destino);
    if (!is_undefined(_anterior) && _anterior == _contenido) return true;
    var _previous = _destino + ".previous";
    if (file_exists(_previous)) return false;
    var _checksum = _previous + ".sha1";
    var _resguardado = false;
    try {
        if (file_exists(_destino)) {
            if (is_undefined(_anterior)) return false;
            file_copy(_destino, _previous);
            if (partida_archivo_texto(_previous) != _anterior) return false;
            var _hash = sha1_string_utf8(_anterior) + "\n";
            if (!partida_archivo_escribir(_checksum, _hash)) return false;
            _resguardado = true;
            file_delete(_destino);
        }
        file_copy(_origen, _destino);
        if (partida_archivo_texto(_destino) == _contenido) {
            if (_resguardado) {
                file_delete(_checksum);
                if (file_exists(_checksum)) return false;
                file_delete(_previous);
            }
            return true;
        }
    } catch (_error) {}
    // El resguardo sobrevive si tampoco se puede restaurar el destino.
    if (_resguardado) {
        try {
            if (file_exists(_destino)) file_delete(_destino);
            file_copy(_previous, _destino);
            if (partida_archivo_texto(_destino) == _anterior) {
                file_delete(_checksum);
                if (!file_exists(_checksum)) file_delete(_previous);
            }
        } catch (_error) {}
    }
    return false;
}

function partida_archivo_escribir(_archivo, _contenido) {
    var _file = -1;
    try {
        _file = file_text_open_write(_archivo);
        if (_file < 0) return false;
        file_text_write_string(_file, _contenido);
        file_text_close(_file);
        _file = -1;
        return partida_archivo_texto(_archivo) == _contenido;
    } catch (_error) {
        if (_file >= 0) {
            try { file_text_close(_file); } catch (_close_error) {}
        }
        return false;
    }
}

function partida_restaurar_resguardo(_archivo) {
    var _previous = _archivo + ".previous";
    if (!file_exists(_previous)) return true;
    var _checksum = _previous + ".sha1";
    var _contenido = partida_archivo_texto(_previous);
    try {
        // Solo un resguardo completo puede reemplazar el destino al reiniciar.
        if (is_undefined(_contenido)
            || partida_archivo_texto(_checksum) != sha1_string_utf8(_contenido) + "\n") {
            if (is_undefined(partida_archivo_texto(_archivo))) return false;
        } else {
            if (partida_archivo_texto(_archivo) != _contenido) {
                if (file_exists(_archivo)) file_delete(_archivo);
                file_copy(_previous, _archivo);
            }
            if (partida_archivo_texto(_archivo) != _contenido) return false;
        }
        if (file_exists(_checksum)) file_delete(_checksum);
        if (file_exists(_checksum)) return false;
        file_delete(_previous);
        return !file_exists(_previous);
    } catch (_error) {
        return false;
    }
}

function partida_escribir(_archivo, _contenido) {
    var _backup = string_replace(_archivo, ".ini", "_BackUp.ini");
    if (!partida_restaurar_resguardo(_backup) || !partida_restaurar_resguardo(_archivo)) return false;
    var _temporary = partida_temporal(_archivo, ".tmp");
    var _lines = string_split(string_replace_all(_contenido, "\r", ""), "\n");
    var _esperado = "", _file = -1;
    try {
        _file = file_text_open_write(_temporary);
        if (_file < 0) return false;
        for (var _i = 0; _i < array_length(_lines); _i++) {
            var _line = base64_encode(_lines[_i]);
            file_text_write_string(_file, _line);
            file_text_writeln(_file);
            _esperado += _line + "\n";
        }
        file_text_close(_file);
        _file = -1;
        if (partida_archivo_texto(_temporary) != _esperado) return false;
        // Un archivo ilegible nunca reemplaza un respaldo recuperable.
        if (partidaLegible(_archivo, true)) {
            if (!partida_copiar_verificada(_archivo, _backup)) return false;
        }
        if (!partida_copiar_verificada(_temporary, _archivo)) return false;
        file_delete(_temporary);
        return partida_archivo_texto(_archivo) == _esperado;
    } catch (_error) {
        if (_file >= 0) {
            try { file_text_close(_file); } catch (_close_error) {}
        }
        return false;
    }
}
