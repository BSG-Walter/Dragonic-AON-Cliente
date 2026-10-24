# Continuidad del modo online — Dragonic AOff

Registro de continuidad del 9 de octubre de 2026, anterior a las migraciones de red. Para el protocolo **vigente**, leer primero `server/README.md` y `server/MIGRACION_EVENTOS.md` junto con `AGENTS.md` y [ONLINE_PARIDAD.md](ONLINE_PARIDAD.md). Las cifras de pruebas y compilación de este documento son resultados históricos, no el estado actual de la rama.

## Pedido y límites acordados con Walter

- Convertir el juego GameMaker offline en un mundo online compartido y persistente con servidor dedicado instalable. No tiene VPS ni dominio todavía.
- Conservar el offline. Se eligen e importan los personajes offline en la pantalla original; no exigir personajes nuevos para online.
- Cliente compatible con Android: GML y red nativa, sin DLL ni extensiones. El servidor puede usar Python.
- Se autorizó reestructurar y probar con varias instancias, incluyendo combate. No se pidió hacer commits ni publicar.
- Pedido del 9 de octubre: corregir pociones de Fuerza/Agilidad y revisar las funciones que faltan o difieren online. El pedido final fue terminar las diferencias confirmadas en este turno. El estado final y el alcance comprobado están en `ONLINE_PARIDAD.md`.

## Estado general

Hay servidor Python + SQLite, cliente WebSocket nativo de GameMaker, selección/importación de personajes, mundo exportado, combate, comercio/banco y bots compartidos. Los errores de la primera integración motivaron una segunda ronda de cambios. La revisión de paridad cerró las diferencias confirmadas. Las adaptaciones de un mundo compartido y los límites de validación están documentados; no afirmar una prueba exhaustiva de todas las combinaciones del juego.

El compilador oficial LTS2026 generó el build Windows sin diagnósticos. La suite completa pasó **92 pruebas**, incluidos **2.685 casos matemáticos** comparados con el runtime original. Log final: `server/test-results/python-final-parity4.log`. La última prueba con cinco runners aprobó en `server/test-results/game-20261009-111831/`; las partidas existentes conservaron sus hashes. Se regeneraron los 158 mapas en `server/test-results/export-20261009-110800/`. Se usaron cuentas, personajes y bases aisladas. Android real, WAN y carga no se probaron; la evidencia histórica del 8 de octubre permanece en `server/TESTEO.md`.

La integración anterior quedó en los commits `ba66b779` y `14bb38b1`. Las correcciones del 9 de octubre están en el checkout principal, sin commit. No hacer `git reset`, `git clean` ni reemplazar el proyecto por una copia antigua. `GUIA_LEVELEO.md` es del usuario y sigue sin seguimiento; preservarlo. No tocar la copia `.kilo/worktrees/loving-handspring` que aparece en algunas búsquedas.

## Correcciones y auditoría del 9 de octubre

[ONLINE_PARIDAD.md](ONLINE_PARIDAD.md) reemplaza la lista inicial de 29 pendientes con el estado final. Se corrigieron terreno/agua/polo y reaparición; combate/pociones/estados; supervivencia y relojes; experiencia/niveles/skills/multiplicadores; sacerdote y criminalidad; trabajos continuos, cinco especies de pesca y selección de fragua; doma, invocaciones y mascota; portales de bots, arena, Dragonic, orden de hechizos y presentación del cliente.

[ONLINE_COMBATE.md](ONLINE_COMBATE.md) conserva el detalle matemático y las 2.685 referencias nativas. Los cálculos originales offline no fueron reescritos. La rutina de transparencia de árboles/techos se comparte, y se bloquea la ejecución local de alarmas que el servidor resuelve online.

Se corrigieron conclusiones iniciales de la auditoría: los bots originales tienen XP cero; `IAAgarraItem` no reequipa automáticamente; el menú de torneo existente deriva a arena y no implementa rondas/resultados completos. No inventar esas funciones como arreglos de paridad.

Los relojes de energía/meditación y producción conservan sus períodos sin acumular el redondeo a ticks. El primer ataque de un NPC recién creado/reaparecido espera los 120–240 frames de Create; sus ataques posteriores usan el intervalo exportado.

## Herramientas y rutas en esta PC

Repositorio: `C:\Users\Walter\Documents\GitHub\Dragonic-AOff`.

