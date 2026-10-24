/// @description  Estado inicial
event_inherited();
nombre = "Cuervo";

// Salud

saludMax = 30; // La vida es igual a la del manual
salud = saludMax;

// Gráfico

index[0, 0] = 0;
index[0, 1] = 1;

index[1, 0] = 2;
index[1, 1] = 3;

index[2, 0] = 4;
index[2, 1] = 5;

index[3, 0] = 6;
index[3, 1] = 7;

// Fuerza (La fuerza es distinta a la del manual)

ataque = 25;

danoMeleeMin = round(ataque * 0.5);
danoMeleeMax = round(ataque * 0.65);

// Evasión

evasion = 35; // La evasión es igual a la del manual

// Experiencia otorgada al morir

experiencia = 40; // La experiencia es igual a la del manual

// Doma

domable = true;
puntosDomaNPC = 50;
