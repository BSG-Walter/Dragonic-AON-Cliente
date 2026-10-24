/// @description  Estado inicial
event_inherited();
nombre = "Rata";

// Salud

saludMax = 15; // La vida es igual a la del manual
salud = saludMax;

// Gráfico

index[0, 0] = 0;
index[0, 1] = 1;
index[0, 2] = 2;

index[1, 0] = 3;
index[1, 1] = 4;
index[1, 2] = 5;

index[2, 0] = 6;
index[2, 1] = 7;
index[2, 2] = 8;

index[3, 0] = 9;
index[3, 1] = 10;
index[3, 2] = 11;

// Fuerza (La fuerza es distinta a la del manual)

ataque = 10;

danoMeleeMin = round(ataque * 0.5);
danoMeleeMax = round(ataque * 0.65);

// Evasión

evasion = 20; // La evasión es igual a la del manual

// Experiencia otorgada al morir

experiencia = 15; // La experiencia es igual a la del manual

// Doma

domable = true;
puntosDomaNPC = 15;