Para todo recurso/código GameMaker usar MCP `gm_*`, como pide `AGENTS.md`; no TokenSave para GML. Lectura con `gm_file_read`, modificación con `gm_gml_write` y su `expectedSha256`; descubrir herramientas faltantes con `gm_discover_tools` y ejecutar con `gm_call_tool`. Para Python, documentación y Git usar herramientas normales. Preservar UTF-8 y no introducir un BOM a mitad del contenido al anteponer código.

Compilación:

```text
gm_call_tool: tool="gm_build", args={"timeoutMs":600000}
```

Build generado: `.gamemaker-mcp\temp\Dragonic AOff.win`.

Runner instalado:

```text
C:\ProgramData\GameMakerStudio2-LTS2026\Cache\runtimes\runtime-2026.0.0.23\windows\x64\Runner.exe
```

Python de la instalación del servidor: `server\.venv\Scripts\python.exe`, basado en Python 3.10 con `websockets` 16 instalado. Python 3.12 del entorno de Codex:

```text
C:\Users\Walter\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe
```

Para usar ese Python 3.12 con las dependencias instaladas:

```powershell
$env:PYTHONPATH = 'C:\Users\Walter\AppData\Local\Programs\Python\Python310\Lib\site-packages'
& 'C:\Users\Walter\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' -m unittest discover -s server -v
```

Los sockets/procesos de prueba requirieron ejecución fuera del sandbox. Se autorizaron mediante auto-review. No reutilizar PIDs viejos: comprobar identidad y argumentos antes de cerrar únicamente procesos creados por la prueba.

**Carpeta real de guardados:** `C:\Users\Walter\AppData\Local\Dragonic_AOff`. En el shell dentro del sandbox, `$env:LOCALAPPDATA` puede señalar un directorio distinto dentro de `Packages\sandbox...`; pasar la ruta real explícitamente a las pruebas.

Para UI Windows se usó la habilidad `computer-use` y `@oai/sky` desde `node_repl`, después de aprobación del usuario. Leer su documentación antes de usarla. Seleccionar una ventana exacta, observar, hacer una acción y volver a observar. La captura a veces mostraba la ventana que tapaba al Runner: `activate_window` y una nueva observación resolvieron eso. Los dos runners tienen el mismo título. Los toques de teclado muy cortos de la herramienta no siempre activaron movimiento; el control táctil sí. No interferir con entrada del usuario; una prueba manual de lanzamiento quedó interrumpida por detección de entrada humana y se validó la magia mediante los runners automáticos.

## Cómo ejecutar y reproducir

Servidor normal en loopback, puerto 8766:

```powershell
.\server\start.ps1
.\server\start.ps1 -Bots 0
.\server\start.ps1 -Bots 12 -BotDifficulty high -BotSimulateHours
```

Abrir GameMaker y ejecutar. Botón Online, `ws://127.0.0.1`, puerto `8766`, crear cuenta/entrar, elegir un personaje offline. Las siguientes conexiones recuperan la versión del servidor; no vuelven a importar el inventario offline. El progreso online no sobrescribe la partida offline. Dos jugadores requieren dos cuentas.

Instalación/despliegue: `server/README.md`, `install.ps1`, `deploy/dragonic.service` y `deploy/Caddyfile`. Internet usa `wss://` y certificado válido; loopback admite `ws://`. El servidor no necesita GameMaker instalado.

Pruebas de servidor:

```powershell
.\server\.venv\Scripts\python.exe -m unittest discover -s server -v
```

Después de compilar, prueba de cinco runners:

```powershell
.\server\test-game.ps1 -Runner 'C:\ProgramData\GameMakerStudio2-LTS2026\Cache\runtimes\runtime-2026.0.0.23\windows\x64\Runner.exe' -SaveDirectory 'C:\Users\Walter\AppData\Local\Dragonic_AOff'
```

Requiere puerto **9876** libre. Abre roles `a`, `b`, `offline`, `form`, `shop` durante unos 40 segundos, verifica sus informes, acciones de combate/movimiento/chat, efectos y sonidos online y hashes de las partidas existentes. Cierra sus propios procesos. Los resultados van a `server/test-results/game-FECHA/`. Los informes y capturas resumidos se conservan en `server/evidence/`.

Fixture manual con dos cuentas y latencia, para un próximo chat:

```powershell
.\server\.venv\Scripts\python.exe .\server\manual_fixture.py --directory .\server\test-results\manual-nueva --latency 200 --duration 900
```

En otros procesos abrir Runner con `-game "RUTA_ABSOLUTA_DEL_BUILD" --online-test manual_a` y lo mismo con `manual_b`. Elegir un directorio nuevo para tener una base limpia. Estas cuentas son exclusivamente fixtures. El cliente crea `online_fixture_manual_a.ini`/`manual_b.ini`, nunca una `partidaN.ini`.

Control del fixture: escribir UTF-8 `controls.json` en ese directorio con uno de estos objetos:

```json
{"phase":"walk"}
{"phase":"shop"}
{"phase":"bank"}
{"phase":"death","n":1}
{"phase":"death","n":2}
{"phase":"water"}
{"phase":"combat"}
{"phase":"stop"}
```

Cada JSON distinto se aplica una vez; incrementar `n` para repetir. `walk` coloca a ambos en un corredor; `shop`/`bank`/`death` acercan manual_a al NPC adecuado; `water` deja al fantasma junto al agua con barca y runa; `combat` coloca jugadores, dos bots y un lobo compartido en rm_78. Los bots del escenario de combate tienen movimiento congelado temporalmente, pero sí pueden atacar. Esta fixture no mide por sí sola su movilidad normal.

El fixture escribe `status.json`; cada cliente manual escribe `online_live_manual_a.json`/`manual_b.json` en la carpeta real de guardados: posición local y del servidor, epoch, secuencia/ack, muerte/barca, pausa/panel, oro, inventario, contadores de efectos/acciones/sonidos y cantidad de bots locales. `latency 200` introduce 100 ms en cada dirección. El fixture final de este chat fue `server/test-results/manual-final/`; no reutilizar sus PIDs. La ubicación de combate se corrigió al final a x656,y2000 en rm_78, sobre tiles de bosque, igual que el smoke y la fixture offline.

## Mapa del código

| Archivo/objeto | Responsabilidad |
| --- | --- |
| `server/server.py` | Entrada pública del servidor; los módulos `network.py`, `world_*.py`, `state_events.py`, `state_delivery.py` y `wire.py` implementan eventos, reglas y WebSocket binario |
| `server/bots.py` | Simulación compartida de los jugadores IA portados de obj_persona |
| `server/bot_rules.json` | Tablas extraídas del original: nombres, armaduras, armas y factores por mapa |
| `server/world.json` | 158 mapas, colisiones/portales/NPCs/comercios/recursos, items, hechizos y recetas exportados |
| `server/test_server.py`, `test_bots.py` | Regresiones de red/mundo y bots |
| `server/smoke_server.py`, `test-game.ps1` | Fixture automática y cinco clientes reales |
| `server/manual_fixture.py` | Fixture controlable con latencia simulada |
| `scripts/scr_online_session`, `scr_online_state`, `scr_online_receive`, `scr_online_player` | Conexión binaria, aplicación incremental de estado, recepción de eventos y acciones del jugador |
| `scripts/scr_online_ui/scr_online_ui.gml` | Formulario de conexión, chat y avisos; se retiró el comercio personalizado |
| `scripts/scr_online_test/scr_online_test.gml` | Roles de prueba, reportes/capturas y creación de personajes de fixture |
| `obj_online` | Gestor persistente; async de red, Step, Draw GUI y coordinación de cambios de room |
| `obj_online_actor` | Representación e interpolación de otros jugadores, bots, NPCs y botín |
| `scripts/scr_online_export`, `obj_online_export` | Exportación de mundo/catálogos sin simulación offline |
| `datafiles/online_catalog.json` | Comercios por room, asset, posición e índice; debe coincidir con world.json |
| `scripts/scr_partida_lectura` y `scr_partidas` | Lectura descifrada en memoria y guardado sin temporal compartido entre procesos |
| `scripts/declaraciones` | Macros de red/dibujo/pruebas; definir allí constantes nuevas de GML |

**Protocolo actual:** versión 4, exclusivamente tramas WebSocket `BINARY`. Cada mensaje empieza con un `uint16` little-endian que identifica la operación; los campos restantes se codifican con valores tipados (`int32`, `float64`, booleanos, UTF-8, arrays y mapas). No circula JSON ni existe refresco completo periódico. Al entrar o cambiar de mapa se emiten `world_reset`, `self_state` y `actor_spawn`; después únicamente `self_state` parcial, `actor_patch`, `actor_remove`, `position`, confirmaciones y eventos de juego según cambios reales. Se conservan secuencias y generaciones para descartar paquetes rezagados. `world.json` y SQLite siguen siendo independientes del formato de red. Ver `server/README.md`.

