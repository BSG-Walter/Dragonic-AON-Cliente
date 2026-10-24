/// @description  Creo el drop

if (pasos == 0) {

    if (inventario[indiceTirarItems].indice != -1) {  
		if (inventario[indiceTirarItems].indice < 164 || inventario[indiceTirarItems].indice > 211) { // Si no es armadura faccionaria...
	        var idItem = instance_create_depth(x, y, 0, obj_item);  
	        idItem.indice = inventario[indiceTirarItems].indice;
	        idItem.cantidad = inventario[indiceTirarItems].cant;
		}
    }
    
    if (indiceTirarItems == 19) {    
        indiceTirarItems = 0;
        alarm[11] = -1;
    } else {
        indiceTirarItems++;
        alarm[11] = 1;
    }
    
} else {
    alarm[11] = 1;
}
