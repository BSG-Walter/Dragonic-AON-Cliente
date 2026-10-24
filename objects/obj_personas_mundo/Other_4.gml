if (online_activo()) exit;
/// @description  Disparo la creación de IAs en mapa anterior

for (var i = 0; i < totalMultiIA; i++) {
    var _datos = globalIA[i];
    if (_datos.x != -1 && _datos.roomIA == room) {
        _datos.puedeCrear = true;
    }    
    globalIA[i] = _datos;
}

crea = false;
crearIADelMundo();
