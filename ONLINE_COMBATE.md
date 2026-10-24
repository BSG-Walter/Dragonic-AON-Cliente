# Combate online: revisión del 9 de octubre de 2026

El rango excesivo de daño tenía dos causas confirmadas: las descripciones de los ítems no contienen las tablas que realmente usa el combate offline, y el servidor omitía sus redondeos intermedios. Además, el último golpe mostraba sólo la vida restante del objetivo, introduciendo golpes aparentemente muy bajos.

## Correcciones

| Regla | Antes online | Ahora |
| --- | --- | --- |
| Armas del jugador | Rangos extraídos de `description` | Tablas de `calcularDanoFisicoPJ` para armas 0–17 y arcos 21–27; arma sin equipar tiene su rama original |
| Aleatoriedad física | Poder del arma continuo | `floor(random_range(...))` para el arma, conservando el rango continuo del daño base |
| Redondeos | Casi todo se multiplicaba antes de convertir a entero | Redondeo en cada etapa original: arma/base, clase, Fuerza, defensa y nivel |
| Fuerza/Agilidad | Dopaje ya corregido en la primera revisión | Se conserva +1 por dosis, hasta cuatro; no se cambia el valor de las pociones |
| Puñalada | Ausente | Bonus de dagas de Asesino/Bardo, probabilidades por skill/clase, crítico ×3.4, redondeos y texto dorado |
| Daño recibido de NPCs | Restaba el mínimo de la ropa | Tiradas de defensa originales para ropa/casco/escudo, incluidas prendas de facción/Dragonic del jugador; escala ×1.5 de `calcularDanoFisicoNPC` |
| Daño a personas IA | Defensa mínima de la descripción | Tabla específica de `calcularDanoFisicoPJ` contra `obj_persona`, con factor .95 antes del modificador de nivel |
| Magia y curación del jugador | Valores base o factor de Inteligencia inventado | Factor 2.30 y modificadores de báculos/laúd de `calcularDanoMagicoPJ`; curación utiliza la misma fórmula y respeta el máximo de vida |
| Magia recibida | Ignoraba parte de la mitigación | Sombreros y bandas de Resistencia Mágica, con los redondeos de `calcularDanoMagicoNPC`; NPC→bot utiliza su variante |
| Bot atacante | Algunas etapas/defensas y ramas de arco distintas | Defensa compartida con las tablas originales, orden de redondeo, modificador del jugador defendido y variantes de báculo/daño entre bots |
| Último golpe | Evento limitado a la salud restante | Se muestra el daño completo; la salud queda en cero y se descuenta la bolsa de XP del enemigo con la proporción original |
| Arco | Espera de 50 frames | 35 frames; melee conserva 50 y magia 42.5 |
| Flecha217 | Entraba en una fórmula de daño de flecha común | Consume munición y aplica parálisis sin daño normal; Dragonic conserva inmunidad |
| Paralizar/Inmovilizar | Ambos congelaban toda la IA por cinco segundos | NPCs: 120 segundos, Paralizar detiene sus acciones e Inmovilizar deja atacar; personas: inmovilización de 30 segundos y posibilidad de Remover |
| Defensa física | Evaluaba evasión antes del escudo en algunas rutas | NPC/bot→jugador comprueba escudo y luego Tácticas; arco de bot tiene sus umbrales propios |
| Skills de combate | Algunas subían con probabilidad .07 y otras no subían | Disparadores base de Magia, armas/arco/sin armas, Apuñalar, Tácticas, Escudo y Resistencia; aviso naranja al jugador |
| Estadísticas importadas | Sólo deducía modificadores por clase/nivel | Importa y conserva rango base y modificadores originales, validando números; una reconexión no los vuelve a importar. El modificador de daño aumenta .0053 al subir nivel |

Ejemplo sin puñalada, sin defensa del objetivo, Guerrero nivel30, Fuerza18 y valores base normales: la **Espada Corta (7)** tiene descripción “Ataque: 2/6”, pero su tirada real es `floor(random_range(4,4))`. La aproximación anterior podía dar aproximadamente **27–94**; la fórmula original da **54–62**. Puñaladas, otra Fuerza, defensa y nivel cambian ese resultado de manera legítima.

