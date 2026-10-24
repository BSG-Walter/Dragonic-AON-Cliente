/// @description Insert description here
// You can write your code in this editor
draw_sprite(sprite_index,0,x,y)
draw_set_color(c_white);
draw_set_font(fnt_Vedrana_8_bold);
draw_set_halign(fa_left)
draw_text(x,y-20,display)
draw_text(x+5,y+5,before_value + string(value))