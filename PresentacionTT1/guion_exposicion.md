# Guion de exposición — TT 2027-A178

**Desarrollo de un General Game Player utilizando un lenguaje de descripción de reglas para juegos de información perfecta**

Este guion sigue las 15 láminas principales de la presentación actual. Los textos son una propuesta para hablar con naturalidad; las indicaciones entre corchetes no necesitan leerse. Los respaldos se utilizan si surgen preguntas después del cierre.

## Distribución del tiempo

La siguiente distribución propone **de 37 a 50 minutos de exposición**, con explicaciones frente a las figuras y pausas. Es una estimación: ensayen en voz alta y cronometren, pues leer el texto de corrido puede tomar menos tiempo. Las preguntas se consideran aparte; si el límite de una hora las incluye, procuren cerrar la exposición alrededor del minuto 45.

| Lámina | Tema | Tiempo orientativo |
|---|---|---:|
| 1 | Portada | 1 min |
| 2 | Idea central | 2–3 min |
| 3 | Problema | 3–4 min |
| 4 | Objetivos | 2–3 min |
| 5 | Alcance | 2–3 min |
| 6 | Estado del arte | 3–4 min |
| 7 | Modelo formal | 3–4 min |
| 8 | Reglas externas | 3–4 min |
| 9 | Arquitectura | 4–5 min |
| 10 | Análisis del lenguaje | 3–4 min |
| 11 | Métricas propuestas | 2–3 min |
| 12 | Prototipos | 2–3 min |
| 13 | Evaluación propuesta | 4–5 min |
| 14 | Metodología | 2–3 min |
| 15 | Cierre | 1 min |

Para acercarse a **30 minutos**, expliquen un solo ejemplo por lámina, sinteticen el recorrido histórico y dejen los detalles matemáticos para preguntas. Para una exposición más larga, utilicen las ampliaciones marcadas como «Si hay tiempo» y expliquen los diagramas paso a paso, sin presentar los respaldos como parte obligatoria del recorrido.

---

## 1. Portada — 1 minuto

Buenos días. Somos Edgar Sánchez Catarino y Gustavo Linares Villegas. Presentamos el Trabajo Terminal 2027-A178, titulado «Desarrollo de un General Game Player utilizando un lenguaje de descripción de reglas para juegos de información perfecta», dirigido por el doctor Enrique Escalante Notario.

El tema central es cómo construir un agente que pueda trabajar con las reglas de distintos juegos a partir de una descripción externa. Durante la exposición explicaremos el problema, los fundamentos que revisamos, el análisis del lenguaje, la arquitectura propuesta y la forma en que planeamos evaluar el sistema.

**Transición:** Para comenzar, veamos qué diferencia a esta propuesta de un agente diseñado para un solo juego.

## 2. Desacoplar las reglas del motor — 2 a 3 minutos

[Señalar las dos filas del diagrama.]

En un motor especializado, buena parte de las reglas y de las estructuras que utiliza se diseñan para un juego concreto. Por ejemplo, un motor de Ajedrez necesita representar piezas, movimientos y condiciones propias de ese dominio. Si queremos trabajar con un juego de reglas distintas, esas decisiones de diseño pueden requerir cambios en el programa.

El enfoque de *General Game Playing*, o GGP, busca una forma diferente de organizar el problema. En lugar de escribir las reglas de cada juego dentro del motor de decisión, se le proporciona una descripción externa. Un intérprete procesa esa descripción y construye un modelo consultable. Sobre ese modelo, el motor pregunta qué acciones son legales, qué estado produciría una acción y cuándo termina la partida.

La aportación que buscamos estudiar es la separación entre reglas, interpretación y decisión. Para cambiar de Gato a Ajedrez se cargaría otra descripción y se construiría el modelo correspondiente, mientras se conserva el código del núcleo. La generalidad que podremos comprobar quedará limitada a los juegos y reglas que realmente evaluemos.

**Transición:** Esta necesidad de separar reglas y decisión se entiende mejor al revisar algunos antecedentes.

## 3. Un agente por juego: la hiperespecialización — 3 a 4 minutos

Los juegos han sido un campo de estudio para la inteligencia artificial porque sus reglas pueden expresarse con claridad y permiten observar las consecuencias de una decisión.

