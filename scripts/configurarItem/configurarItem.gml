
/// @description Color del nombre del ítem en la tienda según si el personaje puede usarlo
/// @param indiceItem
function colorUsoItem(argument0) {
    if (argument0 == -1) {
        return c_white;
    }
    var _datos = configurarItem(argument0);
    var _razaOk = (_datos.raza == -1 || _datos.raza == obj_pj.nroRaza);
    if (!_razaOk) {
        switch (_datos.raza) {
            case 5:
                _razaOk = (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1 || obj_pj.nroRaza == 2);
                break;
            case 6:
                _razaOk = (obj_pj.nroRaza == 3 || obj_pj.nroRaza == 4);
                break;
            case 7:
                _razaOk = (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 1);
                break;
            case 8:
                _razaOk = (obj_pj.nroRaza == 1 || obj_pj.nroRaza == 2);
                break;
            case 9:
                _razaOk = (obj_pj.nroRaza == 0 || obj_pj.nroRaza == 3 || obj_pj.nroRaza == 4);
                break;
            case 10:
                _razaOk = (obj_pj.nroRaza != 2);
                break;
        }
    }
    if (!_razaOk) {
        return c_red;
    }
    if (_datos.genero != -1 && _datos.genero != obj_pj.genero) {
        return c_red;
    }
    if (obj_pj.clase < 0 || obj_pj.clase > 8 || !_datos.clases[obj_pj.clase]) {
        return c_red;
    }
    if (obj_pj.skills[_datos.nroSkill] < _datos.skillReq) {
        return c_orange;
    }
    if (_datos.tipo == "barca" && obj_pj.nivel < NIVEL_MIN_BARCA) {
        return c_orange;
    }
    return c_white;
}

