/// @description  enlistarseEnFaccion()
function enlistarseEnFaccion() {

	var mensaje = "";

	var primerRango = 50;
	var segundoRango = 100;
	var tercerRango = 200;

	var valido = false;
	var posInv = -1;
	var indiceItem = -1;

	for (var i = 0; i < obj_inventario.maximoInv; i++) {           
	    if (obj_inventario.slots[i].indice == -1) {
	        posInv = i;
	        break;
	    }                 
	}

	if (pk) {
	    switch (rangoFaccion) {
	        case 0:
	            if (ciudadanosMatados >= primerRango) {
	                valido = true;
	            }           
	            break;
	        case 1:
	            if (ciudadanosMatados >= segundoRango) {
	                valido = true;
	            }           
	            break;
	        case 2:
	            if (ciudadanosMatados >= tercerRango) {
	                valido = true;
	            }           
	            break;
	        default:
	            mensaje = "¡Ja! Ambicioso súbdito, tu rango en la Legión Oscura es el máximo"; // Rango máximo
	            break;
	    }
	    if (valido) {
	        if (posInv != -1) {
	            if (!esLegion) {
	                esLegion = true;
	            }
	            rangoFaccion++;
	            if (rangoFaccion == 1) {
	                mensaje = "¡Fiel súbdito! Has jurado lealtad a la Legión Oscura";
	            } else {
	                mensaje = "¡Fiel súbdito! Has subido de rango en la Legión Oscura";
	            }
	            indiceItem = elegirItemFaccion();
	        } else {
	            mensaje = "No tienes lugar en tu inventario. No puedo entregarte tu vestimenta..."; // No hay lugar en inventario
	        }
	    } else {
	        if (rangoFaccion == 0) {
	            mensaje = "¡Escoria! Ve a cumplir con mi voluntad. Debes asesinar a al menos 50 ciudadanos para ingresar a la Legión Oscura";
	        } else if (rangoFaccion == 1) {
	            mensaje = "¡Escoria! Ve a cumplir con mi voluntad. Debes asesinar a al menos 100 ciudadanos para subir de rango";
	        } else if (rangoFaccion == 2) {
	            mensaje = "¡Escoria! Ve a cumplir con mi voluntad. Debes asesinar a al menos 200 ciudadanos para subir de rango";
	        }
	    }
	} else {
	    switch (rangoFaccion) {
	        case 0:
	            if (criminalesMatados >= primerRango) {
	                valido = true;
	            }           
	            break;
	        case 1:
	            if (criminalesMatados >= segundoRango) {
	                valido = true;
	            }           
	            break;
	        case 2:
	            if (criminalesMatados >= tercerRango) {
	                valido = true;
	            }           
	            break;
	        default:
	            mensaje = "¡Felicitaciones! Tu rango en la Armada Imperial es el máximo"; // Rango máximo
	            break;
	    }
	    if (valido) {
	        if (posInv != -1) {
	            if (!esArmada) {
	                esArmada = true;
	            }
	            rangoFaccion++;
	            if (rangoFaccion == 1) {
	                mensaje = "¡Fiel Noble! Has jurado lealtad a la Armada Imperial";
	            } else {
	                mensaje = "¡Fiel Noble! Has subido de rango en la Armada Imperial";
	            }
	            indiceItem = elegirItemFaccion();
	        } else {
	            mensaje = "No tienes lugar en tu inventario. No puedo entregarte tu vestimenta..."; // No hay lugar en inventario
	        }
	    } else {
	        if (rangoFaccion == 0) {
	            mensaje = "Noble... debes matar a al menos 50 criminales para ingresar a la Armada Imperial";
	        } else if (rangoFaccion == 1) {
	            mensaje = "Noble... debes matar a al menos 100 criminales para subir de rango";
	        } else if (rangoFaccion == 2) {
	            mensaje = "Noble... debes matar a al menos 200 criminales para subir de rango";
	        }
	    }
	}

	if (posInv != -1) {

	    // Carga ítem
	    
	    obj_inventario.slots[posInv] = crearSlotInv(indiceItem, 1, false);
    
	}

	return mensaje;





}