En los años cincuenta, Arthur Samuel desarrolló un programa para damas inglesas que combinaba búsqueda y evaluación de posiciones, y que mejoraba a partir de la experiencia. Más adelante, Deep Blue se diseñó para Ajedrez: utilizaba búsqueda alfa-beta en hardware especializado y una función de evaluación preparada para ese juego.

AlphaZero muestra otro avance: un mismo enfoque de aprendizaje y búsqueda se aplicó a Ajedrez, Shogi y Go. Sin embargo, para cada juego se utilizaron reglas y representaciones de estados y acciones correspondientes al dominio, además de entrenamiento por juego. Por eso, en esta comparación distinguimos reutilizar un algoritmo de recibir una descripción declarativa de reglas y construir a partir de ella un modelo consultable.

Otra dificultad es el tamaño de los espacios que deben explorarse. Shannon estimó un orden de diez a la cuarenta y tres para una cuenta combinatoria de configuraciones de piezas, y un orden de diez a la ciento veinte para variantes bajo supuestos de ramificación y duración. Son dos estimaciones de cosas distintas; no son un conteo exacto de posiciones legales alcanzables.

La consecuencia para nuestro proyecto es que, en un juego grande, no basta con intentar enumerar todas las posibilidades. Necesitamos consultar sucesores conforme se requieren y limitar la búsqueda.

**Si hay tiempo:** expliquen la diferencia entre una posición, que describe una configuración, y una variante o historia, que describe una secuencia de jugadas. Distintas secuencias pueden llegar a una misma posición.

**Transición:** Con ese problema planteado, estos son los objetivos del trabajo.

## 4. Un núcleo, varios juegos — 2 a 3 minutos

El objetivo general es diseñar e implementar un General Game Player para juegos de información perfecta, capaz de interpretar reglas a partir de un lenguaje estructurado y de ajustar sus decisiones a la descripción que se le cargue, sin modificar el código del motor base.

Para llegar a ese objetivo planteamos cinco líneas de trabajo. Primero, diseñar la sintaxis y la semántica del lenguaje de reglas: es decir, cómo se escribe una descripción y qué significa. Segundo, desarrollar el intérprete y el generador de estados. Tercero, implementar el motor que seleccionará las acciones. Cuarto, validar la generalización usando Gato y Ajedrez como dominios distintos. Quinto, evaluar el desempeño táctico en Ajedrez mediante partidas contra un motor especializado con ELO configurable.

En esta presentación exponemos la investigación, el análisis y el diseño que sustentan el desarrollo. Las pruebas y los resultados deberán documentarse cuando se realicen; las métricas que veremos más adelante son una propuesta de evaluación.

**Transición:** Para que el problema sea abordable, acotamos la clase de juegos que estudiaremos.

## 5. Cuatro condiciones que delimitan los juegos — 2 a 3 minutos

[Señalar cada condición.]

La primera condición es información perfecta. En el modelo del proyecto, los participantes cuentan con el estado y los antecedentes públicos necesarios para decidir. Para el Ajedrez no basta con observar dónde están las piezas: hay información relevante, como los derechos de enroque o los antecedentes necesarios para aplicar ciertas reglas.

La segunda condición es trabajar con estados y acciones discretos; el modelo formal del trabajo considera conjuntos finitos. La tercera es el determinismo: una acción conjunta legal, aplicada a un estado, produce un único sucesor. La cuarta es que los jugadores actúan por turnos alternados.

Es importante no confundir estas condiciones. Que un juego sea de información perfecta no implica automáticamente que sea determinista. En este trabajo excluimos el azar como una restricción adicional del alcance.

Usamos Gato y Ajedrez porque permiten estudiar dificultades diferentes. Gato tiene un espacio pequeño y permite revisar exhaustivamente sus estados alcanzables. Ajedrez agrega una mayor complejidad de reglas y búsqueda. La intención no es superar a Stockfish ni reproducir el entrenamiento de AlphaZero.

**Transición:** Veamos ahora cómo ha evolucionado el estudio de agentes generales de juego.

## 6. General Game Playing: de heurísticas a simulación — 3 a 4 minutos

La iniciativa de GGP impulsada desde Stanford y la AAAI plantea agentes que reciben una descripción formal de un juego y deben actuar a partir de ella, sin que sus reglas particulares estén programadas previamente dentro del agente.

