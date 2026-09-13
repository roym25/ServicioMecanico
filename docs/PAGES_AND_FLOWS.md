# Guía de Pantallas y Flujos Operativos

Este documento detalla cada una de las rutas y pantallas del sistema **Servicio Mecánico**, sus componentes interactivos y los flujos de usuario.

---

## 1. Panel Administrativo (`/admin`)

Todas las rutas dentro de `/admin` están protegidas por `AdminLayout.astro`. Si no hay una sesión activa en Supabase, el usuario es redirigido automáticamente a `/admin/login`.

---

### 1.1 Dashboard (`/admin`)
- **Archivo**: [`src/pages/admin/index.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/index.astro)
- **Funcionalidad**:
  - **Tarjetas de Estadísticas**: Muestra el total de clientes registrados, total de vehículos y total de trabajos ingresados en el mes en curso.
  - **Tabla de Últimos Trabajos**: Muestra los 5 trabajos más recientes con fecha, vehículo, tipo y badge de estado. Hacer clic en una fila navega a `/admin/trabajos?view=ID`.
  - **Últimos Clientes**: Muestra los 5 clientes más recientes con acceso rápido a su detalle.
  - **Acciones Rápidas**: Enlaces directos para abrir modales de creación en trabajos, clientes o vehículos.

---

### 1.2 Catálogo de Clientes (`/admin/clientes`)
- **Archivo**: [`src/pages/admin/clientes/index.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/clientes/index.astro)
- **Funcionalidad**:
  - Búsqueda en tiempo real por nombre, apellido, teléfono y RFC.
  - Botón `+ Nuevo Cliente` que abre el modal de registro.
  - Cada fila es cliqueable y navega a `/admin/clientes/detalle?id=X`.
  - Botones de acción en tabla: Ver detalle (ojo), Editar (lápiz) y Eliminar (papelera).
  - Al eliminar un cliente, se advierte que se eliminarán en cascada sus vehículos y trabajos asociados.

---

### 1.3 Detalle de Cliente (`/admin/clientes/detalle?id=X`)
- **Archivo**: [`src/pages/admin/clientes/detalle.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/clientes/detalle.astro)
- **Funcionalidad**:
  - Lee el parámetro `id` de la URL (`new URLSearchParams(window.location.search).get('id')`).
  - Tarjeta superior con avatar, nombre completo, teléfono, correo, domicilio, RFC y fecha de registro.
  - Botón de edición rápida que enlaza al formulario de clientes.
  - **Sección de Vehículos**: Muestra tarjetas con todos los vehículos propiedad del cliente.
  - Botón `+ Agregar Vehículo`: Abre un modal pre-vinculado con el ID de este cliente para asociarle un auto nuevo sin salir de la página.

---

### 1.4 Catálogo de Vehículos (`/admin/vehiculos`)
- **Archivo**: [`src/pages/admin/vehiculos/index.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/vehiculos/index.astro)
- **Funcionalidad**:
  - Búsqueda en tiempo real por marca, modelo, año, VIN o nombre del dueño.
  - Botón `+ Nuevo Vehículo`: Modal con selector de Dueño (cargado de `clientes`) y selector de Marca (cargado de `marcas_vehiculo`).
  - Cada fila es cliqueable y navega a `/admin/vehiculos/detalle?id=X`.
  - Botones de acción: Ver detalle, Editar y Eliminar.

---

### 1.5 Detalle de Vehículo (`/admin/vehiculos/detalle?id=X`)
- **Archivo**: [`src/pages/admin/vehiculos/detalle.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/vehiculos/detalle.astro)
- **Funcionalidad**:
  - Ficha técnica: Marca, Modelo, Año, Kilometraje acumulado y Número de Serie (VIN).
  - Enlace al cliente propietario con acceso directo a su ficha.
  - **Historial de Trabajos**: Tabla completa con todos los servicios realizados a este automóvil ordenados cronológicamente.
  - Botón `+ Nuevo Trabajo` para registrar una orden de servicio directamente sobre este vehículo.

---

### 1.6 Historial y Órdenes de Trabajo (`/admin/trabajos`)
- **Archivo**: [`src/pages/admin/trabajos/index.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/trabajos/index.astro)
- **Funcionalidad Clave**:
  - Filtros de estado: *Todos*, *En proceso*, *Entregados*.
  - Búsqueda por descripción, vehículo o cliente.
  - **Modal de Nuevo Trabajo con Campos Dinámicos**:
    - Al seleccionar un `tipo_trabajo`, la aplicación lee el JSONB `campos_extra` y renderiza automáticamente los campos correspondientes (ej. si es "Servicio Menor", muestra viscosidad, marca de aceite, checkboxes de filtros).
    - Los valores dinámicos se guardan en la columna `detalles` de Supabase.
  - **Creación Rápida Inline (Modales Anidados)**:
    - Si el vehículo no existe, el usuario puede pulsar `+ Rápido` junto al selector de vehículo para registrarlo al momento sin abandonar la orden de trabajo.
    - Si el cliente tampoco existe, el modal rápido de vehículo a su vez permite crear un cliente inline (`#quickClienteModal`).

---

### 1.7 Catálogos del Sistema (`/admin/catalogos`)
- **Archivo**: [`src/pages/admin/catalogos/index.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/catalogos/index.astro)
- **Funcionalidad**:
  - Pestañas para gestionar los 3 catálogos maestros:
    1. **Marcas de Vehículos** (`marcas_vehiculo`): Agregar/editar nombres y alternar estado activo/inactivo.
    2. **Tipos de Trabajo** (`tipos_trabajo`): Administrar nombres, descripciones y visualizar número de campos dinámicos asociados.
    3. **Viscosidades de Aceite** (`viscosidades`): Catálogo de grados SAE.

---

### 1.8 Inicio de Sesión (`/admin/login`)
- **Archivo**: [`src/pages/admin/login.astro`](file:///c:/Users/roymu/OneDrive/Escritorio/Projects/ServicioMecanico/src/pages/admin/login.astro)
- **Funcionalidad**:
  - Tarjeta centrada con campos de Correo y Contraseña.
  - Llama a `supabase.auth.signInWithPassword({ email, password })`.
  - Si el usuario ya cuenta con sesión activa, redirige automáticamente al Dashboard (`/admin`).

---

## 2. Páginas Públicas

- `/` (`src/pages/index.astro`): Redirección o página de inicio.
- `/servicios` (`src/pages/servicios.astro`): Listado público de servicios mecánicos para clientes.
- `/nosotros` (`src/pages/nosotros.astro`): Valores y trayectoria del taller.
- `/contacto` (`src/pages/contacto.astro`): Formulario de contacto, horarios de atención y ubicación.

