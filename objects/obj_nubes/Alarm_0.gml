/// @description  Creo las particulas y reseteo la alarm[0]

// Emisor

if (random(10) > 5) {
    part_type_direction(tipoNubes, 180, 180, 0, 0);
} else {
    part_type_direction(tipoNubes, 0, 0, 0, 0);
}

part_emitter_region(sistemaNubes, emisorNubes, global.render_x - get_render_width() * 0.5, global.render_x + get_render_width() * 0.5, global.render_y, global.render_y + get_render_height(), ps_shape_rectangle, ps_distr_linear);

if (esMapaDescubierto()) {
    part_emitter_burst(sistemaNubes, emisorNubes, tipoNubes, nroNubes);
}

// Alarma
alarm[1] = tiempo * random_range(0.33, 0.5);

