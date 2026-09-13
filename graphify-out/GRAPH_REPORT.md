# Graph Report - ServicioMecanico  (2026-09-13)

## Corpus Check
- 31 files · ~29,117 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 130 nodes · 141 edges · 13 communities (10 shown, 3 thin omitted)
- Extraction: 93% EXTRACTED · 7% INFERRED · 0% AMBIGUOUS · INFERRED: 10 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `ac730a1a`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- package.json
- vehiculos/index.astro
- Header.astro
- AdminLayout.astro
- 1. Tablas del Sistema
- dependencies
- tsconfig.json
- rules/graphify.md
- workflows/graphify.md
- 1. Panel Administrativo (`/admin`)
- Arquitectura del Sistema
- Reglas de Desarrollo y Estándares Técnicos
- Servicio Mecánico — Documentación y Contexto del Proyecto

## God Nodes (most connected - your core abstractions)
1. `1. Panel Administrativo (`/admin`)` - 9 edges
2. `1. Tablas del Sistema` - 7 edges
3. `Arquitectura del Sistema` - 6 edges
4. `Reglas de Desarrollo y Estándares Técnicos` - 6 edges
5. `scripts` - 5 edges
6. `renderTable()` - 5 edges
7. `handleFormSubmit()` - 5 edges
8. `loadVehiculos()` - 4 edges
9. `Esquema de Base de Datos (Supabase PostgreSQL)` - 4 edges
10. `2. Estructura de Campos Dinámicos (JSONB)` - 4 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (13 total, 3 thin omitted)

### Community 0 - "package.json"
Cohesion: 0.12
Nodes (14): name, scripts, astro, build, dev, preview, type, version (+6 more)

### Community 1 - "vehiculos/index.astro"
Cohesion: 0.38
Nodes (9): closeModal(), deleteVehiculo(), filterVehiculos(), handleFormSubmit(), loadVehiculos(), openCreateModal(), openEditModal(), populateMarcaDropdown() (+1 more)

### Community 2 - "Header.astro"
Cohesion: 0.11
Nodes (9): closeIcon, menuButton, mobileMenu, navLinks, openIcon, team, values, inclusions (+1 more)

### Community 3 - "AdminLayout.astro"
Cohesion: 0.13
Nodes (5): navItems, overlay, sidebar, supabase, toggleBtn

### Community 4 - "1. Tablas del Sistema"
Cohesion: 0.12
Nodes (15): 1.1 `clientes`, 1.2 `vehiculos`, 1.3 `trabajos`, 1.4 `marcas_vehiculo`, 1.5 `tipos_trabajo`, 1.6 `viscosidades`, 1. Tablas del Sistema, 2. Estructura de Campos Dinámicos (JSONB) (+7 more)

### Community 5 - "dependencies"
Cohesion: 0.33
Nodes (6): dependencies, astro, @lucide/astro, @supabase/supabase-js, tailwindcss, @tailwindcss/vite

### Community 9 - "1. Panel Administrativo (`/admin`)"
Cohesion: 0.17
Nodes (11): 1.1 Dashboard (`/admin`), 1.2 Catálogo de Clientes (`/admin/clientes`), 1.3 Detalle de Cliente (`/admin/clientes/detalle?id=X`), 1.4 Catálogo de Vehículos (`/admin/vehiculos`), 1.5 Detalle de Vehículo (`/admin/vehiculos/detalle?id=X`), 1.6 Historial y Órdenes de Trabajo (`/admin/trabajos`), 1.7 Catálogos del Sistema (`/admin/catalogos`), 1.8 Inicio de Sesión (`/admin/login`) (+3 more)

### Community 10 - "Arquitectura del Sistema"
Cohesion: 0.22
Nodes (8): 1. Stack Tecnológico, 2. Estrategia de Renderizado y Datos, 3. Ruteo de Vistas de Detalle (`detalle?id=X`), 4. Autenticación y Seguridad, 5. Modo Oscuro (Dark Mode), A. Modo Estático (SSG) + Cliente SPA, Arquitectura del Sistema, B. Consumo de Datos en el Cliente

### Community 11 - "Reglas de Desarrollo y Estándares Técnicos"
Cohesion: 0.22
Nodes (8): 1. Reglas de Terminal y Sistema Operativo, 2. Reglas de Astro y JavaScript en el Cliente, 3. Estándares de Diseño y Modo Oscuro, 4. Estándares de Validación de Formularios, 5. Mantenimiento del Grafo de Conocimiento (Graphify), A. Paleta de Colores, B. Modo Oscuro (Neutro / Carbón), Reglas de Desarrollo y Estándares Técnicos

### Community 12 - "Servicio Mecánico — Documentación y Contexto del Proyecto"
Cohesion: 0.40
Nodes (4): 🚀 Comandos Rápidos, 📁 Estructura del Proyecto, Servicio Mecánico — Documentación y Contexto del Proyecto, 📚 Índice de Documentación

## Knowledge Gaps
- **69 isolated node(s):** `name`, `type`, `version`, `dev`, `build` (+64 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 88 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `dependencies` connect `dependencies` to `package.json`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **What connects `name`, `type`, `version` to the rest of the system?**
  _69 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `package.json` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._
- **Should `Header.astro` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._
- **Should `AdminLayout.astro` be split into smaller, more focused modules?**
  _Cohesion score 0.13450292397660818 - nodes in this community are weakly interconnected._
- **Should `1. Tablas del Sistema` be split into smaller, more focused modules?**
  _Cohesion score 0.125 - nodes in this community are weakly interconnected._