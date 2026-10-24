if (online_activo() || global.online_exportando) { instance_destroy(); exit; }
/// @description  Estado inicial
oro = 0;
dropeaItem = false;
indItem = 0;
cantItem = 0;
roomInicial = -1;

visible = false;

pj_avance = (obj_pj.nivel/obj_pj.nivelMax); //indica que tan cerca esta el pj del nivel max. (de 0 a 1)

gradoIA = 0.55; // Media

if (obj_control_opciones.dificultad == 1) {
    gradoIA = 0.65; // Alta
}
//aumentamos dificultad gradualmente
gradoIA+= pj_avance*0.01

hostil = true;
image_speed = 0;
enemigo = false;
siguiendo = false;
direccion = 0;
puedeMoverse = true;
moviendose = false;
xInicio = x;
yInicio = y;
spd = 2.35;
spdUltimoPaso = 1.46; // En realidad es 1.45
pasos = 0;
pasosMax = 13;
envenena = false;
veneno = 0;
muerto = false;
xObjetivo = x;
yObjetivo = y;
poteando = false;
roomOrigen = room;
agitando = false;
yaHablo = false;
yaTiroHechizo = false;
yaEncontroItem = false;
dano = 0;
indiceTirarItems = 0;
gano = false;
lukea = true;
tiempoLejosPJ = 0;
tiempoEnView = 0;
yaHabloEnojado1 = false;
yaHabloEnojado2 = false;
yaHabloEnojado3 = false;

// Navega?

navega = false;
enBarca = false;

if (obj_pj.nivel >= NIVEL_MIN_BARCA) {
    navega = true;
}

// Gráfico arma y escudo

frameArma = 0;
frameEscudo = 0;

// Movimiento horizontal/vertical

ordenMovimientos = 0;

// Género (0 = hombre, 1 = mujer)

if (random(10) > 5) {
    genero = 0;
} else {
    genero = 1;
}

// Clase

/* 

0 = Clérigo
1 = Mago
2 = Cazador

*/


clase = floor(random(3));

if (clase < 0 || clase > 2) {
    clase = 0;
}

// Raza 

/*

0 = Humano
1 = Elfo
2 = Elfo Oscuro
3 = Enano
4 = Gnomo

*/

nroRaza = 0;

if (clase == 2) {
    nroRaza = 1;
} else if (clase == 1) {
    if (random(10) > 5) {
        nroRaza = 0;
    } else {
        nroRaza = 4;
    }
} else {
    if (random(10) > 5) {
        nroRaza = 0;
    } else {
        nroRaza = 2;
    }
}

// Cabeza

sprCabeza = elegirCabezaRandom(nroRaza, genero);

// Salud

saludMax = floor(random_range(40, 45));

switch (clase) {
    case 0:
        if (nroRaza == 0) {
            repeat (obj_pj.nivel) {
                saludMax += floor(random_range(10, 11));
            }
        } else {
            repeat (obj_pj.nivel) {
                saludMax += floor(random_range(9, 10));
            }
        }
        break;
    case 1:
        if (nroRaza == 0) {
            repeat (obj_pj.nivel) {
                saludMax += floor(random_range(8, 9));
            }
        } else {
            repeat (obj_pj.nivel) {
                saludMax += floor(random_range(7, 8));
            }
        }
        break;
    case 2:
        repeat (obj_pj.nivel) {
            saludMax += floor(random_range(10, 11));
        }
        break;
}

saludMax = floor(saludMax + saludMax * (pj_avance*0.08)); //hasta +8% de stats segun el nivel de nuestro pj
salud = saludMax;

// Maná

manaMax = 0;

switch (clase) {
    case 0:
        if (nroRaza == 0) {
            repeat (obj_pj.nivel) {
                manaMax += 36;
            }
        } else {
            repeat (obj_pj.nivel) {
                manaMax += 40;
            }
        }
        break;
    case 1:
        if (nroRaza == 0) {
            repeat (obj_pj.nivel) {
                manaMax += 54;
            }
        } else {
            repeat (obj_pj.nivel) {
                manaMax += 63;
            }
        }
        break;
    case 2:
        repeat (obj_pj.nivel) {
            manaMax += 20;
        }
        break;
}
manaMax= manaMax * 0.75
manaMax = floor( manaMax + manaMax * (pj_avance*0.08)); //hasta +8% de stats segun el nivel de nuestro pj

if (manaMax < 0) {
    manaMax = 0;
}

if (clase != 2 && manaMax < 45) {
    manaMax = 45;
}

mana = manaMax;

// Criminal / Ciudadano

if (obj_pj.nivel <= 12) {
	setPk(false);
}else{
	setPk(random(10) > 7.5) ;
}

if (obj_pj.nivel <= 12) {
    pk = false;
}

// Nombre

nombre = elegirNombreIA();

//forzamos si es pk o no segun el boton apretado en la arena
if (room == rm_arena) setPk(obj_agregar_bot.spawnear_pk);


// Gráfico

index[0, 0] = 0;
index[0, 1] = 1;
index[0, 2] = 2;
index[0, 3] = 3;
index[0, 4] = 4;

index[1, 0] = 5;
index[1, 1] = 6;
index[1, 2] = 7;
index[1, 3] = 8;
index[1, 4] = 9;

