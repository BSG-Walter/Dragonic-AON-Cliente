/// @description  actualizarCiudas()

if (!instance_exists(obj_personas_mundo)) return;

// Guardo los mapas en que hay PKs que esten inmo, que esten agitando y que esten en mapas distintos al actual

mapaConPKs[0] = -1;
mapaConPKs[1] = -1;
mapaConPKs[2] = -1;
mapaConPKs[3] = -1;

var contA = 0;
while (contA < obj_personas_mundo.totalMultiIA) {
    var _datos = obj_personas_mundo.globalIA[contA];
    if (_datos.x != -1 && _datos.pk && _datos.inmovilizado && _datos.agitando && _datos.roomIA != room) {
        var agrega = true;
        for (var contC = 0; contC < 4; contC++) {
            if (mapaConPKs[contC] == _datos.roomIA) {
                agrega = false;
                break;
            }
        }
        if (agrega) {
            for (var contC = 0; contC < 4; contC++) {
                if (mapaConPKs[contC] == -1) {
                    mapaConPKs[contC] = _datos.roomIA;
                    break;
                }
            }
        }
    }
    contA++;
}

// Actualizo los ciudadanos

contA = 0;
while (contA < obj_personas_mundo.totalMultiIA) {
    var _datos = obj_personas_mundo.globalIA[contA];
    if (_datos.x != -1 && !_datos.pk && _datos.agitando && _datos.roomIA != room && !_datos.sigueAlOtroMapa) {
        var actualiza = true;
        for (var contB = 0; contB < 4; contB++) {
            if (mapaConPKs[contB] == _datos.roomIA) {
                actualiza = false;
                break;
            }
        }
        if (actualiza) {
            _datos.sigueAlOtroMapa = true;
        }
    }
    obj_personas_mundo.globalIA[contA] = _datos;
    contA++;
}


