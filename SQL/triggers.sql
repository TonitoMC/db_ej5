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
