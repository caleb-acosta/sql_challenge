BEGIN;

\set product_code 22
\set product_quantity 9480
\set user_id 123

-- Consulta para verificar el disponible y verificar si se puede vender el producto
SELECT * FROM products WHERE id = :product_id and CAST(stock AS Integer) > 0 and  available_for_selling = true and CAST(stock AS Integer)>= :product_quantity;

-- Actualizando columna stock
UPDATE products SET stock = CAST(stock AS Integer) - :product_quantity WHERE id = :product_id;  

-- Registrando venta
INSERT INTO sales (id, client_id, product_id, quantity) VALUES (1, :client_id, :product_id, :product_quantity);
