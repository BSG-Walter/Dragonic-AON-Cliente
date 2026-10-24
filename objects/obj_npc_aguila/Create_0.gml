/// @description  Estado inicial
event_inherited();
nombre = "Águila";

// Salud

saludMax = 10; // La vida es igual a la del manual
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

ataque = 15;

danoMeleeMin = round(ataque * 0.5);
danoMeleeMax = round(ataque * 0.65);

// Evasión

evasion = 30; // La evasión es igual a la del manual

// Experiencia otorgada al morir

experiencia = 10; // La experiencia es igual a la del manual

// Doma

domable = true;
puntosDomaNPC = 87;