SQLite: tablas accounts (scrypt), characters (estado JSON por cuenta/nombre), world (estado JSON por mapa). Los bots se guardan en `world.state.bots`. Se persisten transacciones económicas y el mundo periódico; al salir se guarda el personaje. `backup.py` usa la API de backup SQLite y está probado con el servidor activo. No incluir una base de cuentas reales o sus contraseñas en logs ni en el contexto del agente.

## Correcciones de la segunda ronda y evidencia

### Hallazgo final de terreno: máxima prioridad para continuar

Walter observó correctamente que las capturas de combate estaban en agua. La fixture buscaba el primer bloque de celdas que `World.walkable` consideraba libre y encontraba x400,y400 de rm_78. **Esa posición muestra el fondo de agua y no es tierra.** El diagnóstico nativo `place_meeting` devuelve false tanto para agua como para bloque sólido allí: los objetos obj_bloqueo_agua del mapa forman barreras en la orilla (en rm_78 alrededor de y1840), no cubren todo el interior de agua.

El exportador actual clasifica `cells` consultando esos objetos; por tanto ciertos interiores de agua aparecen como `1` (tierra libre). Este defecto puede afectar spawns de bots/NPCs, find_free, barcos y validación de posición. **No está corregido globalmente.** Bloquear bien la orilla en el cliente no demuestra que el catálogo del servidor describa todo el terreno.

Se corrigieron las fixtures de combate online, manual y offline a x656,y2000: `rooms/rm_78/rm_78.yy` contiene un tile ts_pisos_bosques desde (640,1920) de 128x128 que cubre esa posición. Las capturas finales deben mostrar bosque/tierra; se agregaron los campos terrain_water/terrain_blocked a los informes y se exigen sin colisiones inválidas. Eso corrige la ubicación de la prueba, no el mapa exportado completo.

Siguiente cambio prioritario: exportar tierra/agua a partir de las superficies reales del mapa, además de sus barreras; examinar `Tiles_Pasto`, `Tiles_Pisos`, fondos, sprites/rectángulos de assets y el helper `tile_layer_find`. Tener en cuenta interiores con fondo de tierra y costa/decoración, no asumir que ausencia de un tile siempre es agua en todos los mapas. Reexportar world.json/catalog y comprobar puntos de tierra y agua nativos en varios mapas antes de usarlo para spawns. Verificar también bots almacenados y NPCs que hayan quedado en posiciones inválidas. Revisar las pruebas Python que elegían posiciones basándose sólo en walkable; pueden haber usado zonas visualmente acuáticas.

### Movimiento

`online_caminar` usa la caminata original: colisiones locales y los 13 pasos/frames por tile. Envía dirección y endpoint al comenzar el paso. La posición recibida se procesa por eventos `position` y `self_state`; las correcciones de `position_epoch` y los reinicios explícitos de generación evitan rebobinar movimientos locales o aplicar eventos de otra sala.

Servidor valida desplazamiento adyacente, terreno y velocidad sostenida; tolera dos tiles de crédito temporal para jitter. No detiene cada paso por ocupación de otros jugadores. Si recibe coordenadas inválidas incrementa epoch y el cliente se reposiciona; órdenes de una room/epoch vieja se descartan. Portal, runa y barca incrementan epoch. Esto evita confundir paquetes en vuelo con movimiento posterior al teleport.

Se probaron secuencias con jitter, velocidad abusiva/posición inválida y epochs viejos. En dos clientes con 200 ms, manual_b pasó de x=944 a 976 y 1008, y permaneció en epoch=2; los acks siguieron las dos órdenes y las posiciones local/servidor coincidieron. **No se hizo una medición de caminata continua sostenida bajo latencia alta o pérdida de paquetes**: conservarlo como próximo ensayo, no afirmar una certificación de fluidez universal.

### Sonido y magia

Servidor emite `action` solamente para acciones aceptadas. Cliente `online_efecto` reproduce objetos de efectos y sonidos originales sobre la entidad correspondiente. La reproducción antes se evaluaba desde el manager en (0,0) y era descartada por distancia; ahora se ejecuta con el personaje/NPC fuente o destino. `damage` también reproduce impactos. Actores remotos tienen palabras mágicas temporales, animación de ataque y pasos/barcas.

