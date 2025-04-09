DROP TABLE IF EXISTS 
    auditoria_truncates,
    mantenimientos,
    detalles_carritos,
    pedidos,
    accesorios,
    carritos,
    direcciones,
    telefonos,
    instrumentos,
    tecnicos,
    clientes,
    tipos_instrumentos,
    sucursales,
    producto_audit
CASCADE;

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public';

CREATE TABLE producto_audit (
  audit_id SERIAL PRIMARY KEY,
  table_name TEXT NOT NULL,
  operation CHAR(1) NOT NULL,
  changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  record_id INTEGER NOT NULL,
  old_data JSONB,
  new_data JSONB
);



-- 1. Tablas independientes
CREATE TABLE sucursales (
  id SERIAL PRIMARY KEY,
  nombre varchar UNIQUE NOT NULL,
  direccion varchar NOT NULL,
  telefono varchar NOT NULL,
  ciudad varchar NOT NULL
);

CREATE TABLE tipos_instrumentos (
  id SERIAL PRIMARY KEY,
  nombre varchar UNIQUE NOT NULL
);

-- 2. Tablas que dependen de las anteriores
CREATE TABLE clientes (
  id SERIAL PRIMARY KEY,
  nombre varchar NOT NULL,
  email varchar UNIQUE NOT NULL
);

CREATE TABLE tecnicos (
  id SERIAL PRIMARY KEY,
  nombre varchar NOT NULL,
  sucursal int NOT NULL REFERENCES sucursales(id),
  telefono varchar NOT NULL
);

CREATE TABLE instrumentos (
  id SERIAL PRIMARY KEY,
  nombre varchar UNIQUE NOT NULL,
  descripcion text NOT NULL,
  precio decimal NOT NULL,
  marca varchar NOT NULL,
  modelo varchar NOT NULL,
  tipo integer REFERENCES tipos_instrumentos(id)
);

-- 3. Tablas con dependencias secundarias
CREATE TABLE telefonos (
  id SERIAL PRIMARY KEY,
  telefono varchar UNIQUE,
  cliente_id integer NOT NULL REFERENCES clientes(id)
);

CREATE TABLE direcciones (
  id SERIAL PRIMARY KEY,
  cliente_id integer REFERENCES clientes(id),
  casa varchar NOT NULL,
  calle varchar NOT NULL,
  ciudad varchar NOT NULL,
  activa bool NOT NULL
);

CREATE TABLE carritos (
  id SERIAL PRIMARY KEY,
  cliente_id integer NOT NULL REFERENCES clientes(id),
  estado varchar NOT NULL,
  total decimal
);

CREATE TABLE accesorios (
  id SERIAL PRIMARY KEY,
  nombre varchar UNIQUE NOT NULL,
  descripcion text NOT NULL,
  precio decimal NOT NULL,
  tienda_id integer NOT NULL REFERENCES sucursales(id),
  tipo_instrumento_id integer REFERENCES tipos_instrumentos(id)
);

-- 4. Tablas que dependen de múltiples otras
CREATE TABLE pedidos (
  id SERIAL PRIMARY KEY,
  direccion_id integer NOT NULL REFERENCES direcciones(id),
  cliente_id integer NOT NULL REFERENCES clientes(id),
  fecha_pedido timestamp NOT NULL,
  carrito_id integer UNIQUE NOT NULL REFERENCES carritos(id),
  estado varchar NOT NULL
);

CREATE TABLE detalles_carritos (
  id SERIAL PRIMARY KEY,
  carrito_id integer NOT NULL REFERENCES carritos(id),
  instrumento_id integer REFERENCES instrumentos(id),
  accesorio_id integer REFERENCES accesorios(id),
  cantidad integer NOT NULL,
  subtotal float NOT NULL
);

CREATE TABLE mantenimientos (
  id SERIAL PRIMARY KEY,
  cliente_id integer NOT NULL REFERENCES clientes(id),
  instrumento_id integer NOT NULL REFERENCES instrumentos(id),
  tecnico_id integer NOT NULL REFERENCES tecnicos(id),
  fecha_entrada timestamp NOT NULL,
  fecha_salida timestamp,
  descripcion text NOT NULL,
  sucursal_id integer NOT NULL REFERENCES sucursales(id),
  costo decimal NOT NULL
);

CREATE TABLE auditoria_truncates (
    id SERIAL PRIMARY KEY,
    tabla TEXT NOT NULL,        -- TG_TABLE_NAME del trigger
    usuario TEXT NOT NULL,      -- SESSION_USER
    fecha TIMESTAMP NOT NULL    -- CURRENT_TIMESTAMP
);

