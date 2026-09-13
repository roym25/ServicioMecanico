# Esquema de Base de Datos (Supabase PostgreSQL)

Este documento detalla todas las tablas, columnas, relaciones, restricciones y tipos de datos del proyecto **Servicio Mecánico**.

---

## 1. Tablas del Sistema

### 1.1 `clientes`
Almacena el catálogo de clientes del taller.

| Columna | Tipo | Nulo | Descripción / Restricciones |
| :--- | :--- | :---: | :--- |
| `id_cliente` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `nombre` | `VARCHAR(100)` | NO | Nombre de pila |
| `apellido` | `VARCHAR(100)` | NO | Apellido paterno |
| `apellido_materno` | `VARCHAR(100)` | SÍ | Apellido materno (añadido en v2) |
| `domicilio` | `VARCHAR(255)` | SÍ | Dirección residencial o fiscal |
| `telefono` | `VARCHAR(20)` | SÍ | Teléfono de contacto (10 dígitos en validación) |
| `correo` | `VARCHAR(150)` | SÍ | Correo electrónico |
| `rfc` | `VARCHAR(13)` | SÍ | RFC (12 caracteres moral, 13 físico) |
| `fecha_registro` | `TIMESTAMPTZ` | NO | Valor por defecto: `NOW()` |

---

### 1.2 `vehiculos`
Almacena los vehículos registrados, asociados a un cliente.

| Columna | Tipo | Nulo | Descripción / Restricciones |
| :--- | :--- | :---: | :--- |
| `id_vehiculo` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `id_cliente` | `INT` | NO | `REFERENCES clientes(id_cliente) ON DELETE CASCADE` |
| `marca` | `VARCHAR(50)` | NO | Marca del vehículo (ej. Nissan, Ford) |
| `modelo` | `VARCHAR(50)` | NO | Modelo del vehículo (ej. Sentra, Versa) |
| `anio` | `INT` | NO | Año de fabricación (ej. 2018) |
| `km` | `INT` | NO | Kilometraje acumulado (default `0`) |
| `numserie` | `VARCHAR(50)` | SÍ | Número de Serie / VIN (hasta 17 caracteres) |
| `fecha_registro` | `TIMESTAMPTZ` | NO | Valor por defecto: `NOW()` |

> ⚠️ **ADVERTENCIA CRÍTICA**:
> La columna `color` **NO EXISTE** en la tabla `vehiculos` en Supabase actualmente (genera error PostgreSQL `42703`). No intentes consultar ni insertar el campo `color` hasta que se ejecute la migración SQL correspondiente (`ALTER TABLE vehiculos ADD COLUMN color VARCHAR(50);`).

---

### 1.3 `trabajos`
Historial de servicios y órdenes de trabajo del taller.

| Columna | Tipo | Nulo | Descripción / Restricciones |
| :--- | :--- | :---: | :--- |
| `id_trabajo` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `id_vehiculo` | `INT` | NO | `REFERENCES vehiculos(id_vehiculo) ON DELETE CASCADE` |
| `id_tipo_trabajo` | `INT` | SÍ | `REFERENCES tipos_trabajo(id_tipo) ON DELETE SET NULL` |
| `descripcion` | `TEXT` | NO | Descripción del trabajo realizado |
| `costo` | `DECIMAL(10,2)`| NO | Costo en pesos MXN (default `0.00`) |
| `km_entrada` | `INT` | NO | Kilometraje del vehículo al ingresar al taller |
| `fecha_ingreso` | `DATE` | NO | Fecha de recepción (default `CURRENT_DATE`) |
| `fecha_entrega` | `DATE` | SÍ | Fecha de entrega al cliente (`null` = en proceso) |
| `notas` | `TEXT` | SÍ | Observaciones o diagnósticos adicionales |
| `marca_pieza` | `VARCHAR(100)` | SÍ | Marca de la refacción utilizada |
| `detalles` | `JSONB` | NO | Valores de los campos dinámicos (default `'{}'`) |
| `fecha_registro` | `TIMESTAMPTZ` | NO | Valor por defecto: `NOW()` |

