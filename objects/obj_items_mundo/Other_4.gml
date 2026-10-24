if (online_activo()) exit;
/// @description  Creo los Items

datosItem = ItemsXRM[room, 0];

if (datosItem.x != -1) {
    
    with (obj_item_basic) {
        instance_destroy();
    }
    
    var tamano = array_length(ItemsXRM[room]);

    for (var j = 0; j < tamano; j++) {
        if (datosItem.x != -1) {
            if (datosItem.indice != -1) {
                var idItem = instance_create_depth(datosItem.x, datosItem.y, 0, obj_item); 
                idItem.indice = datosItem.indice; 
                idItem.tipo = datosItem.tipo; 
                idItem.cantidad = datosItem.cantidad;
            } else {
                var idItem = instance_create_depth(datosItem.x, datosItem.y, 0, obj_oro); 
                idItem.valor = datosItem.valor;
            }
        }
        idItem.noSetearAlarm = true;
        if (tamano > j + 1) {
            datosItem = ItemsXRM[room, j + 1]; 
        }
    }
    
}
