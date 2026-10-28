gml_pragma("global", "init_engine_settings();");

#macro RESOLUTION_WIDTH 600
#macro RESOLUTION_HEIGHT 360
#macro RENDER_WIDTH 600
#macro RENDER_HEIGHT 280
#macro INVENTARIO_WIDTH 120
#macro INVENTARIO_HEIGHT 80
#macro MAX_MULTITOUCH 5
// SKILL_FACTOR y RECURSO_FACTOR: escala con multiExp/multiOro. Base 20x (multi=1) = 1.0, 10x (0.5) = 0.5 mínimo, 100x (5) = 5.0.
#macro SKILL_FACTOR max(0.5, obj_opciones.multiExp)
#macro RECURSO_FACTOR max(0.5, obj_opciones.multiOro)

// Configuración de bots

#macro BOT_DRAW_CULL_MARGIN 80

// Poteo de bots: escala continuo con gradoIA (mayor gradoIA = poteo más eficaz)
#macro BOT_POT_HP_THRESHOLD_BASE 0.35
#macro BOT_POT_HP_THRESHOLD_SCALE 0.5
#macro BOT_POT_HP_PCT_SCALE 10
#macro BOT_POT_MANA_PCT_SCALE 20
#macro BOT_POT_INTERVAL_IDLE 100
#macro BOT_POT_INTERVAL 25
#macro BOT_PK_TRUCE_MS 5000
#macro BOT_PK_TRUCE_CHECK_MS 100

// Tile grid
#macro TILE_SIZE 32
#macro WALK_STEP_FRAMES 13
#macro HALF_TILE 16

// Tile layers
#macro TILE_LAYER_GRASS 10000000
#macro TILE_LAYER_COAST 1000000
#macro TILE_LAYER_FLOORS 100000

// Timers
#macro SECOND 60

// Slots de inventario y hechizos
#macro MAX_SLOTS 20

// Índice base de hechizos (120–139)
#macro SPELL_INDEX_BASE 120

// Nivel mínimo para usar la barca
#macro NIVEL_MIN_BARCA 25

// Profundidades de interfaz (menor valor = más al frente)
#macro DEPTH_MANUAL_BUTTONS -16000004
#macro DEPTH_MANUAL -16000003
#macro DEPTH_BUTTONS -16000002
#macro DEPTH_PANEL -16000001
#macro DEPTH_GUI -16000000
#macro DEPTH_FLOAT_TEXT -15999999
#macro DEPTH_MAP_BORDER -75000
#macro DEPTH_PAUSE -50000
// Profundidades del mundo
#macro DEPTH_GROUND_ITEM 10000
#macro DEPTH_WEATHER -294
#macro DEPTH_ROOF -293
#macro DEPTH_MENU_OPTION 1

// Mando y apuntado
#macro GAMEPAD_PLAYER 0
#macro GAMEPAD_MOVE_DEADZONE 0.4
#macro INVENTORY_PAD_ROW_SIZE 10
#macro SPELL_PAD_ROW_SIZE 5
#macro SPELL_PANEL_SPLIT 10
#macro AIM_DEADZONE 0.1
#macro AIM_MIN_SPEED 1
#macro AIM_MAX_SPEED 16
#macro AIM_PRECISION_LIMIT 0.95
#macro AIM_ASSIST_RADIUS 64
#macro AIM_ASSIST_PULL 2
#macro AIM_START_DISTANCE (TILE_SIZE * 3)
#macro AIM_IDLE_DISTANCE (TILE_SIZE * 2)
#macro AIM_RETICLE_MAX_DIST 350
#macro AIM_RETICLE_CLAMP_MARGIN 8
#macro AIM_TARGET_RING_RADIUS 18
#macro AIM_TARGET_RING_GAP 2