## Comparación con el ejecutable original

`--online-ui-test combat` ejecuta las funciones originales dentro de GameMaker y escribe `online_combat_parity.json` en su carpeta de guardados. La fixture conserva la semilla y registra las tiradas necesarias para reproducir cada cálculo en Python; no modifica las funciones de combate offline ni guarda personajes.

Se conservaron **2.685 casos** en `server/tests/combat_native.json`. `server/test_combat.py` reproduce esas tiradas en el servidor y exige el mismo resultado entero, además de consumir exactamente las tiradas previstas. Todos coinciden. Cubre las nueve clases, todas las armas físicas del jugador, las cuatro flechas comunes, varios niveles/dosis, defensa específica de personas IA, todos los rangos de ropa defensiva del jugador, cascos/escudos, báculos/laúd, curación y las 101 puntuaciones de Resistencia Mágica. También verifica que `round` coincida con el redondeo a pares del runtime.

La ronda específica de combate pasó **70 pruebas**; la revisión final de paridad elevó la suite a **92**, todas aprobadas. Incluye regresiones de golpe final, señal de crítico, flecha paralizante, duraciones/distinción de estados, inmunidad Dragonic e importación persistente de las estadísticas de combate.

El compilador oficial GameMaker LTS2026 aprobó el build. Cinco runners reales aprobaron el escenario completo en `server/test-results/game-20261009-100016/`; la generación nativa terminó en `server/test-results/combat-20261009-095246/`. En ambos ensayos se comprobaron hashes de partidas personales intactos.

Para repetir la comparación después de cambiar las reglas nativas: compilar, ejecutar el Runner con `--online-ui-test combat`, revisar su log `COMBAT_PARITY_DONE`, copiar el informe a `server/tests/combat_native.json` y ejecutar:

```powershell
.\server\.venv\Scripts\python.exe -m unittest discover -s server -v
```

La referencia debe regenerarse desde el juego; no editar sus daños esperados para hacer pasar un cambio del servidor.

La parte de puñalada aplica en la fixture la rama de `pjAtacar` al resultado de `calcularDanoFisicoPJ`, con tirada registrada y `round` del runtime. No sustituye una prueba de todos los gestos/animaciones de puñalada mediante la entrada normal del juego.

## Alcance de la comparación

- Las funciones matemáticas y los casos anteriores están comparados; no equivale a probar toda decisión de cada familia de NPCs, jefe, mascota o bot. La revisión posterior agregó al exportador daño mágico, cantidad de veneno, intervalos, efectos y familia paralizante, y corrigió los ciclos de criaturas; ver `ONLINE_PARIDAD.md` para el estado final.
- El offline no tiene PvP entre dos clientes humanos. La rama online de daño físico usa las etapas del ataque del jugador y la tabla completa de defensa del jugador receptor; magia conserva los modificadores ofensivos del jugador. La puntería PvP adicional es una regla de la integración online, no una equivalencia demostrada con `obj_persona`.
- El original usa algunas estadísticas globales de `obj_pj` incluso cuando se enfrentan NPCs/bots entre sí. En un mundo con varios humanos no hay un único `obj_pj`: los bots conservan las bandas de skills de su creación y usan su nivel cuando no están atacando a un humano. Esa adaptación debe revisarse en partidas de balance, no presentarse como una copia literal.
- La revisión posterior incorporó los multiplicadores compartidos del mundo, la bolsa de XP, las ganancias nativas de nivel y skills, la criminalidad y la arena funcional existente. Las preferencias de un cliente no cambian las reglas del servidor.
- El servidor conserva comprobaciones de distancia, visibilidad y zonas seguras. Falta una matriz real de objetivos/obstáculos/mapas y pruebas de combate con latencia y Android.

El estado final de los sistemas y los límites de validación están en [ONLINE_PARIDAD.md](ONLINE_PARIDAD.md).
