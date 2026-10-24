// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function exportar_pj(_pj) {
	var _filename = "partida" + string(_pj) + ".ini";
	
	if (file_exists(_filename)) {
		
		var _file = file_text_open_read(_filename);
		var _full_text = "";

		while (!file_text_eof(_file)) {
			_full_text+= file_text_read_string(_file) + "\n";
			file_text_readln(_file)
		}

		file_text_close(_file);
		clipboard_set_text(_full_text)
		show_message_a("Los datos de tu pj se han copiado al portapapeles!")
	}else{
		show_message_a("Estas intentando exportar un pj que no existe... how?")
	}

}

function importar_pj(_pj){
	if (clipboard_has_text()){
		var _file = file_text_open_write("partida" + string(_pj) + ".ini")
		file_text_write_string(_file, clipboard_get_text());
		file_text_close(_file);
		with (obj_control_seleccionarPJ) cargarPJs(_pj);
	}else{
		show_message_a("Debes tener los datos codificados del pj copiados al portapapeles para importar.")
	}
}
