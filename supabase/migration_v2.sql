-- =============================================
-- Migración v2 — Servicio Mecánico
-- Ejecutar en Supabase SQL Editor
-- =============================================

-- =============================================
-- 1. NUEVAS TABLAS DE CATÁLOGOS
-- =============================================

-- Catálogo de marcas de vehículos
CREATE TABLE marcas_vehiculo (
    id_marca    SERIAL PRIMARY KEY,
    nombre      VARCHAR(50) NOT NULL UNIQUE,
    activo      BOOLEAN DEFAULT true
);

-- Catálogo de tipos de trabajo
CREATE TABLE tipos_trabajo (
    id_tipo         SERIAL PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    descripcion     TEXT,
    campos_extra    JSONB DEFAULT '[]',
    activo          BOOLEAN DEFAULT true
);

-- Catálogo de viscosidades de aceite
CREATE TABLE viscosidades (
    id_viscosidad   SERIAL PRIMARY KEY,
    nombre          VARCHAR(20) NOT NULL UNIQUE,
    activo          BOOLEAN DEFAULT true
);

-- =============================================
-- 2. MODIFICACIONES A TABLAS EXISTENTES
-- =============================================

-- Agregar apellido materno a clientes
ALTER TABLE clientes ADD COLUMN IF NOT EXISTS apellido_materno VARCHAR(100);

-- Agregar campos a trabajos
ALTER TABLE trabajos ADD COLUMN IF NOT EXISTS id_tipo_trabajo INT REFERENCES tipos_trabajo(id_tipo) ON DELETE SET NULL;
ALTER TABLE trabajos ADD COLUMN IF NOT EXISTS detalles JSONB DEFAULT '{}';
ALTER TABLE trabajos ADD COLUMN IF NOT EXISTS marca_pieza VARCHAR(100);

-- Hacer km_entrada y fecha_ingreso obligatorios
ALTER TABLE trabajos ALTER COLUMN km_entrada SET NOT NULL;
ALTER TABLE trabajos ALTER COLUMN km_entrada SET DEFAULT 0;
ALTER TABLE trabajos ALTER COLUMN fecha_ingreso SET NOT NULL;

-- =============================================
-- 3. DATOS PREDETERMINADOS
-- =============================================

-- Marcas de vehículos (populares en México)
INSERT INTO marcas_vehiculo (nombre) VALUES
    ('Chevrolet'), ('Nissan'), ('Volkswagen'), ('Toyota'), ('Honda'),
    ('Ford'), ('Kia'), ('Hyundai'), ('Mazda'), ('Suzuki'),
    ('Renault'), ('SEAT'), ('Dodge'), ('RAM'), ('Mitsubishi'),
    ('Jeep'), ('Chrysler'), ('Fiat'), ('MG'), ('JAC'),
    ('Chirey'), ('Peugeot'), ('Citroën'), ('Isuzu'),
    ('Audi'), ('BMW'), ('Mercedes-Benz'), ('Volvo'), ('Lincoln'),
    ('Infiniti'), ('Acura'), ('Lexus'), ('Mini'), ('Land Rover'), ('Porsche')
ON CONFLICT (nombre) DO NOTHING;

-- Viscosidades de aceite
INSERT INTO viscosidades (nombre) VALUES
    ('20W-50'), ('15W-40'), ('10W-30'), ('10W-40'), ('5W-30')
ON CONFLICT (nombre) DO NOTHING;