/// @description  configurarItem(indiceItem)
/// @param indiceItem
function configurarItem(argument0) {

	/*

	Razas:

	Indistinto = -1;
	Humanos = 0;
	Elfos = 1;
	EO = 2;
	Enanos = 3;
	Gnomos = 4;
	Altos = 5;
	Bajos = 6;
	Altos blancos = 7;
	Elfos / EOs = 8;
	Humanos y Bajos = 9;
	Todos menos EO = 10;

	Generos:

	Indistinto: -1
	Hombre: 0
	Mujer: 1

	*/

	datosItem = {};
	datosItem.tipo = ""; // Tipo
	datosItem.genero = -1; // Género
	datosItem.raza = -1; // Raza
	datosItem.nroSkill = 0; // Nro Skill
	datosItem.skillReq = 0; // Skillpoints requeridos
	datosItem.clases = [true, true, true, true, true, true, true, true, true]; // Clases 0..8
	datosItem.nombre = "Vacío"; // Nombre

	switch (argument0) {
        
	    // Armas (Cuerpo a cuerpo, báculos, arcos)
    
	    case 0:
	        datosItem.nombre = "Daga";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 4;
	        break;
	    case 1:
	        datosItem.nombre = "Daga +1";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 20;
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 2:
	        datosItem.nombre = "Daga +2";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 35;
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 3:
	        datosItem.nombre = "Daga +3";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 50;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 4:
	        datosItem.nombre = "Daga +4";
	        datosItem.tipo = "arma";
	        datosItem.raza = 9;
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 55;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 5:
	        datosItem.nombre = "Daga Templaria";
	        datosItem.tipo = "arma";
	        datosItem.raza = 8;
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 80;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 6:
	        datosItem.nombre = "Daga Infernal";
	        datosItem.tipo = "arma";
	        datosItem.raza = 8;
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 87;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 7:
	        datosItem.nombre = "Espada Corta";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 4;
	        datosItem.skillReq = 15;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 8:
	        datosItem.nombre = "Espada Larga";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 10;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 9:
	        datosItem.nombre = "Hacha Orca";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 20;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 10:
	        datosItem.nombre = "Hacha Larga";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 25;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 11:
	        datosItem.nombre = "Sable";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 37;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 12:
	        datosItem.nombre = "Hacha Bárbara";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 37;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 13:
	        datosItem.nombre = "Hacha Doble Filo";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 60;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 14:
	        datosItem.nombre = "Cimitarra";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 55;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 15:
	        datosItem.nombre = "Espada de Plata";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 70;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 16:
	        datosItem.nombre = "Espada de Plata +1";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 83;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 17:
	        datosItem.nombre = "Espada Neithan";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 2;
	        datosItem.skillReq = 97;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 18:
	        datosItem.nombre = "Vara de Fresno";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 0;
	        datosItem.skillReq = 50;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 19:
	        datosItem.nombre = "Bastón Nudoso";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 0;
	        datosItem.skillReq = 60;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 20:
	        datosItem.nombre = "Báculo Engarzado";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 0;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 227:
	        datosItem.nombre = "Báculo Delideral";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 0;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 21:
	        datosItem.nombre = "Arco Simple";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 12;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 22:
	        datosItem.nombre = "Arco Simple Reforzado";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 30;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 23:
	        datosItem.nombre = "Arco Compuesto";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 60;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 24:
	        datosItem.nombre = "Arco de las Tinieblas";
	        datosItem.tipo = "arma";
	        datosItem.raza = 8;
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 70;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 25:
	        datosItem.nombre = "Arco de la Marca";
	        datosItem.tipo = "arma";
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 90;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 26:
	        datosItem.nombre = "Arco Largo Engarzado";
	        datosItem.tipo = "arma";
	        datosItem.raza = 7;
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 90;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 27:
	        datosItem.nombre = "Arco Élfico";
	        datosItem.tipo = "arma";
	        datosItem.raza = 1;
	        datosItem.nroSkill = 12;
	        datosItem.skillReq = 100;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Piel de lobo y flechas
        
	    case 28:
	        datosItem.nombre = "Piel de Lobo";
	        datosItem.tipo = "recogible";
	        break;
	    case 29:
	        datosItem.nombre = "Flecha";
	        datosItem.tipo = "flecha";
	        break;
	    case 30:
	        datosItem.nombre = "Flecha +1";
	        datosItem.tipo = "flecha";
	        break;
	    case 31:
	        datosItem.nombre = "Flecha +2";
	        datosItem.tipo = "flecha";
	        break;
	    case 32:
	        datosItem.nombre = "Flecha Incendiaria";
	        datosItem.tipo = "flecha";
	        break;
	    case 217:
	        datosItem.nombre = "Flecha Paralizante";
	        datosItem.tipo = "flecha";
	        break;
        
	    // Túnicas, ropas y armaduras
        
	    case 33:
	        datosItem.nombre = "Túnica Roja";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 34:
	        datosItem.nombre = "Túnica Roja (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 35:
	        datosItem.nombre = "Túnica de Monje";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 36:
	        datosItem.nombre = "Túnica de Mago";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 37:
	        datosItem.nombre = "Túnica Morghai";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 53;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 38:
	        datosItem.nombre = "Túnica Morghai (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 53;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 39:
	        datosItem.nombre = "Túnica de la Cruz";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        break;
	    case 40:
	        datosItem.nombre = "Túnica Azul";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 41:
	        datosItem.nombre = "Túnica Legendaria";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 85;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 42:
	        datosItem.nombre = "Túnica Legendaria (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 85;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 43:
	        datosItem.nombre = "Túnica de Druida";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 44:
	        datosItem.nombre = "Túnica de Druida (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 45:
	        datosItem.nombre = "Ropa Común";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        break;
	    case 46:
	        datosItem.nombre = "Ropa Común";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        break;
	    case 47:
	        datosItem.nombre = "Ropa Común";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        break;
	    case 48:
	        datosItem.nombre = "Ropa Común (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        break;
	    case 49:
	        datosItem.nombre = "Ropa Común (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        break;
	    case 50:
	        datosItem.nombre = "Ropa Común (M-E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        break;
	    case 51:
	        datosItem.nombre = "Ropa de Clan (H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        break;
	    case 52:
	        datosItem.nombre = "Vestido Azul (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        break;
	    case 53:
	        datosItem.nombre = "Ropa de Pordiosero (H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        break;
	    case 54:
	        datosItem.nombre = "Ropa de Obispo";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        break;
	    case 55:
	        datosItem.nombre = "Ropa de Campesino";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 25;
	        break;
	    case 56:
	        datosItem.nombre = "Ropa de Campesino (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 25;
	        break;
	    case 57:
	        datosItem.nombre = "Ropa de Carpintero";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        break;
	    case 58:
	        datosItem.nombre = "Ropa de Minero";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 43;
	        break;
	    case 59:
	        datosItem.nombre = "Ropa de Minero (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 43;
	        break;
	    case 60:
	        datosItem.nombre = "Vestido Negro (M-E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        break;
	    case 61:
	        datosItem.nombre = "Vestido Indulgente (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        break;
	    case 62:
	        datosItem.nombre = "Ropa Estuario (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 25;
	        break;
	    case 63:
	        datosItem.nombre = "White Lady (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 37;
	        break;
	    case 64:
	        datosItem.nombre = "Vestido de Novia Sensual (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        break;
	    case 65:
	        datosItem.nombre = "Vestido de Novia Sensual (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        break;
	    case 66:
	        datosItem.nombre = "Vestido de Bruja (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 67:
	        datosItem.nombre = "Vestido de Bruja (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 68:
	        datosItem.nombre = "Ropa Invernal";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        break;
	    case 69:
	        datosItem.nombre = "Ropa Invernal (M)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        break;
	    case 70:
	        datosItem.nombre = "Ropa Invernal (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 45;
	        break;
	    case 71:
	        datosItem.nombre = "Ropa Común (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        break;
	    case 72:
	        datosItem.nombre = "Armadura de Cuero (H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 20;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 73:
	        datosItem.nombre = "Armadura de Cuero (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 20;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 74:
	        datosItem.nombre = "Armadura de Cuero (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 20;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 75:
	        datosItem.nombre = "Cota de Mallas";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 30;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 76:
	        datosItem.nombre = "Cota de Mallas (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 30;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 77:
	        datosItem.nombre = "Cota de Mallas (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 30;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 78:
	        datosItem.nombre = "Armadura de las Sombras";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 60;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 79:
	        datosItem.nombre = "Armadura de Placas";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 80:
	        datosItem.nombre = "Armadura de Placas (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 81:
	        datosItem.nombre = "Armadura de Placas Azul (M)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 75;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 82:
	        datosItem.nombre = "Armadura de Placas Roja (M-H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 75;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 83:
	        datosItem.nombre = "Armadura de Cazador (H/E)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 84:
	        datosItem.nombre = "Armadura de Cazador (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 85:
	        datosItem.nombre = "Armadura de Herrero";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 0;
	        break;
	    case 86:
	        datosItem.nombre = "Armadura de la Ciénaga";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 80;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 87:
	        datosItem.nombre = "Trampa Visual (M-E/H)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 7;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 75;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 88:
	        datosItem.nombre = "Armadura de Placas +1";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 80;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 89:
	        datosItem.nombre = "Armadura Bruñida";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 85;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 90:
	        datosItem.nombre = "Armadura de Placas +2";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 85;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 91:
	        datosItem.nombre = "Armadura Escarlata";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 92:
	        datosItem.nombre = "Armadura Legendaria";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 212:
	        datosItem.nombre = "Armadura de Cuero (EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 20;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 213:
	        datosItem.nombre = "Armadura de Cuero (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 20;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 214:
	        datosItem.nombre = "Cota de Mallas (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 30;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 215:
	        datosItem.nombre = "Armadura de Cazador (EO)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 63;
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 216:
	        datosItem.nombre = "Armadura de Placas Roja (M-EO)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 2;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 75;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 222:
	        datosItem.nombre = "Armadura Dragonic";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 0;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 223:
	        datosItem.nombre = "Armadura Dragonic (M)";
	        datosItem.tipo = "ropa";
	        datosItem.genero = 1;
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 224:
	        datosItem.nombre = "Armadura Dragonic (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 225:
	        datosItem.nombre = "Túnica Dragonic";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 226:
	        datosItem.nombre = "Túnica Dragonic (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Cascos y gorros
    
	    case 93:
	        datosItem.nombre = "Casco de Hierro";
	        datosItem.tipo = "casco";
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 15;
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 94:
	        datosItem.nombre = "Casco de Hierro Completo";
	        datosItem.tipo = "casco";
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 70;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 95:
	        datosItem.nombre = "Casco de Plata";
	        datosItem.tipo = "casco";
	        datosItem.nroSkill = 1;
	        datosItem.skillReq = 80;
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 96:
	        datosItem.nombre = "Sombrero de Principiante";
	        datosItem.tipo = "casco";
	        datosItem.nroSkill = 17;
	        datosItem.skillReq = 50;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 97:
	        datosItem.nombre = "Sombrero de Hechicero";
	        datosItem.tipo = "casco";
	        datosItem.nroSkill = 17;
	        datosItem.skillReq = 100;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Escudos
    
	    case 98:
	        datosItem.nombre = "Escudo de Tortuga";
	        datosItem.tipo = "escudo";
	        datosItem.nroSkill = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 99:
	        datosItem.nombre = "Escudo de Hierro";
	        datosItem.tipo = "escudo";
	        datosItem.nroSkill = 6;
	        datosItem.skillReq = 50;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
	    case 100:
	        datosItem.nombre = "Escudo Imperial";
	        datosItem.tipo = "escudo";
	        datosItem.nroSkill = 6;
	        datosItem.skillReq = 63;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        break;
        
	    // Comida
    
	    case 101:
	        datosItem.nombre = "Manzana";
	        datosItem.tipo = "comida";
	        break;
	    case 102:
	        datosItem.nombre = "Porción de Tarta";
	        datosItem.tipo = "comida";
	        break;
	    case 103:
	        datosItem.nombre = "Frutas del Bosque";
	        datosItem.tipo = "comida";
	        break;
	    case 104:
	        datosItem.nombre = "Pan de Trigo";
	        datosItem.tipo = "comida";
	        break;
	    case 105:
	        datosItem.nombre = "Pan de Maíz";
	        datosItem.tipo = "comida";
	        break;
	    case 106:
	        datosItem.nombre = "Pastel";
	        datosItem.tipo = "comida";
	        break;
	    case 107:
	        datosItem.nombre = "Pollo";
	        datosItem.tipo = "comida";
	        break;
	    case 108:
	        datosItem.nombre = "Chuleta";
	        datosItem.tipo = "comida";
	        break;
	    case 109:
	        datosItem.nombre = "Queso de Cabra";
	        datosItem.tipo = "comida";
	        break;
	    case 110:
	        datosItem.nombre = "Sandía";
	        datosItem.tipo = "comida";
	        break;
	    case 111:
	        datosItem.nombre = "Merluza";
	        datosItem.tipo = "comida";
	        break;
	    case 112:
	        datosItem.nombre = "Pejerrey";
	        datosItem.tipo = "comida";
	        break;
	    case 113:
	        datosItem.nombre = "Pez Espada";
	        datosItem.tipo = "comida";
	        break;
	    case 114:
	        datosItem.nombre = "Salmón";
	        datosItem.tipo = "comida";
	        break;
	    case 115:
	        datosItem.nombre = "Caballito de Mar";
	        datosItem.tipo = "comida";
	        break;
        
	    // Bebida
    
	    case 116:
	        datosItem.nombre = "Agua";
	        datosItem.tipo = "bebida";
	        break;
	    case 117:
	        datosItem.nombre = "Cerveza";
	        datosItem.tipo = "bebida";
	        break;
	    case 118:
	        datosItem.nombre = "Vino";
	        datosItem.tipo = "bebida";
	        break;
	    case 119:
	        datosItem.nombre = "Jugo de Frutas";
	        datosItem.tipo = "bebida";
	        break;
        
	    // Hechizos
    
	    case 120:
	        datosItem.nombre = "Curar Veneno";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 121:
	        datosItem.nombre = "Curar Heridas Leves";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 122:
	        datosItem.nombre = "Curar Heridas Graves";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 123:
	        datosItem.nombre = "Remover Parálisis";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 124:
	        datosItem.nombre = "Invisibilidad";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 125:
	        datosItem.nombre = "Dardo Mágico";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 126:
	        datosItem.nombre = "Flecha Mágica";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 127:
	        datosItem.nombre = "Flecha Eléctrica";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 128:
	        datosItem.nombre = "Misil Mágico";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 129:
	        datosItem.nombre = "Tormenta de Fuego";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 130:
	        datosItem.nombre = "Descarga Eléctrica";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 131:
	        datosItem.nombre = "Apocalipsis";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 132:
	        datosItem.nombre = "Paralizar";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 133:
	        datosItem.nombre = "Inmovilizar";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 134:
	        datosItem.nombre = "Llamado a la Naturaleza";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 135:
	        datosItem.nombre = "Invocar Zombies";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 136:
	        datosItem.nombre = "Invocar Elemental de Agua";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        break;
	    case 137:
	        datosItem.nombre = "Invocar Elemental de Tierra";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 138:
	        datosItem.nombre = "Invocar Elemental de Fuego";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 139:
	        datosItem.nombre = "Invocar Mascotas";
	        datosItem.tipo = "hechizo";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Laúd
        
	    case 140:
	        datosItem.nombre = "Laúd";
	        datosItem.tipo = "laud";
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Pociones
        
	    case 141:
	        datosItem.nombre = "Poción Roja";
	        datosItem.tipo = "pocion";
	        break;
	    case 142:
	        datosItem.nombre = "Poción Azul";
	        datosItem.tipo = "pocion";
	        break; 
	    case 143:
	        datosItem.nombre = "Poción Violeta";
	        datosItem.tipo = "pocion";
	        break;
	    case 218:
	        datosItem.nombre = "Poción Amarilla";
	        datosItem.tipo = "pocion";
	        break;
	    case 219:
	        datosItem.nombre = "Poción Verde";
	        datosItem.tipo = "pocion";
	        break;
	    case 220:
	        datosItem.nombre = "Poción Nerga";
	        datosItem.tipo = "pocion";
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 221:
	        datosItem.nombre = "Poción Blanca";
	        datosItem.tipo = "pocion";
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[2] = false; // Clase 2 Bardo
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[4] = false; // Clase 4 Clérigo
	        datosItem.clases[5] = false; // Clase 5 Druida
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
        
	    // Barca
    
	    case 144:
	        datosItem.nombre = "Barca";
	        datosItem.tipo = "barca";
	        datosItem.nroSkill = 14;
	        datosItem.skillReq = 70;
	        break;
        
	    // Runa
    
	    case 145:
	        datosItem.nombre = "Runa de Resurrección";
	        datosItem.tipo = "runa";
	        break;
        
	    // Trabajos
    
	    case 146:
	        datosItem.nombre = "Leña";
	        datosItem.tipo = "lena";
	        break;
	    case 147:
	        datosItem.nombre = "Hacha de Talador";
	        datosItem.tipo = "trabajo";
	        break;
	    case 148:
	        datosItem.nombre = "Minerales de Hierro";
	        datosItem.tipo = "mineral";
	        break;
	    case 149:
	        datosItem.nombre = "Minerales de Plata";
	        datosItem.tipo = "mineral";
	        break;
	    case 150:
	        datosItem.nombre = "Minerales de Oro";
	        datosItem.tipo = "mineral";
	        break;
	    case 151:
	        datosItem.nombre = "Lingote de Hierro";
	        datosItem.tipo = "lingote";
	        break;
	    case 152:
	        datosItem.nombre = "Lingote de Plata";
	        datosItem.tipo = "lingote";
	        break;
	    case 153:
	        datosItem.nombre = "Lingote de Oro";
	        datosItem.tipo = "lingote";
	        break;
	    case 154:
	        datosItem.nombre = "Piquete de Minero";
	        datosItem.tipo = "trabajo";
	        break;
	    case 155:
	        datosItem.nombre = "Caña de Pesca";
	        datosItem.tipo = "trabajo";
	        break;
	    case 156:
	        datosItem.nombre = "Red de Pesca";
	        datosItem.tipo = "trabajo";
	        datosItem.nroSkill = 7;
	        datosItem.skillReq = 100;
	        break;
	    case 157:
	        datosItem.nombre = "Serrucho de Carpintero";
	        datosItem.tipo = "trabajo";
	        break;
	    case 158:
	        datosItem.nombre = "Martillo de Herrero";
	        datosItem.tipo = "trabajo";
	        break;
	    case 159:
	        datosItem.nombre = "Costurero";
	        datosItem.tipo = "trabajo";
	        break;
	    case 160:
	        datosItem.nombre = "Piel de Oso Pardo";
	        datosItem.tipo = "recogible";
	        break;
	    case 161:
	        datosItem.nombre = "Piel de Oso Polar";
	        datosItem.tipo = "recogible";
	        break;
	    case 162:
	        datosItem.nombre = "Piel de Lobo Invernal";
	        datosItem.tipo = "recogible";
	        break;
	    case 163:
	        datosItem.nombre = "Escamas de Dragonic";
	        datosItem.tipo = "recogible";
	        break;
        
	    // Bardos, Druidas y Clérigos

	    case 164:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 165:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 166:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 167:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 168:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 169:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 170:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 171:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 172:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 173:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 174:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
	    case 175:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = false; // Clase 0 Arquero
	        datosItem.clases[1] = false; // Clase 1 Asesino
	        datosItem.clases[3] = false; // Clase 3 Cazador
	        datosItem.clases[6] = false; // Clase 6 Guerrero
	        datosItem.clases[7] = false; // Clase 7 Mago
	        datosItem.clases[8] = false; // Clase 8 Paladín
	        break;
    
	    // Guerreros y Arqueros
    
	    case 176:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 177:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 178:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 179:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 180:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 181:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 182:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 183:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 184:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 185:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 186:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 187:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[7] = true; // Clase 7 Mago
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
    
	    // Magos
    
	    case 188:
	        datosItem.nombre = "Túnica Imperial 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 189:
	        datosItem.nombre = "Túnica Imperial 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 190:
	        datosItem.nombre = "Túnica Imperial 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 191:
	        datosItem.nombre = "Túnica Imperial 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 192:
	        datosItem.nombre = "Túnica Imperial 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 193:
	        datosItem.nombre = "Túnica Imperial 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 194:
	        datosItem.nombre = "Túnica Legionaria 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 195:
	        datosItem.nombre = "Túnica Legionaria 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 196:
	        datosItem.nombre = "Túnica Legionaria 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 197:
	        datosItem.nombre = "Túnica Legionaria 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 198:
	        datosItem.nombre = "Túnica Legionaria 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
	    case 199:
	        datosItem.nombre = "Túnica Legionaria 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[1] = true; // Clase 1 Asesino
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[3] = true; // Clase 3 Cazador
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[8] = true; // Clase 8 Paladín
	        break;
    
	    // Paladines, Cazadores y Asesinos
    
	    case 200:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 201:
	        datosItem.nombre = "Armadura Imperial 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 202:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 203:
	        datosItem.nombre = "Armadura Imperial 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 204:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 205:
	        datosItem.nombre = "Armadura Imperial 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 206:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 207:
	        datosItem.nombre = "Armadura Legionaria 3° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 208:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 209:
	        datosItem.nombre = "Armadura Legionaria 2° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 210:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 5;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
	    case 211:
	        datosItem.nombre = "Armadura Legionaria 1° Jerarquía (E/G)";
	        datosItem.tipo = "ropa";
	        datosItem.raza = 6;
	        datosItem.clases[0] = true; // Clase 0 Arquero
	        datosItem.clases[2] = true; // Clase 2 Bardo
	        datosItem.clases[4] = true; // Clase 4 Clérigo
	        datosItem.clases[5] = true; // Clase 5 Druida
	        datosItem.clases[6] = true; // Clase 6 Guerrero
	        datosItem.clases[7] = true; // Clase 7 Mago
	        break;
    
    
	}

	return datosItem;
















}