En los primeros enfoques se estudiaron formas de analizar las reglas para construir evaluaciones generales. ClunePlayer, por ejemplo, analizaba propiedades de los hechos y de las acciones para orientar su búsqueda. Fluxplayer también investigó formas de estimar qué tan cerca estaba un estado de cumplir condiciones relevantes del juego.

Después cobraron importancia los métodos basados en simulación. CadiaPlayer aplicó búsqueda Monte Carlo con UCT en GGP: en vez de depender únicamente de una evaluación escrita para un juego particular, utiliza resultados de partidas simuladas para orientar la exploración del árbol.

Sancho es otro antecedente de competencia: ganó la competencia internacional de GGP en 2014. También revisamos lenguajes y plataformas como Ludii y RBG, así como trabajos de aprendizaje en GGP. La secuencia de la lámina sirve para organizar los antecedentes de esta revisión; no supone que exista una clasificación única de todos los sistemas.

Nuestro trabajo se ubica en la línea de reglas externas e interpretación declarativa, con un motor que consulta el modelo del juego. Los antecedentes permiten estudiar alternativas, pero mencionarlos no significa que todos formen parte de la implementación propuesta.

**Si hay tiempo:** contrasten una heurística específica, como asignar un valor fijo a una pieza de Ajedrez, con una característica más general, como el número de acciones legales disponibles.

**Transición:** Para separar las reglas del motor necesitamos describir qué información mínima representa un juego.

## 7. Un juego es un sistema de transición de estados — 3 a 4 minutos

Representamos un juego mediante la tupla que aparece en la lámina. No es necesario memorizarla como una lista aislada: cada componente responde a una pregunta que el agente necesita resolver.

R identifica los roles o jugadores. S es el conjunto de estados que puede representar el modelo, y s sub cero es el estado inicial. Para cada rol tenemos un conjunto de acciones posibles. La función de legalidad indica cuáles de esas acciones se pueden realizar en un estado concreto.

La transición T indica qué estado sucede a otro cuando se aplica una acción conjunta legal. F identifica los estados terminales, es decir, aquellos en los que la partida termina. Finalmente, G asigna una utilidad a cada rol para expresar el resultado.

En Gato, por ejemplo, un estado incluye las marcas del tablero y el turno. Desde ese estado, la legalidad permite consultar las casillas en las que se puede jugar. La transición añade la marca correspondiente y actualiza el turno. La terminalidad identifica una línea ganadora o un empate, y las utilidades expresan el resultado para ambos jugadores.

Aunque el modelo represente acciones conjuntas, los juegos dentro del alcance son por turnos. Para ello se usa la acción nula *noop* para el participante que no tiene el turno. Así mantenemos una interfaz uniforme sin suponer que ambos deciden simultáneamente.

**Transición:** El modelo nos dice qué debemos representar; el lenguaje define cómo escribir esa información en un archivo.

## 8. Reglas externas: GDL, subconjunto o DSL — 3 a 4 minutos

GDL, o *Game Description Language*, es un lenguaje declarativo utilizado para describir juegos. En lugar de escribir un algoritmo que juegue Gato, una descripción expresa hechos y reglas a partir de los cuales se pueden responder consultas sobre la partida.

[Señalar el primer bloque de código.]

En la regla de legalidad se indica que un jugador puede marcar una casilla si tiene el control del turno y esa casilla está vacía. Los símbolos que comienzan con signo de interrogación son variables: permiten expresar la regla de forma general para distintas filas, columnas y jugadores.

[Señalar el segundo bloque.]

Las reglas siguientes muestran la alternancia: si el control actual es de X, el siguiente control corresponde a O, y viceversa. Este es un fragmento explicativo; la descripción completa también necesita declarar el tablero inicial, las condiciones terminales y las utilidades.

En la investigación se comparan tres posibilidades: GDL completo, un subconjunto o un lenguaje de dominio específico. GDL tiene una base académica y una semántica lógica documentada. Un subconjunto puede simplificar la implementación dependiendo de las restricciones que se adopten, pero también exige justificar qué expresiones se admiten. Un lenguaje propio requeriría definir y justificar su sintaxis y semántica.

