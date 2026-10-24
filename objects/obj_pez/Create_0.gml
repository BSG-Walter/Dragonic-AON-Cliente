/// @description  Estado inicial

direction = random(360);
image_angle = direction;
image_alpha = 0.135;
image_speed = 0.8;
speed = 1.2;

giro = random_range(1.5, 2);
sube = false;
avanza = true;
esPescado = false;
step_check = floor(random(8));

alarm[3] = 180;
alarm[4] = random_range(180, 240);

// Se hace visible o invisible

visible = esPescado || hayAguaEn(x, y);
