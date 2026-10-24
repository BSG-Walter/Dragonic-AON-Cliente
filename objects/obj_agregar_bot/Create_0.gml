/// @description Inicializo variables para los botones de bots

spawnear_pk = false;

escala = 2;

sprite_ancho = sprite_get_width(spr_agregar_bot);
sprite_alto = sprite_get_height(spr_agregar_bot);

ancho_escalado = sprite_ancho * escala;
alto_escalado = sprite_alto * escala;

radio = ancho_escalado / 2;
espacio_vertical = alto_escalado;
