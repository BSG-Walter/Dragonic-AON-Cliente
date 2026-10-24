/// @description Funciones de texto flotante (todos usan obj_INFO)

/// @description crearTextoDano(x, y, valor, padreId) - numero de dano sobre una entidad
function crearTextoDano(x, y, valor, padreId) {
    var m = instance_create_depth(x, y, 0, obj_INFO);
    m.texto = string(valor);
    m.fuente = fnt_Vedrana_8_bold;
    m.desfaseY = 16;
    m.velocidadFade = 0.02;
    m.color = c_red;
    m.esDano = true;
    m.padre = padreId;
    return m;
}

/// @description crearTextoSubirSkill(indice) - "Skill +1" naranja sobre el jugador
function crearTextoSubirSkill(indice) {
    var m = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
    m.texto = textoSkill(indice) + " +1";
    m.color = make_color_rgb(255, 150, 15);
    m.velocidadFade = 0.015;
    m.esSubidaSkill = true;
    return m;
}

function intentarSubirSkillNatural(indice, probBase) {
    if (!instance_exists(obj_pj) || !variable_instance_exists(obj_pj, "skills")) return 0;
    if (obj_pj.skills[indice] >= obj_pj.skillsNaturales[obj_pj.nivel]) return 0;
    var _prob = probBase * SKILL_FACTOR;
    var _veces = floor(_prob);
    var _resto = _prob - _veces;
    var _subidas = 0;
    for (var i = 0; i < _veces; i++) {
        if (obj_pj.skills[indice] < obj_pj.skillsNaturales[obj_pj.nivel]) {
            obj_pj.skills[indice]++;
            _subidas++;
        } else break;
    }
    if (random(1) < _resto) {
        if (obj_pj.skills[indice] < obj_pj.skillsNaturales[obj_pj.nivel]) {
            obj_pj.skills[indice]++;
            _subidas++;
        }
    }
    if (_subidas > 0) {
        obj_skills_libres.mostrado = false;
        var _texto = textoSkill(indice) + " +" + string(_subidas);
        var m = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
        m.texto = _texto;
        m.color = make_color_rgb(255, 150, 15);
        m.velocidadFade = 0.015;
        m.esSubidaSkill = true;
    }
    return _subidas;
}

/// @description crearTextoFaltaSkill(nroSkill, skillRequerido) - aviso de skill insuficiente
function crearTextoFaltaSkill(nroSkill, skillRequerido) {
    var m = instance_create_depth(obj_pj.x, obj_pj.y, 0, obj_INFO);
    m.texto = "¡" + textoSkill(nroSkill) + " menor a " + string(skillRequerido) + "!";
    m.velocidadFade = 0.015;
    return m;
}
