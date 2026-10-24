# Paridad online — revisiones de octubre de 2026

Se corrigieron las diferencias confirmadas en la revisión de los sistemas originales y se regeneró el mundo desde GameMaker. Los números de la tabla conservan la referencia de la primera auditoría del 9 de octubre. Esta tabla reemplaza su antigua lista de pendientes: también corrige tres conclusiones que no correspondían al código offline.

**Excepciones deliberadas a la paridad:** consultar [DIFERENCIAS_ACEPTADAS_OFFLINE_ONLINE.md](DIFERENCIAS_ACEPTADAS_OFFLINE_ONLINE.md) antes de ajustar la curación de los bots, su aparición o las reglas multijugador.

## Revisión adicional del 18 de octubre

La revisión sobre el servidor de eventos binarios v4 y el mundo compartido incorporó reglas offline todavía no cubiertas y protección de estados bajo concurrencia:

- **Combate frontal:** los ataques cuerpo a cuerpo validan la casilla hacia la que mira el personaje; arcos y hechizos mantienen su alcance independiente de orientación. El servidor rechaza comandos manipulados que intenten golpear a los costados o detrás.
- **Mascotas:** al morir una mascota domada se libera inmediatamente su espacio, desaparece de la sala y se conserva el evento de daño. Al cruzar mapas o entrar en una ciudad se almacena su vida actual; un destino ocupado no provoca una excepción en el servidor.
- **Invocaciones:** la casilla seleccionada debe ser tierra y se normaliza a la posición usada por el cliente offline. Guardar mascotas con el hechizo 19 no consume maná, pero sí requiere energía suficiente, aplica su coste de energía y respeta la espera entre hechizos. Invocar las mascotas guardadas sí consume maná.
- **Movimiento y portales:** los cambios de mapa hacia destinos llenos se rechazan sin modificar parcialmente sala/época; los NPC esperan sitio para reaparecer, y un bot que no puede cruzar continúa en su sala. Meditación, barca y runa respetan las restricciones de movimiento. La runa reserva primero una casilla libre en el hogar, evitando desincronizar al jugador si el destino está lleno.
- **Objetos en el suelo:** un drop desplazado por otra pila permanece en el mismo tipo de terreno y busca una casilla que no esté ocupada por una criatura o jugador. Una operación rechazada por falta de espacio conserva el inventario.
- **Arena online:** los jugadores y bots pueden atacar a cualquier participante independientemente de su estado PK, facción o seguro. Melee, arco y hechizos hostiles respetan únicamente las condiciones normales de alcance, recursos y tiempos. Las muertes dentro de `rm_arena` no generan botín ni incrementan `ciudadanosMatados`/`criminalesMatados`, y no aplican penalización PK. Los bots de arena derrotados se retiran después del evento de muerte sin viajar a sacerdotes y liberan su plaza de aparición; las reglas del mundo exterior y de la arena offline siguen independientes.
- **Personajes online separados:** cada cuenta posee sus propios nueve espacios y sus personajes se crean, seleccionan y persisten en SQLite sin leer ni importar los archivos `partidaN.ini`. Se reutiliza la interfaz visual original de creación/selección, pero no su almacenamiento offline. El servidor asigna los datos iniciales y bloquea nombres ya pertenecientes a otra cuenta. Se preservan los personajes históricos ya guardados online.

La referencia conceptual del servidor original VB6 de AO Libre se consultó en `reference/upstream-server/Codigo` del proyecto AOGML. Las probabilidades de escudo PJ contra bot y los márgenes originales de reaparición resultaron **correctos** tras cotejarlos con el GML y no se modificaron. Las reglas específicas de Dragonic prevalecen sobre las convenciones de AO Libre.

Las **269 pruebas integradas** de la última pasada del servidor terminaron sin fallos (una omitida por configuración). Entre ellas hay una prueba de dos clientes WebSocket reales sobre v4 para rechazo y aceptación de ataques según dirección, y otra del cierre del servidor con cinco conexiones abiertas y 500 ms de retardo artificial. La limpieza diferida de objetos del registro de mutaciones y la búsqueda por perímetro de casillas libres cuentan con pruebas específicas. Después se compiló una copia GameMaker con directorio de guardados propio y se ejecutaron cinco escenarios aprobados de **cinco Runners reales**: dos mixtos (A+B online, offline, formulario y tienda) a 0 y 200 ms y tres de **cinco jugadores online simultáneos**, a 0, 200 y 500 ms de retardo artificial. Todos aprobaron y no alteraron las partidas personales. Detalles en `server/TESTEO.md`.

