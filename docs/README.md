# Servicio Mecánico — Documentación y Contexto del Proyecto

Bienvenido a la documentación técnica de **Servicio Mecánico**, una aplicación web diseñada para la administración y gestión operativa de talleres mecánicos automotrices.

Este repositorio contiene la arquitectura frontend, integración con Supabase (PostgreSQL + Auth) y un panel administrativo completo con soporte de modo oscuro.

---

## 📚 Índice de Documentación

Para cualquier desarrollador o modelo de IA que trabaje en este proyecto, consulta los siguientes documentos para mantener la consistencia técnica:

1. **[Arquitectura y Tecnologías](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/docs/ARCHITECTURE.md)**: Explicación del stack (Astro 5 + Tailwind v4 + Supabase), estrategia de renderizado estático con ruteo dinámico por query params, y autenticación del lado del cliente.
2. **[Esquema de Base de Datos](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/docs/DATABASE_SCHEMA.md)**: Tablas completas (`clientes`, `vehiculos`, `trabajos`, `marcas_vehiculo`, `tipos_trabajo`, `viscosidades`), tipos de datos, relaciones foráneas, campos dinámicos JSONB y advertencias de esquema.
3. **[Reglas de Desarrollo y Estándares](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/docs/RULES_AND_STANDARDS.md)**: Reglas de PowerShell en Windows, tokens de diseño y modo oscuro neutro, validaciones de formularios y reglas de actualización de Graphify.
4. **[Guía de Pantallas y Flujos](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/docs/PAGES_AND_FLOWS.md)**: Detalle de cada vista del panel administrativo (`/admin`), componentes modales rápidos y páginas públicas.

---

## 🚀 Comandos Rápidos

| Comando | Descripción |
| :--- | :--- |
| `npm run dev` | Inicia el servidor local de desarrollo en `http://localhost:4321` |
| `npm run build` | Compila las 12 rutas estáticas a la carpeta `dist/` |
| `npm run preview` | Previsualiza la compilación de producción en local |
| `graphify update .` | Actualiza el grafo de conocimiento del proyecto (AST-only, sin costo API) |

---

## 📁 Estructura del Proyecto

```text
ServicioMecanico/
├── docs/                     # Documentación técnica y contexto del proyecto
├── src/
│   ├── components/           # Componentes UI (Header, Footer, Hero, ServiceCard)
│   ├── layouts/              # AdminLayout.astro (Panel) y MainLayout.astro (Landing)
│   ├── lib/                  # Clientes e integraciones (supabase.ts)
│   ├── pages/                # Rutas estáticas de Astro
│   │   ├── admin/            # Dashboard, CRUDs y vistas de detalle
│   │   │   ├── catalogos/    # Gestión de marcas, tipos de trabajo y viscosidades
│   │   │   ├── clientes/     # CRUD de clientes y vista detalle
│   │   │   ├── vehiculos/    # CRUD de vehículos y vista detalle
│   │   │   ├── trabajos/     # Historial de trabajos y modales rápidos
│   │   │   ├── login.astro   # Inicio de sesión con Supabase Auth
│   │   │   └── index.astro   # Dashboard administrativo principal
│   │   ├── contacto.astro    # Página pública de contacto
│   │   ├── nosotros.astro    # Página pública sobre el taller
│   │   ├── servicios.astro   # Catálogo público de servicios
│   │   └── index.astro       # Redirección o landing page
│   └── styles/
│       └── global.css        # Tailwind CSS v4 y tema de colores
├── supabase/                 # Scripts SQL de esquema y migraciones
├── astro.config.mjs          # Configuración de Astro y Tailwind Vite plugin
└── package.json              # Dependencias del proyecto
```

