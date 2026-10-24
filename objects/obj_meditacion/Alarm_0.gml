if (online_activo()) exit;
/// @description  Incremento la maná

manaIncrementada = round(obj_pj.skills[3] * 1.15);

if (obj_pj.mana + manaIncrementada <= obj_pj.manaMax) {
    obj_pj.mana += manaIncrementada;
} else {
    obj_pj.mana = obj_pj.manaMax;
}

if (obj_pj.skills[3] < obj_pj.skillsNaturales[obj_pj.nivel]) {
    intentarSubirSkillNatural(3, 0.35);
}

alarm[0] = 25;