---

### 1.4 `marcas_vehiculo`
Catálogo de marcas activas para los desplegables de registro de vehículos.

| Columna | Tipo | Nulo | Descripción |
| :--- | :--- | :---: | :--- |
| `id_marca` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `nombre` | `VARCHAR(50)` | NO | Nombre único de la marca (`UNIQUE`) |
| `activo` | `BOOLEAN` | NO | Estado del catálogo (default `true`) |

---

### 1.5 `tipos_trabajo`
Catálogo de tipos de servicios disponibles, con definiciones de campos dinámicos.

| Columna | Tipo | Nulo | Descripción |
| :--- | :--- | :---: | :--- |
| `id_tipo` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `nombre` | `VARCHAR(100)` | NO | Nombre del tipo de trabajo |
| `descripcion` | `TEXT` | SÍ | Descripción sugerida para el formulario |
| `campos_extra` | `JSONB` | NO | Definición de campos dinámicos (default `'[]'`) |
| `activo` | `BOOLEAN` | NO | Estado del catálogo (default `true`) |

---

### 1.6 `viscosidades`
Catálogo de viscosidades de aceite de motor para servicios de lubricación.

| Columna | Tipo | Nulo | Descripción |
| :--- | :--- | :---: | :--- |
| `id_viscosidad` | `SERIAL` | NO | Clave primaria (`PRIMARY KEY`) |
| `nombre` | `VARCHAR(20)` | NO | Grado SAE (ej. `5W-30`, `20W-50`, `UNIQUE`) |
| `activo` | `BOOLEAN` | NO | Estado del catálogo (default `true`) |

---

## 2. Estructura de Campos Dinámicos (JSONB)

### Definición en `tipos_trabajo.campos_extra`:
Permite que cada tipo de trabajo defina preguntas o campos específicos sin requerir cambios de esquema en PostgreSQL.
```json
[
  { "nombre": "marca_aceite", "etiqueta": "Marca de aceite", "tipo": "text" },
  { "nombre": "viscosidad", "etiqueta": "Viscosidad", "tipo": "select", "opciones_tabla": "viscosidades" },
  { "nombre": "filtro_aceite", "etiqueta": "Filtro de aceite cambiado", "tipo": "checkbox" },
  { "nombre": "posicion", "etiqueta": "Posición", "tipo": "select", "opciones": ["Delanteras", "Traseras"] }
]
```

### Tipos soportados:
- `"text"`: Input de texto simple.
- `"select"` con `"opciones"`: Select con lista de cadenas estáticas.
- `"select"` con `"opciones_tabla"`: Select que consulta dinámicamente otra tabla de Supabase (ej. `viscosidades`).
- `"checkbox"`: Campo booleano (sí / no).

### Almacenamiento en `trabajos.detalles`:
Al guardar el trabajo, las respuestas se almacenan como un objeto clave-valor en la columna `detalles`:
```json
{
  "marca_aceite": "Mobil 1",
  "viscosidad": "5W-30",
  "filtro_aceite": true,
  "filtro_aire": true
}
```

---

## 3. Consultas con Joins Frecuentes

### Trabajos con datos de Vehículo y Cliente:
```javascript
const { data } = await supabase
  .from('trabajos')
  .select(`
    *,
    tipos_trabajo (nombre),
    vehiculos (
      marca,
      modelo,
      id_cliente,
      clientes (nombre, apellido)
    )
  `)
  .order('fecha_ingreso', { ascending: false });
```

### Vehículos con datos del Dueño:
```javascript
const { data } = await supabase
  .from('vehiculos')
  .select('*, clientes(nombre, apellido)')
  .order('fecha_registro', { ascending: false });
```