El capítulo de Análisis estudia GDL en detalle; eso no equivale por sí solo a declarar elegida la alternativa definitiva.

**Transición:** Con esta idea del archivo de reglas, podemos recorrer la arquitectura propuesta.

## 9. El motor de decisión no conoce ningún juego — 4 a 5 minutos

[Recorrer el diagrama de izquierda a derecha y después volver a las flechas de consulta.]

La entrada es un archivo con una descripción externa del juego. El intérprete analiza su estructura y verifica las restricciones definidas. Si encuentra una descripción inválida, deberá producir un diagnóstico y detener la carga.

Si la descripción se acepta, se construye un modelo interno que representa las reglas del juego y su estado inicial. Ese modelo queda disponible para el generador y los servicios de consulta. El generador permite obtener acciones legales, construir estados sucesores y consultar condiciones terminales y utilidades.

El motor de decisión recibe el estado actual, el rol activo y un presupuesto de búsqueda. A partir de ahí solicita información al generador. Por ejemplo, pregunta qué acciones están disponibles y qué estados producirían. Con esas respuestas puede explorar alternativas hipotéticas antes de seleccionar una acción.

Es importante distinguir una simulación de la partida real. Durante la búsqueda se pueden consultar muchos sucesores hipotéticos. Una vez elegida una acción, la coordinación de la partida aplica esa acción al estado actual mediante la misma función de transición del modelo. El estado resultante se usa en el siguiente turno. Si el estado es terminal, se reportan las utilidades y la partida termina.

La línea punteada delimita el núcleo reutilizable. Al cargar otro juego se utiliza una nueva descripción y se construye otro modelo interno; la propiedad que queremos comprobar es que el código del núcleo se mantenga. El diagrama muestra responsabilidades conceptuales: no acredita que esos módulos ya estén implementados.

**Si hay tiempo:** describan un turno de Gato: consultar casillas libres, imaginar los sucesores de dos acciones, elegir una y aplicar solo esa acción a la partida real.

**Transición:** Para construir ese intérprete, primero analizamos qué debe expresar y cómo se interpreta un lenguaje de reglas.

## 10. De una descripción de reglas a un juego formal — 3 a 4 minutos

El análisis del lenguaje parte de una distinción: un juego es el objeto formal que queremos representar, mientras que una descripción es un archivo finito que expresa sus reglas. El propósito del intérprete es relacionar ambos.

En el capítulo de Análisis estudiamos GDL desde varios niveles. El nivel léxico identifica los símbolos y unidades del texto. El sintáctico comprueba que esas unidades formen estructuras permitidas por la gramática. Después se revisan restricciones de validez de las reglas; una descripción puede tener paréntesis correctos y aun así no cumplir una restricción necesaria para su interpretación.

La semántica explica cómo una descripción válida se asocia con un modelo de juego. En ese modelo deben poder identificarse roles, estado inicial, legalidad, transiciones, terminalidad y utilidades.

Para concretar estas ideas se analizaron un juego de la resta y Gato. También se revisaron descripciones defectuosas y se derivaron requisitos para el intérprete. El resultado de este análisis es una base documental para justificar el diseño del procesamiento de reglas y sus comprobaciones.

**Si hay tiempo:** usen como ejemplo una descripción que haga referencia a un rol no declarado. La estructura del texto podría parecer correcta, pero todavía hay que comprobar su validez respecto de las reglas y restricciones adoptadas.

**Transición:** Una vez planteada la arquitectura, explicaremos cómo se propone comprobar su funcionamiento.

## 11. ¿Cómo comprobaremos que funciona? — 2 a 3 minutos

Proponemos evaluar cuatro aspectos. El primero es la **corrección funcional**: compararemos el conjunto completo de acciones legales y los estados sucesores con una referencia independiente. También comprobaremos si identifica la terminalidad y las utilidades. Reportaremos un porcentaje de coincidencia por cada indicador, con su propio número de casos.

El segundo es la **calidad de decisión**. En Gato compararemos las decisiones con las opciones óptimas de un solucionador. En Ajedrez comprobaremos si la primera jugada pertenece al conjunto de respuestas aceptadas y se entrega dentro del presupuesto. Una acción inválida o un tiempo agotado contará como fallo.

