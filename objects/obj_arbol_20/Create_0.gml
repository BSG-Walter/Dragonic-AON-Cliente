/// @description  Estado inicial

image_speed = 0;
instance_create_depth(x, y - TILE_SIZE, 0, obj_bloqueo_arboles);
instance_create_depth(x + TILE_SIZE, y - TILE_SIZE, 0, obj_bloqueo_arboles);
instance_create_depth(x - TILE_SIZE, y - TILE_SIZE, 0, obj_bloqueo_arboles);
instance_create_depth(x - 64, y - TILE_SIZE, 0, obj_bloqueo_arboles);

