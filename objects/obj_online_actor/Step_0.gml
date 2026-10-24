
if (is_undefined(data)) exit;
var _distance = point_distance(x, y, data.x, data.y);
if (_distance > ONLINE_CATCH_UP_DISTANCE) catching_up = true;
if (_distance <= 1) catching_up = false;
var _speed = catching_up ? ONLINE_CATCH_UP_FACTOR : 1;
var _scale = _distance > 0 ? min(1, move_step * _speed / _distance) : 1;
x = lerp(x, data.x, _scale);
y = lerp(y, data.y, _scale);
if (instance_exists(obj_pj)) depth = obj_pj.depth + obj_pj.y - y;

if (!is_undefined(data) && data.kind != "drop" && point_distance(last_step_x, last_step_y, data.x, data.y) >= TILE_SIZE) {
    if (data.kind == "npc") reproducirSonido(snd_paso, false, false);
    else if (!data.muerto) reproducirSonido(data.navega ? snd_barca : snd_paso, false, false);
    last_step_x = data.x;
    last_step_y = data.y;
}

animation_steps--;
if (animation_steps <= 0) {
    animation_steps = data.kind == "npc" ? ONLINE_NPC_ANIMATION_FRAMES : ONLINE_ANIMATION_FRAMES;
    var _frames = data.kind == "npc" ? array_length(data.frames[data.direccion]) : ONLINE_BODY_FRAMES;
    walk_frame = _distance > 1 ? (walk_frame + 1) mod max(1, _frames) : 0;
    weapon_frame = current_time < attack_until ? min(ONLINE_WEAPON_FRAMES - 1, weapon_frame + 1) : (walk_frame == ONLINE_BODY_FRAMES - 1 ? 1 : walk_frame);
}
