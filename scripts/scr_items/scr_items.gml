function scr_items(){

}

function init_ropas(){
    // Mapeo global de sprites de armas y escudos
    global.sprArmas = array_create(256, -1);
    global.sprArmas[0] = spr_arma_1;
    global.sprArmas[1] = spr_arma_1;
    global.sprArmas[2] = spr_arma_2;
    global.sprArmas[3] = spr_arma_3;
    global.sprArmas[4] = spr_arma_3;
    global.sprArmas[5] = spr_arma_4;
    global.sprArmas[6] = spr_arma_5;
    global.sprArmas[7] = spr_arma_6;
    global.sprArmas[8] = spr_arma_6;
    global.sprArmas[9] = spr_arma_7;
    global.sprArmas[10] = spr_arma_8;
    global.sprArmas[11] = spr_arma_9;
    global.sprArmas[12] = spr_arma_10;
    global.sprArmas[13] = spr_arma_11;
    global.sprArmas[14] = spr_arma_12;
    global.sprArmas[15] = spr_arma_13;
    global.sprArmas[16] = spr_arma_14;
    global.sprArmas[17] = spr_arma_15;
    global.sprArmas[18] = spr_arma_16;
    global.sprArmas[19] = spr_arma_17;
    global.sprArmas[20] = spr_arma_18;
    global.sprArmas[21] = spr_arma_19;
    global.sprArmas[22] = spr_arma_20;
    global.sprArmas[23] = spr_arma_21;
    global.sprArmas[24] = spr_arma_22;
    global.sprArmas[25] = spr_arma_23;
    global.sprArmas[26] = spr_arma_24;
    global.sprArmas[27] = spr_arma_25;
    global.sprArmas[227] = spr_arma_26;

    global.sprEscudos = array_create(128, -1);
    global.sprEscudos[98] = spr_escudo_1;
    global.sprEscudos[99] = spr_escudo_2;
    global.sprEscudos[100] = spr_escudo_3;

    global.sprRopa = array_create(256, -1);
    global.sprRopa[33] = spr_tunica_1;
    global.sprRopa[34] = spr_tunica_2;
    global.sprRopa[35] = spr_tunica_3;
    global.sprRopa[36] = spr_tunica_4;
    global.sprRopa[37] = spr_tunica_5;
    global.sprRopa[38] = spr_tunica_6;
    global.sprRopa[39] = spr_tunica_7;
    global.sprRopa[40] = spr_tunica_8;
    global.sprRopa[43] = spr_tunica_11;
    global.sprRopa[44] = spr_tunica_12;
    global.sprRopa[68] = spr_ropa_24;
    global.sprRopa[69] = spr_ropa_25;
    global.sprRopa[70] = spr_ropa_26;
    global.sprRopa[72] = spr_armadura_1;
    global.sprRopa[73] = spr_armadura_2;
    global.sprRopa[75] = spr_armadura_4;
    global.sprRopa[76] = spr_armadura_5;
    global.sprRopa[83] = spr_armadura_12;
    global.sprRopa[41] = spr_tunica_9;
    global.sprRopa[42] = spr_tunica_10;
    global.sprRopa[45] = spr_ropa_1;
    global.sprRopa[46] = spr_ropa_2;
    global.sprRopa[47] = spr_ropa_3;
    global.sprRopa[48] = spr_ropa_4;
    global.sprRopa[49] = spr_ropa_5;
    global.sprRopa[50] = spr_ropa_6;
    global.sprRopa[51] = spr_ropa_7;
    global.sprRopa[52] = spr_ropa_8;
    global.sprRopa[53] = spr_ropa_9;
    global.sprRopa[54] = spr_ropa_10;
    global.sprRopa[55] = spr_ropa_11;
    global.sprRopa[56] = spr_ropa_12;
    global.sprRopa[57] = spr_ropa_13;
    global.sprRopa[58] = spr_ropa_14;
    global.sprRopa[59] = spr_ropa_15;
    global.sprRopa[60] = spr_ropa_16;
    global.sprRopa[61] = spr_ropa_17;
    global.sprRopa[62] = spr_ropa_18;
    global.sprRopa[63] = spr_ropa_19;
    global.sprRopa[64] = spr_ropa_20;
    global.sprRopa[65] = spr_ropa_21;
    global.sprRopa[66] = spr_ropa_22;
    global.sprRopa[67] = spr_ropa_23;
    global.sprRopa[71] = spr_ropa_27;
    global.sprRopa[74] = spr_armadura_3;
    global.sprRopa[77] = spr_armadura_6;
    global.sprRopa[78] = spr_armadura_7;
    global.sprRopa[79] = spr_armadura_8;
    global.sprRopa[80] = spr_armadura_9;
    global.sprRopa[81] = spr_armadura_10;
    global.sprRopa[82] = spr_armadura_11;
    global.sprRopa[84] = spr_armadura_13;
    global.sprRopa[85] = spr_armadura_14;
    global.sprRopa[86] = spr_armadura_15;
    global.sprRopa[87] = spr_armadura_16;
    global.sprRopa[88] = spr_armadura_17;
    global.sprRopa[89] = spr_armadura_18;
    global.sprRopa[90] = spr_armadura_19;
    global.sprRopa[91] = spr_armadura_20;
    global.sprRopa[92] = spr_armadura_21;
    global.sprRopa[212] = spr_armadura_22;
    global.sprRopa[213] = spr_armadura_23;
    global.sprRopa[214] = spr_armadura_25;
    global.sprRopa[215] = spr_armadura_24;
    global.sprRopa[216] = spr_armadura_26;
    global.sprRopa[222] = spr_armadura_27;
    global.sprRopa[223] = spr_armadura_28;
    global.sprRopa[224] = spr_armadura_29;
    global.sprRopa[225] = spr_armadura_30;
    global.sprRopa[226] = spr_armadura_31;
    global.sprRopa[164] = spr_armada_1;
    global.sprRopa[165] = spr_armada_13;
    global.sprRopa[166] = spr_armada_2;
    global.sprRopa[167] = spr_armada_14;
    global.sprRopa[168] = spr_armada_3;
    global.sprRopa[169] = spr_armada_15;
    global.sprRopa[170] = spr_legion_1;
    global.sprRopa[171] = spr_legion_13;
    global.sprRopa[172] = spr_legion_2;
    global.sprRopa[173] = spr_legion_14;
    global.sprRopa[174] = spr_legion_3;
    global.sprRopa[175] = spr_legion_15;
    global.sprRopa[176] = spr_armada_4;
    global.sprRopa[177] = spr_armada_16;
    global.sprRopa[178] = spr_armada_5;
    global.sprRopa[179] = spr_armada_17;
    global.sprRopa[180] = spr_armada_6;
    global.sprRopa[181] = spr_armada_18;
    global.sprRopa[182] = spr_legion_4;
    global.sprRopa[183] = spr_legion_16;
    global.sprRopa[184] = spr_legion_5;
    global.sprRopa[185] = spr_legion_17;
    global.sprRopa[186] = spr_legion_6;
    global.sprRopa[187] = spr_legion_18;
    global.sprRopa[188] = spr_armada_7;
    global.sprRopa[189] = spr_armada_19;
    global.sprRopa[190] = spr_armada_8;
    global.sprRopa[191] = spr_armada_20;
    global.sprRopa[192] = spr_armada_9;
    global.sprRopa[193] = spr_armada_21;
    global.sprRopa[194] = spr_legion_7;
    global.sprRopa[195] = spr_legion_19;
    global.sprRopa[196] = spr_legion_8;
    global.sprRopa[197] = spr_legion_20;
    global.sprRopa[198] = spr_legion_9;
    global.sprRopa[199] = spr_legion_21;
    global.sprRopa[200] = spr_armada_10;
    global.sprRopa[201] = spr_armada_22;
    global.sprRopa[202] = spr_armada_11;
    global.sprRopa[203] = spr_armada_23;
    global.sprRopa[204] = spr_armada_12;
    global.sprRopa[205] = spr_armada_24;
    global.sprRopa[206] = spr_legion_10;
    global.sprRopa[207] = spr_legion_22;
    global.sprRopa[208] = spr_legion_11;
    global.sprRopa[209] = spr_legion_23;
    global.sprRopa[210] = spr_legion_12;
    global.sprRopa[211] = spr_legion_24;
}