#macro CLIENT_VERSION "1.0.8"
#macro ONLINE_PROTOCOL 4
#macro ONLINE_EXPORT_FORMAT 1
#macro ONLINE_PORT 8766
#macro ONLINE_LOCAL_HOST "ws://127.0.0.1"
#macro ONLINE_DISCOVERY_URL "https://dragonic-aon.waltersit0159753.workers.dev"
#macro ONLINE_DISCOVERY_URL_MAX_LENGTH 255
#macro ONLINE_LOCAL_PORT 8768
#macro ONLINE_PREVIOUS_PORT 8765
#macro ONLINE_TIMEOUT_MS 15000
#macro ONLINE_STATUS_DURATION_MS (7 * ONLINE_MS_PER_SECOND)
#macro ONLINE_MOVE_MS 235
#macro ONLINE_MS_PER_SECOND 1000
#macro ONLINE_CLEANUP_WARNING_SECONDS 10
#macro ONLINE_CLEANUP_NOTICE_MAX_AGE_MS (ONLINE_MS_PER_SECOND + 400)
#macro ONLINE_CLEANUP_DONE_MS (2 * ONLINE_MS_PER_SECOND)
#macro ONLINE_ANIMATION_FRAMES 4
#macro ONLINE_NPC_ANIMATION_FRAMES 6
#macro ONLINE_CATCH_UP_DISTANCE (TILE_SIZE + HALF_TILE)
#macro ONLINE_CATCH_UP_FACTOR 2
#macro ONLINE_MERCHANT_MAX_DISTANCE (TILE_SIZE * 6)
#macro ONLINE_NPC_RESPAWN_FX_WINDOW_MS 250
#macro ONLINE_MAX_MESSAGE 131072
#macro ONLINE_ACTOR_BATCH_EVENTS 64
#macro ONLINE_WIRE_MAX_DEPTH 24
#macro ONLINE_WIRE_MAX_COUNT 65535
#macro ONLINE_WIRE_INT32_MIN -2147483648
#macro ONLINE_WIRE_INT32_MAX 2147483647
#macro ONLINE_ROOM_EVENT_BUFFER_LIMIT 1024
#macro ONLINE_UI_LEFT 100
#macro ONLINE_UI_RIGHT 500
#macro ONLINE_UI_TOP 38
#macro ONLINE_UI_LOCAL_BUTTON_X 300
#macro ONLINE_UI_ROW 42
#macro ONLINE_UI_FIELD_LEFT 200
#macro ONLINE_UI_BUTTON_Y 236
#macro ONLINE_UI_BUTTON_HEIGHT 28
#macro ONLINE_UI_STATUS_Y 290
#macro ONLINE_EXPORT_SETTLE 5
#macro ONLINE_MAX_ITEM 227
#macro ONLINE_EXPORT_FILE "dragonic_online_world.json"
#macro ONLINE_SPAWN_X 1296
#macro ONLINE_SPAWN_Y 1808
#macro ONLINE_DEPTH -17000000


#macro ONLINE_DOUBLE_CLICK_MS 350
#macro ONLINE_UI_TEXT_HEIGHT 14
#macro ONLINE_UI_CANCEL_Y 274
#macro ONLINE_UI_MENU_X 64
#macro ONLINE_UI_MENU_Y 40
#macro ONLINE_UI_MENU_ROW 11
#macro ONLINE_UI_MENU_COLUMNS 260
#macro ONLINE_UI_MENU_BUTTON_Y 310
#macro ONLINE_UI_MENU_LIST_Y 60
#macro ONLINE_UI_MENU_COUNT_Y 286
#macro ONLINE_UI_MENU_COUNT_X 400
#macro ONLINE_UI_MENU_COUNT_WIDTH 60
#macro ONLINE_UI_QUANTITY_DIGITS 5
#macro ONLINE_UI_FORM_HEIGHT 274
#macro ACTUALIZACIONES_API "https://api.github.com/repos/BSG-Walter/Dragonic-AON-Cliente/releases/latest"
#macro ACTUALIZACIONES_WEB "https://github.com/BSG-Walter/Dragonic-AON-Cliente/releases/latest"
#macro ACTUALIZACIONES_UI_LEFT ONLINE_UI_LEFT
#macro ACTUALIZACIONES_UI_RIGHT (ONLINE_UI_RIGHT - ONLINE_UI_BUTTON_HEIGHT)
#macro ACTUALIZACIONES_UI_TOP 0
#macro ACTUALIZACIONES_UI_BOTTOM ONLINE_UI_TOP
#macro ONLINE_TEST_POSITION_TOLERANCE 0.001
#macro ONLINE_TEST_MS 16000
#macro ONLINE_TEST_ACTION_MS 1200
#macro ONLINE_TEST_OFFLINE_ATTACK_MS 100
#macro ONLINE_TEST_FINISH_MS 1000
#macro ONLINE_TEST_HEALTH 500
#macro ONLINE_PARITY_SAMPLES 6
#macro ONLINE_STAB_COLOR make_color_rgb(230, 211, 128)
#macro ONLINE_SAVE_NONCE_MAX 1000000
#macro ONLINE_TEST_PORT 9876

