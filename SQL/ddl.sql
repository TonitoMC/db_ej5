CREATE TABLE "sucursales" (
  "id" integer PRIMARY KEY,
  "nombre" varchar UNIQUE NOT NULL,
  "direccion" varchar NOT NULL,
  "telefono" varchar NOT NULL,
  "ciudad" varchar NOT NULL
);

CREATE TABLE "clientes" (
  "id" integer PRIMARY KEY,
  "nombre" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL
);

CREATE TABLE "telefonos" (
  "id" integer PRIMARY KEY,
  "telefono" varchar UNIQUE,
  "cliente_id" integer NOT NULL
);

CREATE TABLE "direcciones" (
  "id" integer PRIMARY KEY,
  "cliente_id" integer,
  "casa" varchar NOT NULL,
  "calle" varchar NOT NULL,
  "ciudad" varchar NOT NULL,
  "activa" bool NOT NULL
);

CREATE TABLE "pedidos" (
  "id" integer PRIMARY KEY,
  "direccion_id" integer NOT NULL,
  "cliente_id" integer NOT NULL,
  "fecha_pedido" datetime NOT NULL,
  "carrito_id" integer UNIQUE NOT NULL,
  "estado" varchar NOT NULL
);

CREATE TABLE "carritos" (
  "id" integer PRIMARY KEY,
  "cliente_id" integer NOT NULL,
  "estado" varchar NOT NULL
);

CREATE TABLE "instrumentos" (
  "id" integer PRIMARY KEY,
  "nombre" varchar UNIQUE NOT NULL,
  "descripcion" text NOT NULL,
  "precio" decimal NOT NULL,
  "marca" varchar NOT NULL,
  "modelo" varchar NOT NULL,
  "tipo" integer
);

CREATE TABLE "tipos_instrumentos" (
  "id" integer PRIMARY KEY,
  "nombre" varchar UNIQUE NOT NULL
);

CREATE TABLE "accesorios" (
  "id" integer PRIMARY KEY,
  "nombre" varchar UNIQUE NOT NULL,
  "descripcion" text NOT NULL,
  "precio" decimal NOT NULL,
  "tienda_id" integer NOT NULL,
  "tipo_instrumento_id" integer
);

CREATE TABLE "detalles_carritos" (
  "id" integer PRIMARY KEY,
  "carrito_id" integer NOT NULL,
  "instrumento_id" integer,
  "accesorio_id" integer,
  "cantidad" integer NOT NULL,
  "subtotal" float NOT NULL
);

CREATE TABLE "tecnicos" (
  "id" integer PRIMARY KEY,
  "nombre" varchar NOT NULL,
  "sucursal" int NOT NULL,
  "telefono" varchar NOT NULL
);

CREATE TABLE "mantenimientos" (
  "id" integer PRIMARY KEY,
  "cliente_id" integer NOT NULL,
  "instrumento_id" integer NOT NULL,
  "tecnico_id" integer NOT NULL,
  "fecha_entrada" datetime NOT NULL,
  "fecha_salida" datetime,
  "descripcion" text NOT NULL,
  "sucursal_id" integer NOT NULL,
  "costo" decimal NOT NULL
);

ALTER TABLE "telefonos" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id");

ALTER TABLE "direcciones" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id");

ALTER TABLE "pedidos" ADD FOREIGN KEY ("direccion_id") REFERENCES "direcciones" ("id");

ALTER TABLE "pedidos" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id");

ALTER TABLE "pedidos" ADD FOREIGN KEY ("carrito_id") REFERENCES "carritos" ("id");

ALTER TABLE "carritos" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id");

ALTER TABLE "instrumentos" ADD FOREIGN KEY ("tipo") REFERENCES "tipos_instrumentos" ("id");

ALTER TABLE "accesorios" ADD FOREIGN KEY ("tipo_instrumento_id") REFERENCES "tipos_instrumentos" ("id");

ALTER TABLE "detalles_carritos" ADD FOREIGN KEY ("carrito_id") REFERENCES "carritos" ("id");

ALTER TABLE "detalles_carritos" ADD FOREIGN KEY ("instrumento_id") REFERENCES "instrumentos" ("id");

ALTER TABLE "detalles_carritos" ADD FOREIGN KEY ("accesorio_id") REFERENCES "accesorios" ("id");

ALTER TABLE "tecnicos" ADD FOREIGN KEY ("sucursal") REFERENCES "sucursales" ("id");

ALTER TABLE "mantenimientos" ADD FOREIGN KEY ("cliente_id") REFERENCES "clientes" ("id");

ALTER TABLE "mantenimientos" ADD FOREIGN KEY ("instrumento_id") REFERENCES "tipos_instrumentos" ("id");

ALTER TABLE "mantenimientos" ADD FOREIGN KEY ("tecnico_id") REFERENCES "tecnicos" ("id");

ALTER TABLE "mantenimientos" ADD FOREIGN KEY ("sucursal_id") REFERENCES "sucursales" ("id");
