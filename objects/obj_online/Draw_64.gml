if (!global.online_exportando && !instance_exists(obj_pausa)) {
    online_ui_draw();
    if (room == rm_menuPrincipal && actualizacion_url != "") {
        draw_set_alpha(0.95);
        draw_set_color(make_color_rgb(22, 43, 49));
        draw_roundrect(ACTUALIZACIONES_UI_LEFT, ACTUALIZACIONES_UI_TOP,
            ACTUALIZACIONES_UI_RIGHT, ACTUALIZACIONES_UI_BOTTOM, false);
        draw_set_alpha(1);
        draw_set_font(fnt_Vedrana_7_bold);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_set_color(c_yellow);
        draw_text(ACTUALIZACIONES_UI_LEFT + ONLINE_UI_TEXT_HEIGHT div 2,
            ACTUALIZACIONES_UI_TOP + ONLINE_UI_TEXT_HEIGHT div 4,
            "Nueva versión " + actualizacion_version + " disponible");
        draw_set_color(c_aqua);
        draw_text(ACTUALIZACIONES_UI_LEFT + ONLINE_UI_TEXT_HEIGHT div 2,
            ACTUALIZACIONES_UI_TOP + ONLINE_UI_TEXT_HEIGHT + ONLINE_UI_TEXT_HEIGHT div 3,
            actualizacion_es_apk ? "Tocá aquí para descargar el APK" : "Tocá aquí para ver la versión");
        draw_set_color(c_white);
    }
}

if (test_capture) { screen_save("online_test_" + test_role + ".png"); test_capture = false; }
