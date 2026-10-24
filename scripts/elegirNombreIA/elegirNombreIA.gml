/// @description  elegirNombreIA()
function elegirNombreIA() {
    static names = -1;
    static idx = 0;

    // Carga inicial de nombres
    if (names == -1) {
        if (!file_exists("nombresIA.ini")) {
            crearArchivoNombresIA();
        }
        ini_open("nombresIA.ini");
        names = array_create(0);
        for (var i = 0; i < 120; i++) {
            var _n = readS("nombresIA", "nombresIA[" + string(i) + ", 0]", "");
            if (_n == "" || _n == "Bot") continue;
            var _sprName = readS("nombresIA", "nombresIA[" + string(i) + ", 1]", "");
            var _spr = asset_get_index(_sprName);
            if (_spr == -1) continue;
            var _cl = read("nombresIA", "nombresIA[" + string(i) + ", 2]", -1);
            var _pk = read("nombresIA", "nombresIA[" + string(i) + ", 3]", false);
            var _s = {
                nombre: _n,
                cabeza: _spr,
                clase: _cl,
                pk: _pk
            };
            array_push(names, _s);
        }
        ini_close();

        names = array_shuffle(names);
        idx = 0;
    }

    // Si se agotan los nombres, se vuelve a mezclar
    if (idx >= array_length(names)) {
        names = array_shuffle(names);
        idx = 0;
    }

    var _struct = names[idx];
    idx++;

    return _struct.nombre;
}