El tercero es el **costo de búsqueda**: registraremos el tiempo por decisión, su mediana y percentil 95, los nodos expandidos y la profundidad en medias jugadas; si se usa MCTS, las simulaciones se informarán por separado. El tiempo, los nodos y la profundidad conservan sus propias unidades.

Por último, para la **generalidad operativa** se propone ejecutar ambos juegos con las mismas versiones del intérprete y el motor, y registrar qué componentes se modificaron. La conclusión se limitará a los juegos y reglas probados. Estas métricas son propuestas y todavía no representan resultados.

**Si hay tiempo:** si en nueve de diez posiciones coincide el conjunto completo de movimientos legales, el indicador de coincidencia es 90 %. Conviene registrar tanto los movimientos ilegales generados como los legales omitidos.

**Transición:** Con estos criterios de evaluación, veamos las propuestas visuales de interacción.

## 12. Prototipos de interfaz aprobados — 2 a 3 minutos

Estas imágenes presentan cinco vistas propuestas. La primera muestra la carga y validación de una descripción de reglas. Las dos siguientes muestran una partida de Gato y una de Ajedrez, con tablero, turno, historial y acciones legales.

La cuarta vista organiza la preparación de una evaluación. La quinta muestra cómo podría presentarse un reporte por caso, incluyendo resultados y datos de ejecución.

El objetivo de los prototipos es comunicar el flujo de interacción y relacionarlo con los componentes de la arquitectura. Las posiciones, cifras y estados que se observan son ilustrativos. Las imágenes no demuestran que ya exista una interfaz conectada al intérprete ni que se hayan realizado experimentos.

**Transición:** Veamos ahora los casos propuestos para evaluar Gato y Ajedrez.

## 13. Evaluación propuesta para Gato y Ajedrez — 4 a 5 minutos

La evaluación se organiza alrededor de cuatro preguntas: si las reglas se interpretan correctamente, si las decisiones son adecuadas para el caso evaluado, cuánto cuesta la búsqueda y si el núcleo se conserva al cambiar de juego.

Para Gato se propone revisar exhaustivamente los estados alcanzables desde el tablero vacío, considerando que X inicia y que la partida se detiene al aparecer una victoria o un empate. En los estados no terminales se compararán las acciones legales y las decisiones; en los terminales se comprobarán los resultados. La coincidencia funcional del cien por ciento es una propuesta para los casos incluidos, no una prueba de corrección fuera de ellos.

Para Ajedrez se propone un banco exploratorio de 60 posiciones funcionales, inicialmente distribuido en seis familias: movimientos y capturas, jaques y clavadas, enroques, promociones, captura al paso y terminalidad. Se plantea usar una referencia independiente, como python-chess, para comparar los resultados conforme a las reglas soportadas.

Además se proponen 30 problemas tácticos para evaluar la **primera jugada**. Una decisión contará como acierto si pertenece al conjunto de respuestas aceptadas y se entrega dentro del presupuesto establecido. Una acción inválida o un tiempo agotado contará como fallo. Los casos para ajustar el sistema serán distintos de los reservados para evaluar.

Por separado, el objetivo específico contempla partidas contra un motor con ELO configurable. Los bancos funcional y táctico complementan esa evaluación; no reemplazan las partidas. Los tamaños de 60 y 30 son exploratorios y no garantizan representar todas las posiciones de Ajedrez.

Las posiciones distintas y sus ejecuciones se contarán por separado. Estos casos concretan los indicadores presentados en la lámina de métricas.

**Transición:** Por último, explicamos cómo se organiza el trabajo para llegar a esa integración y evaluación.

## 14. Etapas del desarrollo — 2 a 3 minutos

El protocolo organiza el desarrollo en cuatro etapas. La primera es el diseño del lenguaje: definir cómo se expresan las reglas y cómo se interpretan. La segunda es la construcción del intérprete. La tercera es la implementación del agente de decisión. La cuarta es integrar los componentes y realizar la validación.

El enfoque de trabajo es iterativo e incremental. Cada ciclo busca producir un entregable que pueda revisarse; las observaciones obtenidas sirven para ajustar el siguiente. Por ejemplo, un análisis del lenguaje puede descubrir una restricción que deba reflejarse en la especificación y después en las pruebas del intérprete.

