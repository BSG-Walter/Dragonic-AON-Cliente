/// @description  descripcionItem(item)
/// @param item
function descripcionItem(argument0) {
	datosItem = {};
	datosItem.desc = ""; // Descripción
	datosItem.precio = 0; // Precio

	if (argument0 >= 0 && argument0 <= 17) {
	    datosItem.desc = "Ataque: ";
	} else if ((argument0 >= 18 && argument0 <= 20) || argument0 == 140 || argument0 == 227) {
	    datosItem.desc = "Poder mágico: ";
	} else if ((argument0 >= 21 && argument0 <= 32) && argument0 != 28) {
	    datosItem.desc = "Ataque: ";
	} else if ((argument0 >= 33 && argument0 <= 95) || (argument0 >= 98 && argument0 <= 100) || (argument0 >= 164 && argument0 <= 211) || (argument0 >= 222 && argument0 <= 226) || (argument0 >= 212 && argument0 <= 216)) {
	    datosItem.desc = "Defensa: ";
	} else if (argument0 == 96 || argument0 == 97) {
	    datosItem.desc = "Defensa mágica: ";
	} else if (argument0 >= 101 && argument0 <= 115) {
	    datosItem.desc = "Puntos de hambre: ";
	} else if (argument0 >= 116 && argument0 <= 119) {
	    datosItem.desc = "Puntos de sed: ";
	} else if (argument0 >= 120 && argument0 <= 139) {
	    datosItem.desc = "Descripción detallada en manual";
	}

	switch (argument0) {
	    case 0:
	        datosItem.desc += "1/3"; // Descripción
	        datosItem.precio = 7; // Precio
	        break;
	    case 1:
	        datosItem.desc += "2/3"; // Descripción
	        datosItem.precio = 333; // Precio
	        break;
	    case 2:
	        datosItem.desc += "3/5"; // Descripción
	        datosItem.precio = 1333; // Precio
	        break;
	    case 3:
	        datosItem.desc += "4/6"; // Descripción
	        datosItem.precio = 667; // Precio
	        break;
	    case 4:
	        datosItem.desc += "6/8"; // Descripción
	        datosItem.precio = 2300; // Precio
	        break;
	    case 5:
	        datosItem.desc += "7/9"; // Descripción
	        datosItem.precio = 2133; // Precio
	        break;
	    case 6:
	        datosItem.desc += "8/10"; // Descripción
	        datosItem.precio = 4000; // Precio
	        break;
	    case 7:
	        datosItem.desc += "2/6"; // Descripción
	        datosItem.precio = 333; // Precio
	        break;
	    case 8:
	        datosItem.desc += "1/8"; // Descripción
	        datosItem.precio = 117; // Precio
	        break;
	    case 9:
	        datosItem.desc += "2/10"; // Descripción
	        datosItem.precio = 167; // Precio
	        break;
	    case 10:
	        datosItem.desc += "3/12"; // Descripción
	        datosItem.precio = 667; // Precio
	        break;
	    case 11:
	        datosItem.desc += "5/12"; // Descripción
	        datosItem.precio = 1667; // Precio
	        break;
	    case 12:
	        datosItem.desc += "5/16"; // Descripción
	        datosItem.precio = 2000; // Precio
	        break;
	    case 13:
	        datosItem.desc += "5/20"; // Descripción
	        datosItem.precio = 6667; // Precio
	        break;
	    case 14:
	        datosItem.desc += "8/14"; // Descripción
	        datosItem.precio = 6667; // Precio
	        break;
	    case 15:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 10000; // Precio
	        break;
	    case 16:
	        datosItem.desc += "17/20"; // Descripción
	        datosItem.precio = 11667; // Precio
	        break;
	    case 17:
	        datosItem.desc += "19/21"; // Descripción
	        datosItem.precio = 12000; // Precio
	        break;
	    case 18:
	        datosItem.desc += "1"; // Descripción
	        datosItem.precio = 600; // Precio
	        break;
	    case 19:
	        datosItem.desc += "2"; // Descripción
	        datosItem.precio = 1735; // Precio
	        break;
	    case 20:
	        datosItem.desc += "3"; // Descripción
	        datosItem.precio = 3333; // Precio
	        break;
	    case 21:
	        datosItem.desc += "1/5"; // Descripción
	        datosItem.precio = 200; // Precio
	        break;
	    case 22:
	        datosItem.desc += "3/8"; // Descripción
	        datosItem.precio = 800; // Precio
	        break;
	    case 23:
	        datosItem.desc += "4/10"; // Descripción
	        datosItem.precio = 1250; // Precio
	        break;
	    case 24:
	        datosItem.desc += "6/12"; // Descripción
	        datosItem.precio = 2666; // Precio
	        break;
	    case 25:
	        datosItem.desc += "9/12"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 26:
	        datosItem.desc += "8/13"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 27:
	        datosItem.desc += "8/15"; // Descripción
	        datosItem.precio = 3333; // Precio
	        break;
	    case 28:
	        datosItem.desc += "Necesaria para fabricar objetos de sastrería"; // Descripción
	        datosItem.precio = 30; // Precio
	        break;
	    case 29:
	        datosItem.desc += "1/2"; // Descripción
	        datosItem.precio = 2; // Precio
	        break;
	    case 30:
	        datosItem.desc += "3/4"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 31:
	        datosItem.desc += "5/6"; // Descripción
	        datosItem.precio = 4; // Precio
	        break;
	    case 32:
	        datosItem.desc += "7/8"; // Descripción
	        datosItem.precio = 5; // Precio
	        break;
	    case 217:
	        datosItem.desc += "Paraliza a la víctima"; // Descripción
	        datosItem.precio = 6; // Precio
	        break;
	    case 33:
	        datosItem.desc += "5/15"; // Descripción
	        datosItem.precio = 1200; // Precio
	        break;
	    case 34:
	        datosItem.desc += "5/15"; // Descripción
	        datosItem.precio = 1200; // Precio
	        break;
	    case 35:
	        datosItem.desc += "5/15"; // Descripción
	        datosItem.precio = 1200; // Precio
	        break;
	    case 36:
	        datosItem.desc += "5/15"; // Descripción
	        datosItem.precio = 1200; // Precio
	        break;
	    case 37:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 5333; // Precio
	        break;
	    case 38:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 5333; // Precio
	        break;
	    case 39:
	        datosItem.desc += "5/5"; // Descripción
	        datosItem.precio = 200; // Precio
	        break;
	    case 40:
	        datosItem.desc += "5/15"; // Descripción
	        datosItem.precio = 1200; // Precio
	        break;
	    case 41:
	        datosItem.desc += "25/30"; // Descripción
	        datosItem.precio = 10666; // Precio
	        break;
	    case 42:
	        datosItem.desc += "25/30"; // Descripción
	        datosItem.precio = 10666; // Precio
	        break;
	    case 43:
	        datosItem.desc += "20/25"; // Descripción
	        datosItem.precio = 10000; // Precio
	        break;
	    case 44:
	        datosItem.desc += "20/25"; // Descripción
	        datosItem.precio = 10000; // Precio
	        break;
	    case 45:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 46:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 47:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 48:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 49:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 50:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 51:
	        datosItem.desc += "3/3"; // Descripción
	        datosItem.precio = 200; // Precio
	        break;
	    case 52:
	        datosItem.desc += "5/5"; // Descripción
	        datosItem.precio = 433; // Precio
	        break;
	    case 53:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 200; // Precio
	        break;
	    case 54:
	        datosItem.desc += "5/5"; // Descripción
	        datosItem.precio = 266; // Precio
	        break;
	    case 55:
	        datosItem.desc += "5/10"; // Descripción
	        datosItem.precio = 666; // Precio
	        break;
	    case 56:
	        datosItem.desc += "5/10"; // Descripción
	        datosItem.precio = 666; // Precio
	        break;
	    case 57:
	        datosItem.desc += "5/8"; // Descripción
	        datosItem.precio = 666; // Precio
	        break;
	    case 58:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 59:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 60:
	        datosItem.desc += "5/10"; // Descripción
	        datosItem.precio = 700; // Precio
	        break;
	    case 61:
	        datosItem.desc += "15/25"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 62:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 666; // Precio
	        break;
	    case 63:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 2666; // Precio
	        break;
	    case 64:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 2666; // Precio
	        break;
	    case 65:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 2666; // Precio
	        break;
	    case 66:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 3333; // Precio
	        break;
	    case 67:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 3333; // Precio
	        break;
	    case 68:
	        datosItem.desc += "15/27 (Necesaria para soportar el frío)"; // Descripción
	        datosItem.precio = 3666; // Precio
	        break;
	    case 69:
	        datosItem.desc += "15/27 (Necesaria para soportar el frío)"; // Descripción
	        datosItem.precio = 3666; // Precio
	        break;
	    case 70:
	        datosItem.desc += "15/27 (Necesaria para soportar el frío)"; // Descripción
	        datosItem.precio = 3666; // Precio
	        break;
	    case 71:
	        datosItem.desc += "2/2"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 72:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 73:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 74:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 212:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 213:
	        datosItem.desc += "10/15"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 75:
	        datosItem.desc += "12/17"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 76:
	        datosItem.desc += "12/17"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 77:
	        datosItem.desc += "12/17"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 214:
	        datosItem.desc += "12/17"; // Descripción
	        datosItem.precio = 750; // Precio
	        break;
	    case 78:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 2000; // Precio
	        break;
	    case 79:
	        datosItem.desc += "10/25"; // Descripción
	        datosItem.precio = 2500; // Precio
	        break;
	    case 80:
	        datosItem.desc += "10/25"; // Descripción
	        datosItem.precio = 2500; // Precio
	        break;
	    case 81:
	        datosItem.desc += "10/27"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 82:
	        datosItem.desc += "12/25"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 216:
	        datosItem.desc += "12/25"; // Descripción
	        datosItem.precio = 3000; // Precio
	        break;
	    case 83:
	        datosItem.desc += "10/20"; // Descripción
	        datosItem.precio = 1700; // Precio
	        break;
	    case 84:
	        datosItem.desc += "10/20"; // Descripción
	        datosItem.precio = 1700; // Precio
	        break;
	    case 215:
	        datosItem.desc += "10/20"; // Descripción
	        datosItem.precio = 1700; // Precio
	        break;
	    case 85:
	        datosItem.desc += "8/12"; // Descripción
	        datosItem.precio = 400; // Precio
	        break;
	    case 86:
	        datosItem.desc += "25/30"; // Descripción
	        datosItem.precio = 8000; // Precio
	        break;
	    case 87:
	        datosItem.desc += "25/30"; // Descripción
	        datosItem.precio = 8000; // Precio
	        break;
	    case 88:
	        datosItem.desc += "25/30"; // Descripción
	        datosItem.precio = 8000; // Precio
	        break;
	    case 89:
	        datosItem.desc += "27/35"; // Descripción
	        datosItem.precio = 8333; // Precio
	        break;
	    case 90:
	        datosItem.desc += "27/35"; // Descripción
	        datosItem.precio = 8333; // Precio
	        break;
	    case 91:
	        datosItem.desc += "30/37"; // Descripción
	        datosItem.precio = 8666; // Precio
	        break;
	    case 92:
	        datosItem.desc += "35/40"; // Descripción
	        datosItem.precio = 9000; // Precio
	        break;
	    case 222:
	        datosItem.desc += "40/45"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    case 223:
	        datosItem.desc += "40/45"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    case 224:
	        datosItem.desc += "40/45"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    case 225:
	        datosItem.desc += "40/45"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    case 226:
	        datosItem.desc += "40/45"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    case 93:
	        datosItem.desc += "3/8"; // Descripción
	        datosItem.precio = 350; // Precio
	        break;
	    case 94:
	        datosItem.desc += "10/20"; // Descripción
	        datosItem.precio = 1333; // Precio
	        break;
	    case 95:
	        datosItem.desc += "20/25"; // Descripción
	        datosItem.precio = 3666; // Precio
	        break;
	    case 96:
	        datosItem.desc += "5/5"; // Descripción
	        datosItem.precio = 1333; // Precio
	        break;
	    case 97:
	        datosItem.desc += "15/20"; // Descripción
	        datosItem.precio = 3666; // Precio
	        break;
	    case 98:
	        datosItem.desc += "1/1"; // Descripción
	        datosItem.precio = 333; // Precio
	        break;
	    case 99:
	        datosItem.desc += "1/4"; // Descripción
	        datosItem.precio = 1333; // Precio
	        break;
	    case 100:
	        datosItem.desc += "4/8"; // Descripción
	        datosItem.precio = 4666; // Precio
	        break;
	    case 101:
	        datosItem.desc += "10"; // Descripción
	        datosItem.precio = 1; // Precio
	        break;
	    case 102:
	        datosItem.desc += "15"; // Descripción
	        datosItem.precio = 2; // Precio
	        break;
	    case 103:
	        datosItem.desc += "15"; // Descripción
	        datosItem.precio = 2; // Precio
	        break;
	    case 104:
	        datosItem.desc += "20"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 105:
	        datosItem.desc += "20"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 106:
	        datosItem.desc += "25"; // Descripción
	        datosItem.precio = 10; // Precio
	        break;
	    case 107:
	        datosItem.desc += "75"; // Descripción
	        datosItem.precio = 7; // Precio
	        break;
	    case 108:
	        datosItem.desc += "50"; // Descripción
	        datosItem.precio = 10; // Precio
	        break;
	    case 109:
	        datosItem.desc += "50"; // Descripción
	        datosItem.precio = 5; // Precio
	        break;
	    case 110:
	        datosItem.desc += "25"; // Descripción
	        datosItem.precio = 5; // Precio
	        break;
	    case 111:
	        datosItem.desc += "50"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 112:
	        datosItem.desc += "75"; // Descripción
	        datosItem.precio = 25; // Precio
	        break;
	    case 113:
	        datosItem.desc += "75"; // Descripción
	        datosItem.precio = 50; // Precio
	        break;
	    case 114:
	        datosItem.desc += "75"; // Descripción
	        datosItem.precio = 66; // Precio
	        break;
	    case 115:
	        datosItem.desc += "100"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 116:
	        datosItem.desc += "30"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 117:
	        datosItem.desc += "60"; // Descripción
	        datosItem.precio = 7; // Precio
	        break;
	    case 118:
	        datosItem.desc += "90"; // Descripción
	        datosItem.precio = 10; // Precio
	        break;
	    case 119:
	        datosItem.desc += "100"; // Descripción
	        datosItem.precio = 12; // Precio
	        break;
	    case 120:
	        datosItem.precio = 100; // Precio
	        break;
	    case 121:
	        datosItem.precio = 250; // Precio
	        break;
	    case 122:
	        datosItem.precio = 17500; // Precio
	        break;
	    case 123:
	        datosItem.precio = 16500; // Precio
	        break;
	    case 124:
	        datosItem.precio = 105000; // Precio
	        break;
	    case 125:
	        datosItem.precio = 250; // Precio
	        break;
	    case 126:
	        datosItem.precio = 1250; // Precio
	        break;
	    case 127:
	        datosItem.precio = 2250; // Precio
	        break;
	    case 128:
	        datosItem.precio = 4500; // Precio
	        break;
	    case 129:
	        datosItem.precio = 32000; // Precio
	        break;
	    case 130:
	        datosItem.precio = 600000; // Precio
	        break;
	    case 131:
	        datosItem.precio = 1200000; // Precio
	        break;
	    case 132:
	        datosItem.precio = 25000; // Precio
	        break;
	    case 133:
	        datosItem.precio = 35000; // Precio
	        break;
	    case 134:
	        datosItem.precio = 7000; // Precio
	        break;
	    case 135:
	        datosItem.precio = 10000; // Precio
	        break;
	    case 136:
	        datosItem.precio = 175000; // Precio
	        break;
	    case 137:
	        datosItem.precio = 750000; // Precio
	        break;
	    case 138:
	        datosItem.precio = 750000; // Precio
	        break;
	    case 139:
	        datosItem.precio = 500000; // Precio
	        break;
	    case 140:
	        datosItem.desc += "4"; // Descripción
	        datosItem.precio = 4333; // Precio
	        break;
	    case 227:
	        datosItem.desc += "3"; // Descripción
	        datosItem.precio = 3333; // Precio
	        break;
	    case 141:
	        datosItem.desc = "Restaura un 15% de vida"; // Descripción
	        datosItem.precio = 5; // Precio
	        break;
	    case 142:
	        datosItem.desc = "Restaura un 15% de maná"; // Descripción
	        datosItem.precio = 6; // Precio
	        break;
	    case 143:
	        datosItem.desc = "Cura el envenenamiento"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 218:
	        datosItem.desc = "Aumenta la agilidad temporalmente"; // Descripción
	        datosItem.precio = 20; // Precio
	        break;
	    case 219:
	        datosItem.desc = "Aumenta la fuerza temporalmente"; // Descripción
	        datosItem.precio = 40; // Precio
	        break;
	    case 220:
	        datosItem.desc = "Remueve la parálisis a costa de 1/3 de la vida actual"; // Descripción
	        datosItem.precio = 250; // Precio
	        break;
	    case 221:
	        datosItem.desc = "Te vuelve invisible dejándote casi agonizante"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 144:
	        datosItem.desc = "Necesaria para poder navegar"; // Descripción
	        datosItem.precio = 16666; // Precio
	        break;
	    case 145:
	        datosItem.desc = "Permite teletransportarte a tu hogar al morir"; // Descripción
	        datosItem.precio = 500; // Precio
	        break;
	    case 146:
	        datosItem.desc = "Necesaria para fabricar objetos de carpintería"; // Descripción
	        datosItem.precio = 1; // Precio
	        break;
	    case 147:
	        datosItem.desc = "Herramienta de trabajo para la tala"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 148:
	        datosItem.desc = "Necesarios para fabricar lingotes de hierro"; // Descripción
	        datosItem.precio = 2; // Precio
	        break;
	    case 149:
	        datosItem.desc = "Necesarios para fabricar lingotes de plata"; // Descripción
	        datosItem.precio = 3; // Precio
	        break;
	    case 150:
	        datosItem.desc = "Necesarios para fabricar lingotes de oro"; // Descripción
	        datosItem.precio = 4; // Precio
	        break;
	    case 151:
	        datosItem.desc = "Necesario para fabricar objetos de herrería"; // Descripción
	        datosItem.precio = 16; // Precio
	        break;
	    case 152:
	        datosItem.desc = "Necesario para fabricar objetos de herrería"; // Descripción
	        datosItem.precio = 54; // Precio
	        break;
	    case 153:
	        datosItem.desc = "Necesario para fabricar objetos de herrería"; // Descripción
	        datosItem.precio = 136; // Precio
	        break;
	    case 154:
	        datosItem.desc = "Herramienta de trabajo para la minería"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 155:
	        datosItem.desc = "Herramienta de trabajo para la pesca"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 156:
	        datosItem.desc = "Herramienta de trabajo para la pesca"; // Descripción
	        datosItem.precio = 250; // Precio
	        break;
	    case 157:
	        datosItem.desc = "Herramienta de trabajo para la carpintería"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 158:
	        datosItem.desc = "Herramienta de trabajo para la herrería"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 159:
	        datosItem.desc = "Herramienta de trabajo para la sastrería"; // Descripción
	        datosItem.precio = 100; // Precio
	        break;
	    case 160:
	        datosItem.desc = "Piel obtenida de un Oso Pardo"; // Descripción
	        datosItem.precio = 60; // Precio
	        break;
	    case 161:
	        datosItem.desc = "Piel obtenida de un Oso Polar"; // Descripción
	        datosItem.precio = 240; // Precio
	        break;
	    case 162:
	        datosItem.desc = "Piel obtenida de un Lobo Invernal"; // Descripción
	        datosItem.precio = 120; // Precio
	        break;
	    case 163:
	        datosItem.desc = "Restos del legendario dragón. Premiten fabricar objetos"; // Descripción
	        datosItem.precio = 500000; // Precio
	        break;
	    default:
        
	        var ar = argument0;

	        if (ar == 164 || ar == 165 || ar == 170 || ar == 171 || ar == 188 || ar == 189 || ar == 194 || ar == 195 || ar == 200 || ar == 201 || ar == 206 || ar == 207) {
	            datosItem.desc += "12/17 (No vendible)"
	        } else if (ar == 166 || ar == 167 || ar == 172 || ar == 173 || ar == 190 || ar == 191 || ar == 196 || ar == 197) {
	            datosItem.desc += "20/25 (No vendible)"
	        } else if (ar == 168 || ar == 169 || ar == 174 || ar == 175 || ar == 192 || ar == 193 || ar == 198 || ar == 199) {
	            datosItem.desc += "25/30 (No vendible)"
	        } else if (ar == 202 || ar == 203 || ar == 208 || ar == 209) {
	            datosItem.desc += "15/26 (No vendible)"
	        } else if (ar == 204 || ar == 205 || ar == 210 || ar == 211) {
	            datosItem.desc += "27/35 (No vendible)"
	        } else if (ar == 176 || ar == 177 || ar == 182 || ar == 183) {
	            datosItem.desc += "12/24 (No vendible)"
	        } else if (ar == 178 || ar == 179 || ar == 184 || ar == 185) {
	            datosItem.desc += "25/32 (No vendible)"
	        } else if (ar == 180 || ar == 181 || ar == 186 || ar == 187) {
	            datosItem.desc += "35/40 (No vendible)"
	        }
        
	        break;
	}

	return datosItem;




}
