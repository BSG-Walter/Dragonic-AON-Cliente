if (!global.online_exportando && !instance_exists(obj_pausa)) online_ui_draw();

if (test_capture) { screen_save("online_test_" + test_role + ".png"); test_capture = false; }