/// @description obtenerSpriteArma(indice)
function obtenerSpriteArma(indice) {
    if (indice >= 0 && indice < array_length(global.sprArmas)) {
        return global.sprArmas[indice];
    }
    return -1;
}

/// @description obtenerSpriteEscudo(indice)
function obtenerSpriteEscudo(indice) {
    if (indice >= 0 && indice < array_length(global.sprEscudos)) {
        return global.sprEscudos[indice];
    }
    return -1;
}

/// @description obtenerSpriteRopa(indice)
function obtenerSpriteRopa(indice) {
    if (indice >= 0 && indice < array_length(global.sprRopa)) {
        return global.sprRopa[indice];
    }
    return -1;
}


/// @description crearSlotInv(indice, cant, equipado)
function crearSlotInv(_indice, _cant, _equipado) {
    if (_indice == -1) {
        return {
            indice: -1,
            cant: 0,
            equipado: false,
            tipo: "",
            genero: -1,
            raza: -1,
            nroSkill: 0,
            skillReq: 0,
            clases: [true, true, true, true, true, true, true, true, true],
            nombre: "Vacío"
        };
    }

    var _datos = configurarItem(_indice);
    return {
        indice: _indice,
        cant: _cant,
        equipado: _equipado,
        tipo: _datos.tipo,
        genero: _datos.genero,
        raza: _datos.raza,
        nroSkill: _datos.nroSkill,
        skillReq: _datos.skillReq,
        clases: _datos.clases,
        nombre: _datos.nombre
    };
}

