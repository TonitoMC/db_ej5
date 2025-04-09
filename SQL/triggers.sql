--soft delete
CREATE FUNCTION soft_delete_direccion()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE direcciones
  SET activa = false
  WHERE id = OLD.id;
  RETURN NULL; 
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_soft_delete_direccion
BEFORE DELETE ON direcciones
FOR EACH ROW
EXECUTE FUNCTION soft_delete_direccion()


--evitar llaves huerfanas (igual sale con un ON DELETE CASCADE pero hay que hacer los triggers xd)
CREATE OR REPLACE FUNCTION delete_pedido_asociado()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM pedidos WHERE carrito_id = OLD.id;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_delete_pedido_carrito
AFTER DELETE ON carritos
FOR EACH ROW
EXECUTE FUNCTION delete_pedido_asociado();


--revisar permisos antes de TRUNCATE
CREATE OR REPLACE FUNCTION verificar_permiso_truncate()
RETURNS TRIGGER AS $$
BEGIN
  IF SESSION_USER NOT IN ('admin_user') THEN
    RAISE EXCEPTION 'No tienes permisos para TRUNCATE esta tabla.';
  END IF;
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_verificar_truncate
BEFORE TRUNCATE ON carritos
FOR EACH STATEMENT
EXECUTE FUNCTION verificar_permiso_truncate();



--loggeo de quien hizo TRUNCATE (era la implementacion mas simple)
CREATE OR REPLACE FUNCTION log_truncate()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO auditoria_truncates(tabla, usuario, fecha)
  VALUES (TG_TABLE_NAME, SESSION_USER, CURRENT_TIMESTAMP);
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;

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