-- Tipos de trabajo predeterminados con campos extra
INSERT INTO tipos_trabajo (nombre, descripcion, campos_extra) VALUES
(
    'Servicio menor',
    'Cambio de aceite, filtro de aceite, filtro de aire',
    '[
        {"nombre": "marca_aceite", "etiqueta": "Marca de aceite", "tipo": "text"},
        {"nombre": "viscosidad", "etiqueta": "Viscosidad", "tipo": "select", "opciones_tabla": "viscosidades"},
        {"nombre": "filtro_aceite", "etiqueta": "Filtro de aceite cambiado", "tipo": "checkbox"},
        {"nombre": "filtro_aire", "etiqueta": "Filtro de aire cambiado", "tipo": "checkbox"}
    ]'
),
(
    'Servicio mayor',
    'Cambio de aceite, filtro de aceite, filtro de aire, filtro de gasolina y bujías',
    '[
        {"nombre": "marca_aceite", "etiqueta": "Marca de aceite", "tipo": "text"},
        {"nombre": "viscosidad", "etiqueta": "Viscosidad", "tipo": "select", "opciones_tabla": "viscosidades"},
        {"nombre": "filtro_aceite", "etiqueta": "Filtro de aceite cambiado", "tipo": "checkbox"},
        {"nombre": "filtro_aire", "etiqueta": "Filtro de aire cambiado", "tipo": "checkbox"},
        {"nombre": "filtro_gasolina", "etiqueta": "Filtro de gasolina cambiado", "tipo": "checkbox"},
        {"nombre": "bujias", "etiqueta": "Bujías cambiadas", "tipo": "checkbox"}
    ]'
),
(
    'Cambio de balatas',
    'Cambio de balatas delanteras o traseras',
    '[
        {"nombre": "posicion", "etiqueta": "Posición", "tipo": "select", "opciones": ["Delanteras", "Traseras"]},
        {"nombre": "rectificado_rotores", "etiqueta": "Se rectificaron rotores", "tipo": "checkbox"}
    ]'
),
(
    'Cambio de amortiguadores',
    'Cambio de amortiguadores delanteros o traseros',
    '[
        {"nombre": "posicion", "etiqueta": "Posición", "tipo": "select", "opciones": ["Delanteros", "Traseros"]}
    ]'
),
(
    'Cambio de rótulas',
    'Cambio de rótulas izquierda o derecha',
    '[
        {"nombre": "lado", "etiqueta": "Lado", "tipo": "select", "opciones": ["Izquierda", "Derecha"]}
    ]'
),
(
    'Cambio de bieletas',
    'Cambio de bieletas izquierda o derecha',
    '[
        {"nombre": "lado", "etiqueta": "Lado", "tipo": "select", "opciones": ["Izquierda", "Derecha"]}
    ]'
),
(
    'Cambio de masa de rueda',
    'Cambio de masa de rueda',
    '[
        {"nombre": "posicion", "etiqueta": "Posición", "tipo": "select", "opciones": ["Delantera", "Trasera"]},
        {"nombre": "lado", "etiqueta": "Lado", "tipo": "select", "opciones": ["Izquierda", "Derecha"]}
    ]'
),
(
    'Cambio de junta homocinética',
    'Cambio de junta homocinética',
    '[
        {"nombre": "lado", "etiqueta": "Lado", "tipo": "select", "opciones": ["Izquierda", "Derecha"]},
        {"nombre": "ubicacion", "etiqueta": "Ubicación", "tipo": "select", "opciones": ["Lado rueda", "Lado caja"]}
    ]'
),
(
    'Otro',
    'Trabajo personalizado',
    '[]'
);

-- =============================================
-- 4. POLÍTICAS RLS PARA NUEVAS TABLAS
-- =============================================

-- RLS para marcas_vehiculo
ALTER TABLE marcas_vehiculo ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin puede ver marcas" ON marcas_vehiculo FOR SELECT TO authenticated USING (true);
CREATE POLICY "Admin puede crear marcas" ON marcas_vehiculo FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Admin puede editar marcas" ON marcas_vehiculo FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Admin puede eliminar marcas" ON marcas_vehiculo FOR DELETE TO authenticated USING (true);

-- RLS para tipos_trabajo
ALTER TABLE tipos_trabajo ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin puede ver tipos" ON tipos_trabajo FOR SELECT TO authenticated USING (true);
CREATE POLICY "Admin puede crear tipos" ON tipos_trabajo FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Admin puede editar tipos" ON tipos_trabajo FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Admin puede eliminar tipos" ON tipos_trabajo FOR DELETE TO authenticated USING (true);

-- RLS para viscosidades
ALTER TABLE viscosidades ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Admin puede ver viscosidades" ON viscosidades FOR SELECT TO authenticated USING (true);
CREATE POLICY "Admin puede crear viscosidades" ON viscosidades FOR INSERT TO authenticated WITH CHECK (true);
CREATE POLICY "Admin puede editar viscosidades" ON viscosidades FOR UPDATE TO authenticated USING (true) WITH CHECK (true);
CREATE POLICY "Admin puede eliminar viscosidades" ON viscosidades FOR DELETE TO authenticated USING (true);

-- Permitir lectura anónima de catálogos (para los dropdowns del formulario de login)
CREATE POLICY "Anon puede ver marcas" ON marcas_vehiculo FOR SELECT TO anon USING (true);
CREATE POLICY "Anon puede ver tipos" ON tipos_trabajo FOR SELECT TO anon USING (true);
CREATE POLICY "Anon puede ver viscosidades" ON viscosidades FOR SELECT TO anon USING (true);