Hay contadores de acciones/efectos/audio para las pruebas; audio se cuenta cuando se obtiene un handle válido. Los cinco runners ahora exigen efectos y audio positivos en ambos clientes online. No equivalen a una grabación y escucha auditiva de todos los sonidos. En la fixture manual se observaron efectos de los bots y sonidos/teleports, pero el último lanzamiento manual de jugador fue interrumpido por entrada humana; apoyarse en la prueba automática para ese caso.

### Pausa y comercio

Pausa online tiene profundidad por encima de las interfaces nativas; Draw GUI online se oculta mientras está abierta, y controles/inventario/paneles/NPCs bloquean entrada. El manager de red sigue activo y el mundo compartido continúa. Se comprobó visualmente que tapa el inventario y que el botón Volver permite regresar.

Se eliminaron la pantalla de tienda con Confirmar y sus handlers. Los Steps originales de comerciantes y banquero abren `obj_panel_items`; selección, cantidad y flechas siguen nativos. Step/Alarm del panel envían buy/sell/deposit/withdraw al servidor antes de modificar inventario/oro localmente. `online_npc_index` identifica el NPC por catálogo, asset y posición.

Se abrió el armero por doble clic y se compró desde la flecha original. Esa prueba detectó que el precio mostrado era 666 y el servidor cobraba 444. El servidor ahora calcula exactamente el multiplicador de Comercio del panel original: precio base * 2 / factor, con factor 1..2 y bandas originales. Hay una prueba de todos sus límites 0,10,11,...99,100. La prueba interactiva anterior al ajuste no demuestra el nuevo importe; sí lo valida la regresión del servidor.

El sacerdote usa su Step original: doble clic envía resurrect, sin panel; mantener pulsado envía home. Se reinicia dobleClic para permitir sucesivas resurrecciones. Se comprobó una resurrección real y se ejercitó una segunda interacción; la prueba Python comprueba dos muertes y dos resurrecciones. El rey, Lord Thek y herrero experto también envían sus acciones al servidor desde su interacción nativa. Falta repetir visualmente las tres interfaces especiales y banco después de todos los cambios finales.

### Muerte, agua y dibujo

El servidor ya no permite que ghost ignore el terreno de agua. El cliente conserva colisiones de agua y permite seleccionar/usar barca o runa estando muerto. Barca cambia de orilla a agua y funciona con sprite fantasmal. Runa se usa muerto, vuelve al hogar, deja navegación y no se consume. Se comprobaron las tres acciones en el Runner final: entrar sin barca no emitió movimiento, la barca se activó y la runa volvió de rm_4 a rm_79 conservando item145 cantidad1.

Actores remotos usan raza/género/equipo para el cuerpo; offsets nativos de cabeza alta36, baja28 y fantasma27; casco, arma corta y barca tienen sus condiciones nativas. Falta una matriz visual exhaustiva de todas las razas, sexos y equipos. No reutilizar el sprite_index capturado para dibujar un vivo que antes fue fantasma/barca.

### Bots

Se encontró un spawn local que escapaba a los primeros guards: Alarm1 de obj_respawn_personas. Ahora está bloqueado online/exportación y Create de obj_persona centraliza la protección. Los reportes online muestran `local_bots=0`.

`server/bots.py` implementa creación por nivel/clase/raza/género, nombres/equipo, ciudadano/PK/facción, objetivos humano/bot/NPC, prioridad de rivales inmovilizados, movimiento, navegación desde nivel25, pociones, parálisis/remover, ataque/magia/arco, diálogos/enojo ciudadano, muerte/botín y reemplazo. Cantidad predeterminada CLI6 mundial; World por defecto0 facilita fixtures. Dos clientes reciben los mismos IDs/estado; se prueban persistencia, desactivación y colisiones al desactivar. Configuración normal/high y simulación de horarios desde CLI/start.ps1. Las excepciones aceptadas de diseño están registradas en `DIFERENCIAS_ACEPTADAS_OFFLINE_ONLINE.md`.

