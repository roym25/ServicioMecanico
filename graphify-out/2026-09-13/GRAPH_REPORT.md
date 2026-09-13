# Graph Report - ServicioMecanico  (2026-09-13)

## Corpus Check
- 26 files · ~25,938 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 79 nodes · 95 edges · 10 communities (7 shown, 3 thin omitted)
- Extraction: 89% EXTRACTED · 11% INFERRED · 0% AMBIGUOUS · INFERRED: 10 edges (avg confidence: 0.85)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `def3e6a5`
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
- scripts

## God Nodes (most connected - your core abstractions)
1. `scripts` - 5 edges
2. `renderTable()` - 5 edges
3. `handleFormSubmit()` - 5 edges
4. `loadVehiculos()` - 4 edges
5. `populateMarcaDropdown()` - 3 edges
6. `openCreateModal()` - 3 edges
7. `openEditModal()` - 3 edges
8. `closeModal()` - 3 edges
9. `filterVehiculos()` - 3 edges
10. `deleteVehiculo()` - 3 edges

## Surprising Connections (you probably didn't know these)
- None detected - all connections are within the same source files.

## Import Cycles
- None detected.

## Communities (10 total, 3 thin omitted)

### Community 0 - "package.json"
Cohesion: 0.17
Nodes (9): name, type, version, astro, @lucide/astro, @supabase/supabase-js, tailwindcss, @tailwindcss/vite (+1 more)

### Community 1 - "vehiculos/index.astro"
Cohesion: 0.38
Nodes (9): closeModal(), deleteVehiculo(), filterVehiculos(), handleFormSubmit(), loadVehiculos(), openCreateModal(), openEditModal(), populateMarcaDropdown() (+1 more)

### Community 2 - "MainLayout.astro"
Cohesion: 0.18
Nodes (4): team, values, inclusions, services

### Community 3 - "AdminLayout.astro"
Cohesion: 0.13
Nodes (5): navItems, overlay, sidebar, supabase, toggleBtn

### Community 4 - "Header.astro"
Cohesion: 0.29
Nodes (5): closeIcon, menuButton, mobileMenu, navLinks, openIcon

### Community 5 - "dependencies"
Cohesion: 0.33
Nodes (6): dependencies, astro, @lucide/astro, @supabase/supabase-js, tailwindcss, @tailwindcss/vite

### Community 9 - "scripts"
Cohesion: 0.40
Nodes (5): scripts, astro, build, dev, preview

## Knowledge Gaps
- **34 isolated node(s):** `name`, `type`, `version`, `dev`, `build` (+29 more)
  These have ≤1 connection - possible missing edges or undocumented components. (Counts symbols only; 48 node(s) total have ≤1 connection when file, concept and rationale nodes are included.)
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `dependencies` connect `dependencies` to `package.json`?**
  _High betweenness centrality (0.032) - this node is a cross-community bridge._
- **Why does `scripts` connect `scripts` to `package.json`?**
  _High betweenness centrality (0.026) - this node is a cross-community bridge._
- **Are the 3 inferred relationships involving `handleFormSubmit()` (e.g. with `clientes/index.astro` and `trabajos/index.astro`) actually correct?**
  _`handleFormSubmit()` has 3 INFERRED edges - model-reasoned connections that need verification._
- **What connects `name`, `type`, `version` to the rest of the system?**
  _34 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `AdminLayout.astro` be split into smaller, more focused modules?**
  _Cohesion score 0.13450292397660818 - nodes in this community are weakly interconnected._