/// @description  Salud y mana suben

poteando = false;

var _umbralHp = BOT_POT_HP_THRESHOLD_BASE + gradoIA * BOT_POT_HP_THRESHOLD_SCALE;
var _pctHp = gradoIA * BOT_POT_HP_PCT_SCALE;
var _pctMana = gradoIA * BOT_POT_MANA_PCT_SCALE;

if (!muerto) {

    if (salud < floor(saludMax * _umbralHp)) {
    
        poteando = true;
    
        var sumaSalud = floor(_pctHp * saludMax / 100);
    
        if (salud + sumaSalud <= saludMax) {
            salud += sumaSalud;
        } else {
            salud = saludMax;
        }
        
        reproducirSonido(snd_tomarPocion, false, false);
        
    } else if (mana < manaMax) {
    
        poteando = true;
    
        var sumaMana = floor(_pctMana * manaMax / 100);
    
        if (mana + sumaMana <= manaMax) {
            mana += sumaMana;
        } else {
            mana = manaMax;
        }
        
        reproducirSonido(snd_tomarPocion, false, false);
        
    }

}

if (!poteando) {
    alarm[6] = floor(BOT_POT_INTERVAL_IDLE / gradoIA);
} else {
    alarm[6] = floor(BOT_POT_INTERVAL / gradoIA);
}