Fórmulas de pociones: **en online se curan hasta 100 % de HP** (decisión deliberada), priorizando salud frente a maná; cada uso cura `floor(grado * 10 % * saludMax)` o restaura `floor(grado * 20 % * manaMax)` y espera `floor(25 / grado) / 60` segundos, o `floor(100 / grado) / 60` en reposo. Offline usa un umbral de HP de `floor(max * (.35 + grado * .5))`. No gastan botellas. Tablas de armadura/arma están extraídas de GML; online la población es global y persiste sin depender de la proximidad de un jugador.

Se corrigió un dereference de target=None que podía matar el ticker en mapas inseguros sin enemigos; cast ahora maneja reposo/remover antes del objetivo. También se corrigió el cooldown del ataque a NPCs, la elección de arco para cazadores, la condición de inmovilizar NPCs (no Dragonic), la probabilidad al objetivo estacionario y la muerte repetida que duplicaría botín/bajas. Las pruebas incluyen 120 segundos de simulación con bots sin objetivo y combates de las tres clases, además de equipos a niveles1..47.

**Estado tras la revisión de paridad:** los bots persiguen por portales y cambian entre las listas de mapas; la recogida se reactiva por distancia/probabilidad. La arena puede agregar bots de ambos bandos incluso con población automática cero. Las tablas de equipo y ataques conservan las reglas originales, con las excepciones de curación y mundo persistente documentadas. En mapas normales, los PK respetan una tregua entre ellos mientras haya un ciudadano vivo y durante 5 segundos desde que deja de haber ciudadanos.

La IA offline utiliza algunas estadísticas del único `obj_pj`; online los bots conservan las bandas de skills de su creación y toman su propio nivel cuando no atacan a un humano. No hay una partida offline equivalente con varios clientes para certificar esta adaptación como literal. Tampoco se midió carga o capacidad; 300 es la población objetivo CLI predeterminada. Reducir un límite positivo no borra automáticamente bots existentes; cero los desactiva, con excepción de bots agregados manualmente en arena.

Fuentes para seguir comparando por MCP: obj_persona/Create, Step y Alarm4/5/7/8; elegirEquipoIA, elegirIAObjetivoIA, cantidadIARivalCerca, IAAtacaAPJ, esRival, calcularDanoMagicoIAaNPC/IA, calcularDanoArcoIAaNPC, calcularDanoMeleeIA*, setearIntervaloCreacionIA, obj_personas_mundo/Step e IAsSiguenAlOtroMapa. Buscar sólo en el proyecto principal. Algunas ramas originales tienen comportamientos aparentemente erróneos; documentar si se conserva o cambia cada regla.

## Datos de prueba y precaución con partidas

Durante la primera ronda, anterior a estos ajustes, la lectura vieja descifraba/regrababa usando un temporal compartido. En pruebas simultáneas desaparecieron partida1.ini, partida1_BackUp.ini y partida2.ini. Se recuperaron desde copias preexistentes; **no se certificó que esas copias tuvieran exactamente el progreso más reciente**. Está documentado en `server/TESTEO.md`; no omitirlo ni decir que jamás hubo un incidente.

La lectura nueva descifra en memoria y el guardado tiene temporal por proceso, backup y reversión. Las pruebas posteriores compararon los hashes SHA-256 de 12 archivos de partidas/copias, incluidos los tests finales; permanecieron iguales. No abrir ni modificar las partidas personales para probar. Usar siempre los archivos `online_fixture_*`, bases temporales y capturar hashes antes/después.

La importación inicial acepta archivos offline dentro de límites: el usuario puede haber editado su personaje. Reimportar uno existente no restaura oro/items del archivo; el servidor recupera su estado guardado. Para una comunidad competitiva se necesitaría una política de importación, pero el usuario pidió admitir personajes offline y eso se mantiene.

## Continuación

Leer este archivo, `AGENTS.md` y `ONLINE_PARIDAD.md`; revisar `git status` antes de cambiar código. Las correcciones están sin commit en el checkout principal. No repetir la lista antigua de pendientes como si siguiera vigente.

Si se cambia GML, compilar con el toolchain oficial. Si cambia una regla del servidor, ejecutar sus regresiones; repetir runners cuando el cambio afecte integración/cliente. Usar únicamente fixtures aisladas y mantener las comprobaciones de hashes.

Para usar esta versión, ejecutar el build nuevo y reiniciar un servidor que todavía conserve el proceso anterior. No se inició ni reinició un servidor de producción durante esta revisión. Los scripts de prueba cerraron sus propios procesos.
