/// @description  guardarDatosIAEnGlobalIA()
function guardarDatosIAEnGlobalIA() {

	var _datos = datosIAVacio();

	_datos.x = x;
	_datos.y = y;
	_datos.enemigo = enemigo;
	_datos.direccion = direccion;
	_datos.yaHabloEnojado1 = yaHabloEnojado1;
	_datos.yaHabloEnojado2 = yaHabloEnojado2;
	_datos.yaHabloEnojado3 = yaHabloEnojado3;
	_datos.genero = genero;
	_datos.clase = clase;
	_datos.nroRaza = nroRaza;
	_datos.saludMax = saludMax;
	_datos.salud = salud;
	_datos.manaMax = manaMax;
	_datos.mana = mana;
	_datos.nombre = nombre;
	_datos.danoMeleeMin = danoMeleeMin;
	_datos.danoMeleeMax = danoMeleeMax;
	_datos.evasion = evasion;
	_datos.eqArma = eqArma;
	_datos.eqRopa = eqRopa;
	_datos.eqCascoGorro = eqCascoGorro;
	_datos.eqEscudo = eqEscudo;
	_datos.eqFlechas = eqFlechas;
	_datos.pk = pk;
	_datos.enBarca = enBarca;
	_datos.sprCabeza = sprCabeza;
	_datos.inmovilizado = inmovilizado;
	_datos.agitando = agitando;
	_datos.yaHablo = yaHablo;
	_datos.tiempoEnView = tiempoEnView;
	_datos.alarm4 = alarm[4];
	_datos.alarm8 = alarm[8];
	_datos.tiempoLejosPJ = tiempoLejosPJ;
	_datos.roomIA = room;
	_datos.alarm7 = alarm[7];
	_datos.sigueAlOtroMapa = true;
	_datos.rangoFaccion = rangoFaccion;

	var i = 0;
	while (i < obj_personas_mundo.totalMultiIA) {
	    var _slot = obj_personas_mundo.globalIA[i];
	    if (_slot.x == -1) {
	        break;
	    }
	    i++;
	}
	_datos.lugarEnGlobalIA = i;

	obj_personas_mundo.globalIA[i] = _datos;
	obj_personas_mundo.itemsGlobalIA[i] = inventario;

}
