/// @description  Cambiar dirección

if (obj_opciones.opcionAnimacionAgua) {
    var lay = layer_get_id("Background_Agua");
    if (lay != -1) {
        velocidadH += 0.001 * direccionX;
        layer_hspeed(lay, velocidadH);   
        
        if (abs(velocidadV) < 0.15) {
            velocidadV += 0.00025 * direccionY;
            layer_vspeed(lay, velocidadV);
        }
    }
}