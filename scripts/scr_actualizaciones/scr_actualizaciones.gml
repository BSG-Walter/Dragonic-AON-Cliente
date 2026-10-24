function actualizacion_version_mayor(_publicada, _instalada) {
    _publicada = string_lower(string_trim(_publicada));
    _instalada = string_lower(string_trim(_instalada));
    if (string_char_at(_publicada, 1) == "v") _publicada = string_delete(_publicada, 1, 1);
    if (string_char_at(_instalada, 1) == "v") _instalada = string_delete(_instalada, 1, 1);

    var _nueva = string_split(_publicada, ".");
    var _actual = string_split(_instalada, ".");
    var _cantidad = max(array_length(_nueva), array_length(_actual));
    for (var _i = 0; _i < _cantidad; _i++) {
        var _a = _i < array_length(_nueva) ? _nueva[_i] : "0";
        var _b = _i < array_length(_actual) ? _actual[_i] : "0";
        if (_a == "" || _b == "" || string_digits(_a) != _a || string_digits(_b) != _b) return false;
        var _num_a = real(_a);
        var _num_b = real(_b);
        if (_num_a > _num_b) return true;
        if (_num_a < _num_b) return false;
    }
    return false;
}