/// @description crearSlotNpc(indice, cant, nombre)
function crearSlotNpc(_indice, _cant, _nombre) {
    return {
        indice: _indice,
        cant: _cant,
        nombre: _nombre
    };
}

/// @description crearSlotIA(indice, cant)
function crearSlotIA(_indice, _cant) {
    return {
        indice: _indice,
        cant: _cant
    };
}

/// @description inventarioIAVacio() — 20 slots vacíos
function inventarioIAVacio() {
    var _inv = array_create(MAX_SLOTS);
    for (var i = 0; i < MAX_SLOTS; i++) {
        _inv[i] = crearSlotIA(-1, 0);
    }
    return _inv;
}

/// @description crearHechizo(indice, nombre, tipo, mana, energia, skill, efectoMin, efectoMax, palabrasMagicas)
function crearHechizo(_indice, _nombre, _tipo, _mana, _energia, _skill, _efectoMin, _efectoMax, _palabrasMagicas) {
    return {
        indice: _indice,
        nombre: _nombre,
        tipo: _tipo,
        mana: _mana,
        energia: _energia,
        skill: _skill,
        efectoMin: _efectoMin,
        efectoMax: _efectoMax,
        palabrasMagicas: _palabrasMagicas
    };
}

/// @description hechizoVacio()
function hechizoVacio() {
    return crearHechizo(-1, "", "", 0, 0, 0, 0, 0, "");
}

/// @description itemMundo(_x, _y, _indice, _tipo, _cantidad, _valor)
function itemMundo(_x, _y, _indice, _tipo, _cantidad, _valor) {
    return {
        x: _x,
        y: _y,
        indice: _indice,
        tipo: _tipo,
        cantidad: _cantidad,
        valor: _valor
    };
}

/// @description itemMundoVacio()
function itemMundoVacio() {
    return itemMundo(-1, -1, -1, "", -1, -1);
}

/// @description datosIAVacio()
function datosIAVacio() {
    return {
        x: -1,
        y: 0,
        enemigo: false,
        direccion: 0,
        yaHabloEnojado1: false,
        yaHabloEnojado2: false,
        yaHabloEnojado3: false,
        genero: 0,
        clase: 0,
        nroRaza: 0,
        saludMax: 0,
        salud: 0,
        manaMax: 0,
        mana: 0,
        nombre: "",
        danoMeleeMin: 0,
        danoMeleeMax: 0,
        evasion: 0,
        eqArma: -1,
        eqRopa: -1,
        eqCascoGorro: -1,
        eqEscudo: -1,
        eqFlechas: -1,
        pk: false,
        enBarca: false,
        sprCabeza: -1,
        inmovilizado: false,
        agitando: false,
        yaHablo: false,
        tiempoEnView: 0,
        alarm4: -1,
        alarm8: -1,
        tiempoLejosPJ: 0,
        TPCerca: -1,
        distTPCerca: -1,
        tpCercaX: -1,
        tpCercaY: -1,
        tpCercaXTP: -1,
        tpCercaYTP: -1,
        tpCercaVisible: false,
        roomIA: -1,
        lugarEnGlobalIA: 0,
        alarm7: -1,
        puedeCrear: false,
        sigueAlOtroMapa: false,
        rangoFaccion: -1
    };
}