## Cambios terminados

| Hallazgos | Sistema | Resultado |
| --- | --- | --- |
| Pociones | Fuerza, Agilidad y consumibles | Cuatro dosis de +1, plazo compartido de 90 segundos, renovación, avisos, HUD y vencimiento persistente. Curación, antídoto, Remover e invisibilidad respetan requisitos, consumo y redondeos originales. |
| 1 | Terreno | Los 158 mapas se exportaron usando las superficies reales de agua. Se incluyen zonas de entrada/salida al polo y casillas nativas de reaparición. Se reubican NPCs/bots persistidos sobre terreno incompatible. |
| 2–7 | Combate | Tablas reales de armas/flechas, redondeos intermedios, defensa por equipo/objetivo, puñalada, magia/curación, puntería, evasión, escudo y estados. Flecha217 paraliza sin daño común; Dragonic mantiene su inmunidad. Se conserva el daño completo del último golpe. Ver `ONLINE_COMBATE.md`. |
| 8 | NPCs | Exportación de daño mágico, cantidad de veneno, intervalo de ataque, efecto y familia paralizante. Pueden combinar melee y magia en su alarma; Inmovilizar conserva sus ataques y Paralizar los detiene. Persecución por eje vertical primero, velocidad según `spd`, reposo sin caminata aleatoria añadida. Reaparecen al siguiente tick, en terreno nativo válido, con vida/XP/estados restaurados. La destrucción acuática respeta su excepción sin botín terrestre. |
| 9–12 | Supervivencia | Veneno según el atacante cada cinco segundos; frío de 15–30 cada segundo sin abrigo; energía del 15% cada 45 frames con ropa, comida y agua. Hambre/sed bajan diez cada 180–240 segundos. Se retiró la regeneración pasiva de vida inventada. Meditación usa skill ×1.15 cada 25 frames, impide caminar y conserva las interrupciones originales. Sus relojes compensan la discretización del tick sin acumular retraso. Veneno/frío mantienen los colores originales. |
| 13–14 | Skills | Crecimiento natural por actividad, probabilidades originales, factor compartido, límite por nivel y avisos. El botón de restituir puntos funciona y no permite retirar crecimiento natural; la referencia se renueva al abrir el panel. |
| 15–16 | XP, niveles y economía | Bolsa de XP decreciente por enemigo; multiplicadores compartidos; aumento de salud con Constitución y maná según clase/raza/Inteligencia. La subida descarta sobrante de XP, repone vida/maná, conserva energía actual y aumenta su máximo. Se eliminó la segunda multiplicación ×20 del oro: los valores exportados ya contenían el modificador base nativo. |
| 17–18 | Sacerdote y criminalidad | Ataque/penitencia del sacerdote resueltos por el servidor, también contra bots PK visibles. Conversión inicial una sola vez, asesinato de ciudadano con PK permanente, bajas y excepciones de arena. Las alarmas locales dejan de disputar autoridad al servidor. |
| 19–21 | Profesiones | Tala, minería, pesca, fragua y fabricación continuas con producción, crecimiento y tiempos originales, incluidos los retrasos iniciales. Pesca contempla las cinco especies, probabilidades, barca y red. Fragua consume el mineral seleccionado, cambia de selección sin reiniciar la alarma y se cancela al seleccionar otro objeto. Fabricación se cancela al soltar el botón/cerrar el panel. Materiales se validan antes de modificar inventario; órdenes del cliente no pueden omitir esperas usando el indicador interno de repetición. |
| 22–23 | Doma y criaturas | Doble clic para domar/abandonar; skill ×Carisma/6 y probabilidad original. Tres mascotas y restricciones por criaturas activas. Guardar mascotas no consume maná, conserva salud y sí requiere energía y aplica la espera de hechizo. Invocaciones de 90 segundos, reemplazos, Lord Zombie, límites de elementales, objetivos del dueño y limpieza al morir. |
| 24 | Bots | Persecución por portales con orientación, destinos y nivel requeridos; cambio entre las listas de mapas del mundo compartido. Reactivación del botín según distancia/probabilidad. Se conservaron las tablas de creación/equipo y los comportamientos ya implementados. |
| 25 | Arena | Entrada existente y botones para agregar bots de ambas apariencias PK; funcionan sin población automática. En la arena online todos se atacan entre sí sin distinción de PK, seguro ni facción. Las muertes no dejan equipo, no cuentan para ascensos de facción ni producen PK permanente; los bots caídos liberan su lugar. La arena offline conserva su cooperación por bandos. |
| 26 | Dragonic | Importación del plazo del encargo offline, persistencia sin sobrescribirlo al reconectar, progreso sobre las 24 horas reales y estado inactivo después de entregar. |
| 27 | Hechizos | Orden guardado como permutación validada del conjunto aprendido; se recupera al reconectar y se aplica también cuando la cantidad no cambia. |
| 28–29 | Presentación | Árboles/techos usan la misma rutina visual en ambos modos. Insignia y rango remoto, frames de cuerpo/arma y animación de ataque; NPCs usan sus propias filas e intervalo de animación. Sonidos de profesiones/pasos y efectos de NPCs/sacerdote funcionan sin exigir campos exclusivos de casts del jugador. Se conservó la retirada deliberada de barras/encabezados remotos. |