index[2, 0] = 10;
index[2, 1] = 11;
index[2, 2] = 12;
index[2, 3] = 13;
index[2, 4] = 14;

index[3, 0] = 15;
index[3, 1] = 16;
index[3, 2] = 17;
index[3, 3] = 18;
index[3, 4] = 19;

frame = 0;

// Alarm 2

intervaloAtaque = 240;
alarm[2] = intervaloAtaque;

// Fuerza

danoMeleeMin = obj_pj.danoMin * random_range(0.8, 0.85 + pj_avance * 0.15);
danoMeleeMax = obj_pj.danoMax * random_range(0.8, 0.85 + pj_avance * 0.15);

// Evasión

evasion = random_range(20, 25);

switch (nroRaza) {
    case 0: // Humano
        evasion += 1 * (obj_pj.nivel / 3);
        break;
    case 1: // Elfo
        evasion += 4 * (obj_pj.nivel / 3);
        break;
    case 2: // EO
        evasion += 2 * (obj_pj.nivel / 3);
        break;
    case 4: // Gnomo
        evasion += 3 * (obj_pj.nivel / 3);
        break;
}

evasion = round(evasion * 1.25);

// Experiencia otorgada al morir

experiencia = 0;

// Inmovilizado

inmovilizado = false;
puedeRemoverse = false;

// Alarm 5, 6, 7 y 8 - desfasados para evitar picos cuando N bots spawnean a la vez
alarm[5] = 1 + irandom(45);
alarm[6] = 1 + irandom(30);
alarm[8] = intervaloAtaque + irandom(60);

// Dice palabras mágicas

dicePalabrasMagicas = false;
palabrasMagicas = "";

// Equipo

eqArma = -1;
eqRopa = -1;
eqCascoGorro = -1;
eqEscudo = -1;
eqFlechas = -1;
eqRojas = -1;
eqAzules = -1;

inventario = inventarioIAVacio();

elegirEquipoIA(id);

eqArma = inventario[0].indice;
eqRopa = inventario[1].indice;
eqCascoGorro = inventario[2].indice;
eqEscudo = inventario[3].indice;
sprArma = obtenerSpriteArma(eqArma);
sprEscudo = obtenerSpriteEscudo(eqEscudo);
eqFlechas = inventario[4].indice;
eqRojas = inventario[5].indice;
eqAzules = inventario[6].indice;

inventario[4].cant = floor(random_range(150, 550));
inventario[5].cant = floor(random_range(150, 550));
inventario[6].cant = floor(random_range(150, 550));

inventario[7] = crearSlotIA(irandom_range(101, 115), irandom_range(50, 100));
inventario[8] = crearSlotIA(irandom_range(116, 119), irandom_range(50, 100));

// Alarm 3

visible = true;

// Setea variables en NPCs

with (obj_npc_basic) {
    if (hostil && id != other.id) {
        personaRoom = other.id;
    }
}

// Navegando?

if (obj_pj.nivel >= NIVEL_MIN_BARCA && !is_special_room()) {
    if (tile_layer_find(TILE_LAYER_GRASS, x, y) == -1 && tile_layer_find(TILE_LAYER_COAST, x, y) == -1 && tile_layer_find(TILE_LAYER_FLOORS, x, y) == -1 && tile_layer_find(10000, x, y) == -1) {
        // Hay agua debajo de la IA
        enBarca = true;
    }
}

// Teletransportes

TPCerca = -1;

// NPCs

NPCsEnView[0] = -1;
NPCsEnView[1] = -1;
NPCsEnView[2] = -1;
NPCsEnView[3] = -1;
NPCsEnView[4] = -1;
NPCsEnView[5] = -1;
NPCsEnView[6] = -1;
NPCsEnView[7] = -1;
NPCsEnView[8] = -1;
NPCsEnView[9] = -1;
NPCsEnView[10] = -1;
NPCsEnView[11] = -1;
NPCsEnView[12] = -1;
NPCsEnView[13] = -1;
NPCsEnView[14] = -1;
NPCsEnView[15] = -1;
NPCsEnView[16] = -1;
NPCsEnView[17] = -1;
NPCsEnView[18] = -1;
NPCsEnView[19] = -1;

// Inmovilizados

inmovilizados[0] = -1;
inmovilizados[1] = -1;
inmovilizados[2] = -1;
inmovilizados[3] = -1;
inmovilizados[4] = -1;
inmovilizados[5] = -1;
inmovilizados[6] = -1;
inmovilizados[7] = -1;
inmovilizados[8] = -1;
inmovilizados[9] = -1;

// Sigue al PJ al otro mapa?

sigue = true;

// Dibuja
cantIAEnView = 0
IAObj = elegirIAObjetivoIA(true);
dibujarIA();

function setPk(_pk){
	
	pk = _pk;

	rangoFaccion = 0;

	if (random(10) > 8.5) {
		if (obj_pj.nivel >= 30) {
			rangoFaccion = 1;
		} else if (obj_pj.nivel >= 35) {
			rangoFaccion = choose(1, 2);
		} else if (obj_pj.nivel >= 40) {
			rangoFaccion = choose(1, 2, 3);
		}
	}
}

/* */
/*  */
