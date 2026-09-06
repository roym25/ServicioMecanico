-- =============================================
-- Base de datos: Servicio Mecánico
-- Ejecutar en Supabase SQL Editor
-- =============================================

-- 1. Tabla de Clientes
CREATE TABLE clientes (
    id_cliente    SERIAL PRIMARY KEY,
    nombre        VARCHAR(100) NOT NULL,
    apellido      VARCHAR(100) NOT NULL,
    domicilio     VARCHAR(255),
    telefono      VARCHAR(20),
    correo        VARCHAR(150),
    rfc           VARCHAR(13),
    fecha_registro TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Tabla de Vehículos
CREATE TABLE vehiculos (
    id_vehiculo   SERIAL PRIMARY KEY,
    id_cliente    INT NOT NULL REFERENCES clientes(id_cliente) ON DELETE CASCADE,
    marca         VARCHAR(50) NOT NULL,
    modelo        VARCHAR(50) NOT NULL,
    anio          INT NOT NULL,
    km            INT DEFAULT 0,
    numserie      VARCHAR(50),
    fecha_registro TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Tabla de Trabajos (Historial)
CREATE TABLE trabajos (
    id_trabajo    SERIAL PRIMARY KEY,
    id_vehiculo   INT NOT NULL REFERENCES vehiculos(id_vehiculo) ON DELETE CASCADE,
    descripcion   TEXT NOT NULL,
    costo         DECIMAL(10,2) DEFAULT 0,
    km_entrada    INT,
    fecha_ingreso DATE DEFAULT CURRENT_DATE,
    fecha_entrega DATE,
    notas         TEXT,
    fecha_registro TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- Políticas RLS (Row Level Security)
-- Solo usuarios autenticados pueden acceder
-- =============================================

-- Políticas para CLIENTES
CREATE POLICY "Admin puede ver clientes"
    ON clientes FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Admin puede crear clientes"
    ON clientes FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Admin puede editar clientes"
    ON clientes FOR UPDATE
    TO authenticated
    USING (true)
    WITH CHECK (true);

CREATE POLICY "Admin puede eliminar clientes"
    ON clientes FOR DELETE
    TO authenticated
    USING (true);

-- Políticas para VEHICULOS
CREATE POLICY "Admin puede ver vehiculos"
    ON vehiculos FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Admin puede crear vehiculos"
    ON vehiculos FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Admin puede editar vehiculos"
    ON vehiculos FOR UPDATE
    TO authenticated
    USING (true)
    WITH CHECK (true);

CREATE POLICY "Admin puede eliminar vehiculos"
    ON vehiculos FOR DELETE
    TO authenticated
    USING (true);

-- Políticas para TRABAJOS
CREATE POLICY "Admin puede ver trabajos"
    ON trabajos FOR SELECT
    TO authenticated
    USING (true);

CREATE POLICY "Admin puede crear trabajos"
    ON trabajos FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Admin puede editar trabajos"
    ON trabajos FOR UPDATE
    TO authenticated
    USING (true)
    WITH CHECK (true);

CREATE POLICY "Admin puede eliminar trabajos"
    ON trabajos FOR DELETE
    TO authenticated
    USING (true);

