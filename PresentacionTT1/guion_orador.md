# Guion de exposición: TT 2027-A178

La presentación expone la investigación, el análisis y el diseño del proyecto. La arquitectura, la validación y las interfaces se presentan como propuestas: los mockups contienen datos simulados y no acreditan un agente implementado ni resultados experimentales.

## Compilación

Desde esta carpeta se utiliza XeLaTeX y Biber. Los recursos se toman de `../Images` y `../References`:

```bash
xelatex presentacion_tt1 && biber presentacion_tt1 && xelatex presentacion_tt1 && xelatex presentacion_tt1
```

## Recorrido de las láminas principales

1. **Portada:** presentar el TT, sus integrantes y su director.
2. **Idea central:** explicar la separación entre reglas externas, intérprete, modelo y motor de decisión.
3. **Problema:** contrastar sistemas especializados y generalidad; distinguir la estimación de configuraciones de Shannon de la del árbol de variantes.
4. **Objetivos:** presentar el objetivo general y los cinco específicos, incluida la evaluación mediante partidas contra un motor con ELO configurable.
5. **Alcance:** explicar información perfecta, discretización, determinismo y turnos como condiciones distintas. Presentar Gato y Ajedrez como casos de estudio.
6. **Estado del arte:** recorrer la evolución de heurísticas, simulación y lenguajes de descripción. Sancho ganó la competencia internacional de GGP de 2014; no atribuirle técnicas sin una fuente específica.
7. **Modelo formal:** explicar roles, estados, estado inicial, acciones, legalidad, transición, terminalidad y utilidades. La acción `noop` representa al rol que no tiene el turno.
8. **Reglas externas:** mostrar el ejemplo de Gato y comparar GDL, un subconjunto y un DSL propio como alternativas estudiadas.
9. **Arquitectura:** recorrer reglas, intérprete, modelo, generador y motor. Al cambiar de juego cambian la descripción y el modelo construido; el núcleo conserva su código.
10. **Análisis del lenguaje:** explicar sintaxis, validez y semántica de GDL, los ejemplos analizados y los requisitos que se derivan para el intérprete.
11. **Métricas:** explicar cómo se comprobarían la corrección funcional, la calidad de decisión, el costo de búsqueda y la generalidad operativa. Aclarar que son propuestas y todavía no hay resultados.
12. **Prototipos:** presentar las cinco vistas como propuestas de interacción con datos simulados.
13. **Evaluación propuesta:** explicar la revisión funcional de Gato, los bancos exploratorios de 60 posiciones funcionales y 30 problemas de primera jugada de Ajedrez, y las partidas contra motor previstas en el objetivo.
14. **Metodología:** describir las cuatro etapas del protocolo y el enfoque iterativo e incremental. El cronograma detallado está en el respaldo C.
15. **Cierre:** retomar la aportación de la arquitectura y abrir preguntas.

## Respaldo para preguntas

- **A. GDL:** predicados reservados y ejemplo de reglas.
- **B. Algoritmos:** Minimax, alfa-beta y MCTS con UCT. En UCT se priorizan hijos sin visitas y se acumula la recompensa normalizada del jugador activo.
- **C. Cronograma:** actividades, responsables y meses del protocolo.
- **Referencias:** fuentes citadas en la presentación.

Al responder preguntas, conservar la distinción entre lo documentado, el diseño propuesto y los resultados que se obtengan en una implementación futura. No afirmar que el lenguaje o los algoritmos ya fueron elegidos sin un acuerdo que lo respalde.
