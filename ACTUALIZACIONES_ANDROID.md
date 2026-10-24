# Actualizaciones del cliente Android

El APK consulta una vez al arrancar la última publicación **estable** de
`BSG-Walter/Dragonic-AON-Cliente` mediante la API de GitHub Releases.
Compara el tag de la publicación con `GM_version`, que GameMaker obtiene
de las opciones de compilación de Android.

Cuando encuentra una versión superior, en el menú principal aparece un
aviso pulsable. Si el Release contiene un archivo cuyo nombre termina en
`.apk`, el aviso abre el enlace directo de descarga del archivo. En caso
contrario abre la página del Release para que el usuario pueda verlo.
La instalación del APK se confirma en Android; GameMaker no puede instalar
una actualización de forma silenciosa.

## Publicar una versión

1. Aumentar `option_android_version` en
   `options/android/options_android.yy` (por ejemplo, de `1.0.2` a `1.0.3`).
2. Compilar el APK con el **mismo identificador de aplicación y la misma
   clave de firma** que la versión instalada en los teléfonos.
3. En GitHub, crear un nuevo Release del repositorio
   `https://github.com/BSG-Walter/Dragonic-AON-Cliente`.
   Usar un tag numérico como `v1.0.3`, adjuntar el archivo `.apk` en
   **Assets** y publicarlo como Release estable (no Draft ni Pre-release).
4. Abrir el APK anterior: el aviso aparecerá al recibir la respuesta de
   GitHub y permitirá abrir el nuevo APK. Una instalación reciente no
   mostrará el aviso.

Si no hay Internet, GitHub devuelve un error o aún no existe ningún
Release estable, se omite el aviso y el juego puede iniciarse normalmente.
Los tags deben tener componentes numéricos separados por puntos, como
`v1.0.3` o `v1.0.10`; se comparan por componente y no alfabéticamente.