function init_engine_settings() {
    global.online_modo = false;
    global.online_elegir = false;
    global.online_exportando = false;
    global.online_pendiente = false;
    layer_force_draw_depth(true, 0);
    draw_set_colour(c_black);
	init_ropas();
}

/// @description textoSkill(indice) - nombre del skill segun su indice
function textoSkill(indice) {
    switch (indice) {
        case 0: return "Magia";
        case 1: return "Tácticas de Combate";
        case 2: return "Combate con Armas";
        case 3: return "Meditar";
        case 4: return "Apuñalar";
        case 5: return "Talar";
        case 6: return "Defensa con Escudos";
        case 7: return "Pesca";
        case 8: return "Minería";
        case 9: return "Carpintería";
        case 10: return "Herrería";
        case 11: return "Domar Animales";
        case 12: return "Arquería";
        case 13: return "Combate sin Armas";
        case 14: return "Navegación";
        case 15: return "Sastrería";
        case 16: return "Comercio";
        case 17: return "Resistencia Mágica";
    }
    return "";
}

#macro ONLINE_BAR_TOP_OFFSET 8
#macro ONLINE_BAR_HEIGHT 4
#macro ONLINE_BAR_GAP 2

#macro ONLINE_HEAD_TALL 36
#macro ONLINE_HEAD_SHORT 28
#macro ONLINE_HEAD_GHOST 27
#macro ONLINE_WEAPON_SHORT_OFFSET 4
#macro ONLINE_BODY_FRAMES 5
#macro ONLINE_WEAPON_FRAMES 4
#macro ONLINE_HELMET_BASE 93
#macro ONLINE_GHOST_ALPHA 0.5
#macro ONLINE_GHOST_BOAT_ALPHA 0.85
#macro ONLINE_NAME_CITIZEN_COLOR make_color_rgb(65, 134, 175)
#macro ONLINE_NAME_PK_COLOR make_color_rgb(199, 16, 26)
#macro ONLINE_NAME_ARMADA_COLOR make_color_rgb(42, 187, 192)
#macro ONLINE_NAME_LEGION_COLOR make_color_rgb(202, 87, 97)
#macro ONLINE_BOT_LEVEL_LINE_OFFSET 11

#macro ONLINE_WORDS_SECONDS 3
#macro ONLINE_SPEECH_SECONDS 5

#macro ONLINE_LIVE_REPORT_MS 500

#macro ONLINE_TEST_COMBAT_X 656
#macro ONLINE_TEST_COMBAT_Y 2000

#macro ONLINE_DRAGONIC_SECONDS (SECOND * 60 * 24)

#macro ONLINE_ANIMATION_MS (1000 * 4 / SECOND)
#macro ONLINE_ATTACK_ANIMATION_MS (1000 * 10 / SECOND)
#macro ONLINE_INSIGNIA_OFFSET 12
#macro ONLINE_INSIGNIA_Y 3

#macro ONLINE_COLD_COLOR make_color_rgb(125, 220, 251)
#macro ONLINE_NPC_MOVE_REST_FRAMES 15
#macro ONLINE_NPC_DEFAULT_SPEED 2

#macro ONLINE_NPC_ANIMATION_MS (1000 * 6 / SECOND)
#macro ONLINE_TAME_DOUBLE_CLICK_MS (1000 * 15 / SECOND)
