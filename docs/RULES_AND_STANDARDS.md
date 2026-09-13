# Reglas de Desarrollo y Estándares Técnicos

Este documento recopila las reglas obligatorias que deben respetarse en el desarrollo de **Servicio Mecánico**.

---

## 1. Reglas de Terminal y Sistema Operativo

1. **Entorno**: El sistema operativo del usuario es **Windows** y la shell predeterminada es **PowerShell**.
2. **Encadenamiento de comandos**:
   - ❌ **NUNCA** usar `&&` en PowerShell (provoca error de sintaxis).
   - ✅ **SIEMPRE** usar `;` para separar comandos:
     ```powershell
     npm run build; git status
     ```
3. **Comando `cd`**:
   - ❌ **NUNCA** ejecutar comandos `cd` en la terminal. El directorio de trabajo (`Cwd`) siempre debe ser la raíz del proyecto.

---

## 2. Reglas de Astro y JavaScript en el Cliente

1. **Scripts en Componentes Astro (`<script>`)**:
   - En Astro, los scripts del cliente se empaquetan con Vite para el navegador.
   - **No importar** módulos que lean variables de entorno exclusivas del servidor (`process.env` o `import.meta.env` privado).
   - Para Supabase en el cliente, instancia el cliente directamente con la clave anónima pública (`anon key`).
2. **Iconos**:
   - Utilizar cadenas SVG inline con `viewBox="0 0 24 24"`, `fill="none"`, `stroke="currentColor"` y `stroke-width="2"`.
   - Evitar importar iconos dinámicos de librerías en bucles cliente, ya que pueden fallar al empaquetarse estáticamente.

---

## 3. Estándares de Diseño y Modo Oscuro

### A. Paleta de Colores
- **Primary**: `#1E3A5F` (Azul corporativo oscuro).
- **Secondary**: `#E63946` (Rojo mecánico / acento de acción).
- **Accent**: `#F4A261` (Naranja / estados "En proceso").
- **Success**: `#2D6A4F` (Verde / estados "Entregado" o "Activo").
- **Background Claro**: `#F8F9FA`.

### B. Modo Oscuro (Neutro / Carbón)
- ❌ **ESTRICTAMENTE PROHIBIDO** usar tonos azulados (`slate-800`, `slate-900`, `#0f172a`, `#1e293b`).
- ✅ **SIEMPRE** usar tonos neutros carbón/zinc:
  - Fondo general: `#18181b` (zinc-900).
  - Tarjetas y modales: `#202022` o `#27272a` (zinc-800).
  - Bordes: `border-zinc-800` o `border-zinc-700`.

---

## 4. Estándares de Validación de Formularios

Para evitar datos corruptos o errores en la base de datos, todos los formularios deben cumplir:

1. **Teléfono**:
   - 10 dígitos numéricos obligatorios.
   - Limpiar espacios, guiones y paréntesis antes de validar o enviar.
2. **Número de Serie (VIN)**:
   - Máximo 17 caracteres alfanuméricos.
   - Transformar a mayúsculas automáticamente (`uppercase` / `.toUpperCase()`).
   - Los caracteres `I`, `O`, `Q` no existen en VINs estándar para evitar confusiones con `1` y `0`.
3. **Año del Vehículo**:
   - Rango numérico entre `1900` y el año siguiente al actual (`max="2035"`).
   - Atributos HTML: `type="number" min="1900" max="2035"`.
4. **Kilometraje (`km` y `km_entrada`)**:
   - Número entero mayor o igual a `0`.
   - Atributos HTML: `type="number" min="0" required`.
5. **RFC (Registro Federal de Contribuyentes)**:
   - Opcional en el registro de clientes.
   - Si se proporciona: 12 caracteres (persona moral) o 13 caracteres (persona física) en mayúsculas.

---

## 5. Mantenimiento del Grafo de Conocimiento (Graphify)

Este proyecto cuenta con un grafo de conocimiento en `graphify-out/`.
- Después de modificar archivos de código en cualquier sesión, ejecuta:
  ```powershell
  graphify update .
  ```
  *(Esta operación actualiza el AST localmente sin costo de tokens de API).*
- Para verificar que la compilación de Astro sigue intacta:
  ```powershell
  npm run build
  ```

