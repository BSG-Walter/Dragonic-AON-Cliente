/// @description  Estado inicial

image_speed = 0;
depth = DEPTH_FLOAT_TEXT;
desc = "";
tiempo = 300;
alarm[0] = 2;

idMsg = instance_position(x, y, obj_msg);

if (idMsg != id && idMsg.x == x && idMsg.y == y) {
    with (idMsg) {
        instance_destroy();
    }
}

