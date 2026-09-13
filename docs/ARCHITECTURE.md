# Arquitectura del Sistema

Este documento describe la arquitectura técnica de **Servicio Mecánico**, las decisiones de diseño y los patrones que deben seguirse al modificar o agregar nuevas características.

---

## 1. Stack Tecnológico

- **Framework**: [Astro 5](https://astro.build/) (Modo Estático: `output: "static"`).
- **Estilos**: [Tailwind CSS v4](https://tailwindcss.com/) con el plugin oficial `@tailwindcss/vite`.
- **Base de Datos y Backend**: [Supabase](https://supabase.com/) (PostgreSQL 15+, Supabase Auth, Row Level Security).
- **Iconografía**: Iconos SVG inline basados en [Lucide Icons](https://lucide.dev/) (evita problemas de resolución en bundles estáticos de Astro).
- **Lenguaje**: TypeScript y JavaScript ES Modules.

---

## 2. Estrategia de Renderizado y Datos

### A. Modo Estático (SSG) + Cliente SPA
Astro compila el sitio en archivos HTML, CSS y JS 100% estáticos en la carpeta `dist/`. Esto permite:
1. **Velocidad extrema**: La interfaz carga instantáneamente incluso en computadoras antiguas del taller.
2. **Hospedaje gratuito o de costo mínimo**: Compatible con Vercel, Netlify, Cloudflare Pages o GitHub Pages.
3. **Cero servidores Node.js en producción**: Supabase actúa como el backend (BaaS).

### B. Consumo de Datos en el Cliente
Toda la lógica de consulta (SELECT), inserción (INSERT), actualización (UPDATE) y eliminación (DELETE) se ejecuta en el navegador del usuario utilizando `@supabase/supabase-js`.

```typescript
// Patrón estándar en etiquetas <script> de Astro:
import { createClient } from '@supabase/supabase-js';

const supabase = createClient(
  import.meta.env.PUBLIC_SUPABASE_URL || 'https://zsddtosxnfqmbyxptkfs.supabase.co',
  import.meta.env.PUBLIC_SUPABASE_ANON_KEY || 'eyJhbGciOiJIUzI1NiIsIn...'
);
```

> **IMPORTANTE**: No importar `lib/supabase.ts` dentro de las etiquetas `<script>` de componentes Astro cuando ese archivo use variables de entorno exclusivas del servidor (`import.meta.env.SUPABASE_URL`). En scripts del cliente, inicializa directamente el cliente usando las variables `PUBLIC_` o valores por defecto.

---

## 3. Ruteo de Vistas de Detalle (`detalle?id=X`)

En modo estático (`output: "static"`), una ruta dinámica como `src/pages/admin/clientes/[id].astro` requeriría definir `getStaticPaths()` en tiempo de compilación. Como los clientes y vehículos se registran en tiempo real y cambian constantemente:

- **Enfoque adoptado**: Rutas estáticas de detalle con Query Parameters:
  - Clientes: `/admin/clientes/detalle?id=123`
  - Vehículos: `/admin/vehiculos/detalle?id=456`
- **Lectura del ID en cliente**:
  ```javascript
  const id = new URLSearchParams(window.location.search).get('id');
  ```
- **Redirección si falta el ID**: Si el parámetro `id` no está presente, la página muestra un estado de error claro y un botón para volver al listado.

---

## 4. Autenticación y Seguridad

1. **Protección de Rutas Administrativas**:
   - `AdminLayout.astro` incluye un script global que verifica la sesión activa en Supabase:
     ```javascript
     const { data: { session } } = await supabase.auth.getSession();
     if (!session) {
       window.location.href = '/admin/login';
     }
     ```
2. **Cierre de Sesión**:
   - El botón de logout en el sidebar llama a `supabase.auth.signOut()` y redirige inmediatamente a `/admin/login`.
3. **Row Level Security (RLS)**:
   - Todas las tablas principales (`clientes`, `vehiculos`, `trabajos`) tienen RLS habilitado en Supabase, permitiendo lectura/escritura únicamente a usuarios autenticados (`TO authenticated`).
   - Las tablas de catálogo (`marcas_vehiculo`, `tipos_trabajo`, `viscosidades`) permiten lectura anónima (`TO anon`) para rellenar selectores si fuera necesario.

---

## 5. Modo Oscuro (Dark Mode)

El sistema soporta modo claro y modo oscuro con persistencia:
- **Estrategia**: Clase `dark` en la etiqueta raíz `<html>`.
- **Persistencia**: Almacenado en `localStorage.getItem('theme')` con valores `'dark'` o `'light'`.
- **Prevención de Parpadeo (FOUC)**: En el `<head>` de `AdminLayout.astro`, un script inline síncrono evalúa `localStorage` antes de renderizar la página.
- **Paleta de Color Oscuro**: Se utilizan tonos **carbón neutro / zinc** (`#18181b`, `#202022`, `#27272a`). **Nunca usar tonos azulados (slate)** para el modo oscuro en este proyecto.
