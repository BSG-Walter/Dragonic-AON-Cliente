/// @description  Estado inicial
event_inherited();
nombre = "Asesino";

dropeaItem = true;
indItem = 1;
cantItem = 1;

// Salud

saludMax = 1000; // La vida es igual a la del manual
salud = saludMax;

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

// Fuerza (La fuerza es distinta a la del manual)

ataque = 200;

danoMeleeMin = round(ataque * 0.5);
danoMeleeMax = round(ataque * 0.65);

// Evasión

evasion = 200; // La evasión es igual a la del manual

// Experiencia otorgada al morir

experiencia = 1200; // La experiencia es igual a la del manual

// Oro otorgado al morir

oro = obj_pj.modOro * 350; // El oro es igual al del manual

// Doma
