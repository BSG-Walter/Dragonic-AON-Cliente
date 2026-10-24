/// @description  puedeInvocarMascotas()
function puedeInvocarMascotas() {

	for (var i = 0; i < obj_hechizos.maximoHechizos; i++) {
		if (obj_hechizos.hechizos[i].indice == 19)
			return true
    }  

	return false

}
