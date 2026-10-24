var layTiles = layer_get_id("Foreground_Tiles");
if (layTiles != -1) layer_set_visible(layTiles, false);
var layTilesCian = layer_get_id("Foreground_Tiles_Cian");
if (layTilesCian != -1) layer_set_visible(layTilesCian, false);
var layTechos = layer_get_id("Foreground_Techos");
if (layTechos != -1) layer_set_visible(layTechos, false);

if (is_ingame_room()) {
    nombreMapa = obtenerNombreMapa(room, -1, -1);
}

render_width = get_render_width()
render_height = get_render_height()