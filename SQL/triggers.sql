-- Soft Delete para Direcciones
CREATE FUNCTION soft_delete_direccion()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE direcciones
  SET activa = false
  WHERE id = OLD.id;
  RETURN NULL; 
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
-- TABLA: direcciones
-- EVENTO: Before Delete
-- ACCION: Setea el campo Activa a falso
-- JUSTIFICACION: Se mantiene un record de las direcciones que se han asociado a los clientes,
-- en caso que se borre se puede explicar 'X direccion estaba asociada previamente'. Se hace before delete
-- asi se lleva a cabo ANTES del evento.
-- ALTERNATIVA: Se puede crear una tabla de direcciones_historicas o similar para almacenar las direcciones eliminadas
CREATE TRIGGER trg_soft_delete_direccion
BEFORE DELETE ON direcciones
FOR EACH ROW
EXECUTE FUNCTION soft_delete_direccion()

-- Al borrar un carrito, borrar el pedido asociado para evitar llaves huerfanas
CREATE OR REPLACE FUNCTION delete_pedido_asociado()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM pedidos WHERE carrito_id = OLD.id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
-- TABLA: carritos / pedidos
-- EVENTO: After Delete
-- ACCION: Borra el pedido asociado a algun carrito borrado
-- JUSTIFICACION: Al borrar un carrito la llave foranea dentro de un pedido puede quedar huerfana,
-- llevandonos a tener pedidos sin detalles. Si el carrito ya no nos es util, tampoco nos es util el pedido.
-- Se hace after delete ya que primero se completa la operacion de borrar el carrito y luego el pedido.
-- ALTERNATIVA: Se puede utilizar ON DELETE CASCADE
CREATE TRIGGER trg_delete_pedido_carrito
AFTER DELETE ON carritos
FOR EACH ROW
EXECUTE FUNCTION delete_pedido_asociado();

-- Al intentar truncar una tabla, verificar permisos anteriormente
CREATE OR REPLACE FUNCTION verificar_permiso_truncate()
RETURNS TRIGGER AS $$
BEGIN
  IF SESSION_USER NOT IN ('admin_user') THEN
    RAISE EXCEPTION 'No tienes permisos para TRUNCATE esta tabla.';
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
-- TABLA: Cualquiera
-- EVENTO: Before Truncate
-- ACCION: Verificar permisos, si no cumple no se realiza la accion
-- JUSTIFICACION: Se necesitan comprobar los permisos antes de realizar este tipo de acciones, se debe realizar
-- ANTES de truncar la tabla para evitar que se cumpla esta accion.
-- ALTERNATIVA: Se pueden utilizar permisos de Postgres para manejar las acciones en vez de triggers
CREATE TRIGGER trg_verificar_truncate
BEFORE TRUNCATE ON carritos
FOR EACH STATEMENT
EXECUTE FUNCTION verificar_permiso_truncate();

-- Crear entrada en tabla de logs para cada truncate
CREATE OR REPLACE FUNCTION log_truncate()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO auditoria_truncates(tabla, usuario, fecha)
  VALUES (TG_TABLE_NAME, SESSION_USER, CURRENT_TIMESTAMP);
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
-- TABLA: Cualquiera
-- EVENTO: After Truncare
-- ACCION: Crear una entrada en la tabla de logs para cada truncate
-- JUSTIFICACION: Genera logs sobre quien trunco las tablas, se lleva a cabo DESPUES del evento porque se
-- debe completar antes de llenar los logs
-- ALTERNATIVA: Talvez tener una tabla de logs mas generalizada
CREATE TRIGGER trg_log_truncate
AFTER TRUNCATE ON carritos
EXECUTE FUNCTION log_truncate();

-- Verificacion que exista un (y solo un) instrumento ID o accesorio ID para cada detalle de carrito
-- Trigger BEFORE INSERT
CREATE OR REPLACE FUNCTION validate_cart_detail()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.instrumento_id IS NULL) = (NEW.accesorio_id IS NULL) THEN
      RAISE EXCEPTION 'Cada detalle de pedido debe tener unicamente un ID de instrumento o accesorio';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
-- TABLA: DETALLES CARRITOS
-- EVENTO: Before Insert
-- ACCION: Verificar que haya un instrumento ID o un accesorio ID pero no ambos en un detalle de carrito,
-- evita la transaccion en caso de ser invalida
-- JUSTIFICACION: Mantiene la integridad de los datos, se realiza antes del insert para prevenir acciones invalidas
-- ALTERNATIVA: Utilizar checks
CREATE TRIGGER trg_verify_cart_detail
BEFORE INSERT ON detalles_carritos
FOR EACH ROW EXECUTE FUNCTION validate_cart_detail();

-- Actualizacion de total de carrito y subtotal
CREATE OR REPLACE FUNCTION update_cart_total()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE carritos
  SET total = (
    SELECT SUM(subtotal)
    FROM detalles_carritos
    WHERE carrito_id = NEW.carrito_id
  )
  WHERE id = NEW.carrito_id;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_update_cart_total
AFTER INSERT ON detalles_carritos
FOR EACH ROW EXECUTE FUNCTION update_cart_total();

-- Prevenir actualizar detalles de un pedido completado
-- Before update
CREATE OR REPLACE FUNCTION prevent_completed_cart_updates()
RETURNS TRIGGER AS $$
BEGIN
  IF EXISTS (
    SELECT 1 FROM carritos
    WHERE id = NEW.carrito_id
    AND estado = 'completado'
  ) THEN
      RAISE EXCEPTION 'El carrito ya fue comprado, no se puede modificar';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_lock_completed_carts
BEFORE UPDATE ON detalles_carritos
FOR EACH ROW EXECUTE FUNCTION prevent_completed_cart_updates();

-- Actualiza el total del carrito luego de modificar algun producto / linea
CREATE TRIGGER trg_update_cart_after_update
AFTER UPDATE ON detalles_carritos
FOR EACH ROW EXECUTE FUNCTION update_cart_total();
