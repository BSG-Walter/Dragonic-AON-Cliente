/// @description  Estado inicial

image_speed = 0;
visible = true;

maximoInv = 20;

for (var i = 0; i < maximoInv; i++) {
    slots[i] = crearSlotInv(-1, 0, false);
}

var item = 0;



if (obj_pj.clase == 0 || obj_pj.clase == 3) {
	nroIndices = 9;
	vecIndices[0] = -1;
	vecIndices[1] = 21;
	vecIndices[2] = 30;
	vecIndices[3] = 101;
	vecIndices[4] = 116;
	vecIndices[5] = 141;
	vecIndices[6] = 142;
	vecIndices[7] = 143;
	vecIndices[8] = 145;	
} else {
	nroIndices = 8;
	vecIndices[0] = -1;
	vecIndices[1] = 0;
	vecIndices[2] = 101;
	vecIndices[3] = 116;
	vecIndices[4] = 141;
	vecIndices[5] = 142;
	vecIndices[6] = 143;
	vecIndices[7] = 145;
}


/// Selecciono la ropa según raza y género

if (obj_pj.genero == 0) {

    if (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1 || obj_pj.nroRaza == 2) {
        vecIndices[0] = 45;
    } else {
        vecIndices[0] = 49;
    }

} else {

    if (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1) {
        vecIndices[0] = 48;
    } else if (obj_pj.nroRaza == 2) {
        vecIndices[0] = 71;
    } else {
        vecIndices[0] = 50;
    }
    
}

// Cargo el inventario

for (var i = 0; i < nroIndices; i++) {
    
    item = vecIndices[i];
    var _cant = 1;

    if (item == 101 || item == 116) {
        _cant = 100;
    } else if (item == 141 || item == 142) {
        _cant = 150;
    } else if (item == 143) {
        _cant = 10;
    } else if (item == 30) {
		_cant = 100;
	}

    slots[i] = crearSlotInv(item, _cant, false);

}

// Control de drop

timerAcelerador = 1;
tirando = false;

// Item seleccionado

seleccionado = -1;
posSeleccionado = -1;

// Tira de a 1?

tiraDeA1 = false;

// Visto y equipo al PJ

obj_pj.desnudo = false;
obj_pj.ropaActual = slots[0].indice;
obj_pj.ropaEnInv = 0;
slots[0].equipado = true;

obj_pj.armaActual = slots[1].indice;
obj_pj.sprArma = obtenerSpriteArma(obj_pj.armaActual);
obj_pj.armaEnInv = 1;
slots[1].equipado = true;

if (obj_pj.clase == 0 || obj_pj.clase == 3) {
	obj_pj.flechaActual = slots[2].indice;
	obj_pj.flechaEnInv = 2;
	slots[2].equipado = true;
}

// Doble clic

dobleClic = false;
posDobleClic = -1;
deviceDC = -1;

// Tirar items

indiceTirarItems = 0;

i = 0;

repeat(maximoInv) {
    i++;
}

tileInvalido = false;
depth = DEPTH_PANEL
alarm[8] = SECOND;