El cronograma del protocolo distribuye las actividades entre los integrantes a lo largo de los meses de agosto a junio. En el respaldo C se muestran los periodos por actividad.

**Transición:** Con esto podemos cerrar retomando la idea central del proyecto.

## 15. Cierre y preguntas — 1 minuto

En conclusión, el trabajo estudia una arquitectura que separa las reglas de los juegos del motor de decisión. Para ello se fundamentan un modelo formal, el análisis de un lenguaje de descripción y una arquitectura en la que un intérprete construye un modelo consultable.

Gato y Ajedrez permitirán estudiar la propuesta en dos dominios con diferencias importantes de complejidad. La evaluación buscará comprobar la interpretación de reglas, la calidad de las decisiones en los casos definidos y la conservación del núcleo al cambiar de juego.

Muchas gracias por su atención. Quedamos atentos a sus preguntas.

---

## Respaldo para preguntas

Las siguientes láminas están después del cierre y se abren solo cuando ayuden a responder.

**A. Predicados reservados de GDL.** `role` declara participantes; `init` describe hechos iniciales; `true` consulta hechos del estado; `does` representa acciones; `legal`, `next`, `terminal` y `goal` permiten expresar legalidad, transición, terminalidad y utilidad. El ejemplo es ilustrativo.

**B. Minimax, alfa-beta y MCTS/UCT.** Minimax evalúa opciones suponiendo respuestas adversariales, bajo los supuestos del modelo explicado. Alfa-beta evita explorar ramas que no cambiarían la decisión en la búsqueda equivalente. MCTS combina selección, expansión, simulación y retropropagación. En la formulación mostrada de UCT se atienden primero los hijos sin visitas y se acumula la recompensa normalizada por rol; no se garantiza una decisión óptima con un presupuesto finito.

**C. Cronograma.** Usar las barras para ubicar actividades, responsables y meses. Las barras representan programación, no avance ejecutado.

**Referencias.** Consultar las láminas finales para identificar la fuente de cada antecedente.

## Preguntas que conviene preparar

**¿Por qué no basta con cambiar de tablero en un motor especializado?** Porque el comportamiento del juego también depende de legalidad, transiciones, terminalidad y utilidades. La propuesta busca expresar esas reglas fuera del motor y consultarlas mediante un modelo común.

**¿Ya se eligieron GDL y el algoritmo de búsqueda?** El documento analiza GDL y estudia alternativas como Minimax/alfa-beta y MCTS/UCT. Su estudio no establece por sí solo una decisión definitiva de implementación.

**¿Ya funciona el agente?** La presentación muestra investigación, análisis, diseño conceptual y prototipos visuales. Los mockups y las comprobaciones documentales no acreditan un agente integrado ni resultados experimentales.

**¿Cómo se comprobará la generalidad?** Se propone ejecutar los dominios con la misma versión del núcleo, cambiar la descripción externa, construir el modelo correspondiente y registrar qué componentes se modificaron. La conclusión se limitará a las reglas y juegos probados.

**¿Por qué 60 posiciones y 30 problemas?** Son cantidades exploratorias propuestas para organizar cobertura funcional y táctica. No constituyen una muestra representativa de todo Ajedrez ni sustituyen las partidas previstas en el objetivo.

**¿Qué se medirá en los problemas tácticos?** El acierto de la primera acción dentro del presupuesto y frente al conjunto de respuestas aceptadas. Ese indicador no afirma que se haya resuelto toda una secuencia táctica.

**¿Por qué una posición favorable no garantiza la victoria?** Porque una trayectoria favorable puede depender de que el adversario cometa un error. Una estrategia ganadora debe considerar las respuestas posibles del oponente.

**¿Qué ocurre con el aprendizaje y autojuego mencionados en el protocolo?** El documento estudia la búsqueda general y reconoce que el mecanismo definitivo de aprendizaje o autojuego requiere definición. No debe presentarse una técnica concreta como implementada o acordada.

**¿Cuál es la principal diferencia frente a AlphaZero?** La comparación de este TT se centra en cómo se reciben e interpretan reglas externas. AlphaZero comparte un enfoque de aprendizaje entre juegos, pero utiliza representaciones y entrenamiento por juego; esa diferencia no elimina su aportación.

---
