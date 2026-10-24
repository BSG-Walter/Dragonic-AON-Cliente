/// @description  Estado inicial
event_inherited();
nombre = "Viuda Negra";
envenena = true;
veneno = 2;

// Salud

saludMax = 4000; // La vida es igual a la del manual
salud = saludMax;

// Gráfico

index[0, 0] = 0;
index[0, 1] = 1;
index[0, 2] = 2;
index[0, 3] = 3;

index[1, 0] = 4;
index[1, 1] = 5;
index[1, 2] = 6;
index[1, 3] = 7;

index[2, 0] = 8;
index[2, 1] = 9;
index[2, 2] = 10;
index[2, 3] = 11;

index[3, 0] = 12;
index[3, 1] = 13;
index[3, 2] = 14;
index[3, 3] = 15;

// Fuerza (La fuerza es distinta a la del manual)

ataque = 150;

danoMeleeMin = round(ataque * 0.5);
danoMeleeMax = round(ataque * 0.65);

// Evasión

evasion = 90; // La evasión es igual a la del manual

// Experiencia otorgada al morir

experiencia = 6000; // La experiencia es igual a la del manual

// Oro otorgado al morir

oro = obj_pj.modOro * 1000; // El oro es igual al del manual

// Doma