Fuentes principales: `server/server.py`, `server/bots.py`, `scripts/scr_online`, `scripts/scr_online_export`, eventos de personaje/inventario y paneles originales. El offline conserva sus cálculos; sólo se comparte la rutina visual y se bloquean alarmas locales cuando el servidor tiene autoridad online.

## Correcciones a la primera auditoría

- **XP de bots:** `obj_persona/Create_0` inicia `experiencia = 0`. No corresponde inventar una recompensa por matarlos como supuesto arreglo de paridad.
- **Equipo del botín:** `IAAgarraItem` añade objetos; el original no reequipa automáticamente todo lo recogido. Se corrigieron portales y reactivación de recogida, sin añadir esa regla.
- **Torneos:** la referencia inicial a `obj_room_nombre/Mouse_53` correspondía a escritura del nombre, no a rondas de torneo. El menú existente deriva a la arena y las ramas de notificaciones/torneo no contienen un organizador completo de rondas/resultados. Se portó la arena funcional existente; no se presenta un torneo nuevo como una función perdida.
- **Meditación:** la recuperación está en `obj_meditacion/Alarm_0`; `obj_pj/Alarm_7` corresponde al veneno.

## Validación final

- **92 pruebas** aprobadas en Python 3.10/websockets16: `server/test-results/python-final-parity4.log`. Incluyen regresiones que distinguen las reglas anteriores de supervivencia, progresión, profesiones, criaturas, arena, sacerdote, portales y reaparición.
- **2.685 casos matemáticos** obtenidos de las funciones originales ejecutadas en GameMaker, reproducidos con las mismas tiradas y resultados enteros en Python: `server/tests/combat_native.json` y `server/test_combat.py`.
- Compilación Windows mediante el compilador oficial GameMaker LTS2026 aprobada, sin diagnósticos.
- Exportación de **158 mapas**, con agua, magia, zonas polares y `spawnCells`: `server/test-results/export-20261009-110800/`. Catálogo de interacción actualizado junto con `server/world.json`.
- **Cinco runners reales aprobados**: `server/test-results/game-20261009-111831/`. Dos clientes online, offline, formulario y comercio. Ambos online vieron al otro jugador, el dopaje y sus contadores, efectos y audio; la corrida aceptó chat, movimiento, consumibles, arco, melee y magia.
- Los hashes de las partidas y copias personales existentes quedaron iguales en las pruebas de exportación y runners. Las bases y personajes usados fueron aislados.
- `git diff --check` sin errores.

## Alcance de la equivalencia

La revisión cerró las diferencias confirmadas anteriores; las pruebas no son una demostración exhaustiva de cada combinación de todo el juego. No se ejecutó Android real, WAN, pérdida de paquetes, carga de muchos jugadores ni una caminata manual por cada casilla de los 158 mapas.

El offline tiene un solo `obj_pj`. El PvP entre humanos y las estadísticas globales que algunos ataques de IA tomaban de ese observador requieren una adaptación en el mundo compartido: los bots conservan bandas de skills de su creación y usan su nivel cuando el objetivo no es humano. Se conservan validaciones de alcance, obstáculos y zonas seguras del servidor. No existe una ejecución offline equivalente con dos clientes humanos para certificar esa parte como literal 1:1. El servidor simula en ticks de 100 ms; el cliente interpola y los temporizadores de producción/recuperación conservan sus períodos nativos.

Para usar los cambios, ejecutar el nuevo build y reiniciar cualquier servidor que aún esté usando el proceso anterior. No se borraron cuentas ni se reinició el progreso normal durante esta revisión.
