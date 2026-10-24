/// @description  Paro la música y reproduzco la nueva

if (musicaAnterior != -1) {
    audio_stop_sound(musicaAnterior);
}

indxMusicaAnterior = nuevaMusica;

if (obj_opcion_musica.musicaActivada && instance_number(obj_pausa) == 0 && is_ingame_room()) {
    musicaAnterior = audio_play_sound(indxMusicaAnterior, 0, true);
    audio_sound_gain(musicaAnterior, 0.5, 0);
}


