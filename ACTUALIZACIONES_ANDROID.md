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

El modo offline siempre se puede iniciar. Para entrar al modo online Android
debe completar la comprobación de versión: si GitHub no responde o hay una
versión más reciente, no permite iniciar sesión hasta verificar de nuevo al
abrir el juego, o instalar el APK nuevo. Si aún no existe ningún Release
estable (HTTP 404), se permite jugar con la versión actual del APK.

El servidor Go de producción también valida la versión anunciada por el
cliente en el login, utilizando la misma API de GitHub (con caché de dos
minutos). En `server-go/server-config.json` se activa mediante
`require_latest_client_version: true`. En el servidor de desarrollo local
queda desactivado para las pruebas. Un Release nuevo puede tardar hasta dos
minutos en ser exigido por un servidor que ya estaba encendido.

Los tags deben tener componentes numéricos separados por puntos, como
`v1.0.3` o `v1.0.10`; se comparan por componente y no alfabéticamente.
