// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function show_message_a(text){
	var id_obj = instance_create_depth(0, 0, 0, obj_show_message_async);
	id_obj.text = text;
	with (id_obj) event_user(0);
}