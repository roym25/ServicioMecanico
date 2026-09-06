# Graph Report - ServicioMecanico  (2026-09-05)

## Corpus Check
- 22 files · ~16,774 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 70 nodes · 81 edges · 11 communities (6 shown, 3 thin omitted)
- Extraction: 86% EXTRACTED · 14% INFERRED · 0% AMBIGUOUS · INFERRED: 11 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `aeedc300`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- package.json
- vehiculos/index.astro
- MainLayout.astro
- AdminLayout.astro
- Header.astro
- dependencies
- tsconfig.json
- rules/graphify.md
- workflows/graphify.md

## God Nodes (most connected - your core abstractions)
1. `scripts` - 5 edges
2. `handleFormSubmit()` - 5 edges
3. `closeModal()` - 4 edges
4. `renderTable()` - 4 edges
5. `loadVehiculos()` - 4 edges
6. `../../layouts/AdminLayout.astro` - 3 edges
7. `openCreateModal()` - 3 edges
8. `filterVehiculos()` - 3 edges
9. `deleteVehiculo()` - 3 edges
10. `@supabase/supabase-js` - 2 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (11 total, 3 thin omitted)

### Community 0 - "package.json"
Cohesion: 0.12
Nodes (13): name, scripts, astro, build, dev, preview, type, version (+5 more)

### Community 1 - "vehiculos/index.astro"
Cohesion: 0.31
Nodes (9): closeModal(), deleteVehiculo(), filterVehiculos(), handleFormSubmit(), loadVehiculos(), openCreateModal(), openEditModal(), renderTable() (+1 more)

### Community 2 - "MainLayout.astro"
Cohesion: 0.20
Nodes (4): team, values, inclusions, services

### Community 3 - "AdminLayout.astro"
Cohesion: 0.22
Nodes (5): navItems, overlay, sidebar, toggleBtn, noClientesMsg

### Community 4 - "Header.astro"
Cohesion: 0.29
Nodes (5): closeIcon, menuButton, mobileMenu, navLinks, openIcon

### Community 5 - "dependencies"
Cohesion: 0.40
Nodes (5): dependencies, astro, @supabase/supabase-js, tailwindcss, @tailwindcss/vite

## Knowledge Gaps
- **32 isolated node(s):** `name`, `type`, `version`, `dev`, `build` (+27 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 44 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `dependencies` connect `dependencies` to `package.json`?**
  _High betweenness centrality (0.030) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `handleFormSubmit()` (e.g. with `clientes/index.astro` and `trabajos/index.astro`) actually correct?**
  _`handleFormSubmit()` has 3 INFERRED edges - model-reasoned connections that need verification._
- **Are the 3 inferred relationships involving `closeModal()` (e.g. with `clientes/index.astro` and `trabajos/index.astro`) actually correct?**
  _`closeModal()` has 3 INFERRED edges - model-reasoned connections that need verification._
- **What connects `name`, `type`, `version` to the rest of the system?**
  _32 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `package.json` be split into smaller, more focused modules?**
  _Cohesion score 0.125 - nodes in this community are weakly interconnected._